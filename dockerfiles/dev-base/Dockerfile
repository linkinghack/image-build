FROM buildpack-deps:bullseye AS main

# Install basic build tools
# Configure locale (required for Python)
# NOTE: Do NOT move it from here as it could have global implications
RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        git \
        make \
        unzip \
        # The tools in this package are used when installing packages for Python
        build-essential \
        # Required for Microsoft SQL Server
        unixodbc-dev \
        # Required for PostgreSQL
        libpq-dev \
        # Required for mysqlclient
        default-libmysqlclient-dev \
        # Required for ts
        moreutils \
        rsync \
        zip \
        libgdiplus \
        jq \
        # By default pip is not available in the buildpacks image
        python-pip-whl \
        python3-pip \
        #.NET Core related pre-requisites
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        libncurses5 \
        liblttng-ust0 \
        libssl-dev \
        libstdc++6 \
        zlib1g \
        libuuid1 \
        libunwind8 \
        sqlite3 \
        libsqlite3-dev \
        software-properties-common \
    && rm -rf /var/lib/apt/lists/* \
    # This is the folder containing 'links' to benv and build script generator
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends python2 \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install pip --upgrade \
    && apt-get install -y --no-install-recommends \
        libargon2-0 \
        libonig-dev \
    &&  apt-get install jekyll -y --no-install-recommends

# NOTE: Place only folders whose size does not extrememly effect the perf of building this image
# since this intermediate stage is copied to final stage.
# For example, if we put yarn-cache here it is going to impact perf since it more than 500MB
FROM main AS intermediate
# COPY --from=mcr.microsoft.com/oryx/build:vso-debian-bullseye /opt/tmp /opt/tmp
# COPY --from=oryxdevmcr.azurecr.io/private/oryx/buildscriptgenerator /opt/buildscriptgen/ /opt/buildscriptgen/
COPY ./build /opt/tmp/build
COPY ./images /opt/tmp/images

FROM main AS final

# add an environment variable to determine debian_flavor
# to correctly download platform sdk during platform installation
ENV DEBIAN_FLAVOR="bullseye"
# Set sdk storage base url
ENV ORYX_SDK_STORAGE_BASE_URL="https://oryx-cdn.microsoft.io"

COPY --from=intermediate /opt /opt

# Docker has an issue with variable expansion when all are used in a single ENV command.
# For example here the $LASTNAME in the following example does not expand to JORDAN but instead is empty: 
#   ENV LASTNAME="JORDAN" \
#       NAME="MICHAEL $LASTNAME"
#
# Even though this adds a new docker layer we are doing this 
# because we want to avoid duplication (which is always error-prone)

RUN set -ex \
    && chmod -R a+x /opt/tmp \
    && tmpDir="/opt/tmp" \
    && imagesDir="$tmpDir/images" \
    && buildDir="$tmpDir/build" \
    # https://github.com/docker-library/python/issues/147
    && PYTHONIOENCODING="UTF-8" \    
    # new next line
    && add-apt-repository --remove ppa:xapienz/curl34 \
    && apt-get update \
    && apt-get upgrade -y \
    # It's not clear whether these are needed at runtime...
    && apt-get install -y --no-install-recommends \
        tk-dev \
        uuid-dev \
        gnupg \
    && rm -rf /var/lib/apt/lists/* \
    # Install Node
    && . $buildDir/__nodeVersions.sh \
    && $imagesDir/installNode.sh $NODE14_VERSION \
    && $imagesDir/installNode.sh $NODE16_VERSION \
    && $imagesDir/installNode.sh $NODE19_VERSION \
    && $imagesDir/receiveGpgKeys.sh 6A010C5166006599AA17F08146C2130DFD2497F5 \
    # Install Python SDKs
    # Upgrade system python
    && mkdir -p /home/devspace/.python \
    && pip install --upgrade cython \
    && pip3 install --upgrade cython \
    && rm -f /etc/apt/sources.list.d/buster.list

# ENV ORYX_PATHS="/opt/oryx:/opt/nodejs/lts/bin:/opt/dotnet/lts:/opt/python/latest/bin:/opt/php/lts/bin:/opt/php-composer:/opt/yarn/stable/bin:/opt/hugo/lts::/opt/java/lts/bin:/opt/maven/lts/bin:/opt/ruby/lts/bin"

ENV  DYNAMIC_INSTALL_ROOT_DIR="/opt"

# install few more tools for VSO
# RUN gem install bundler rake --backtrace
# RUN apt-get update \
#     && apt-get install jekyll -y --no-install-recommends

RUN groupadd -g 1000 devspace
RUN useradd -u 1000 -g devspace devspace
RUN chown -R devspace:devspace /home/devspace/
RUN chown -R devspace:devspace /opt/

ENV NUGET_XMLDOC_MODE="skip" \
    # VSO requires user installed tools to be preferred over Oryx installed tools
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE="1" \
    NUGET_PACKAGES="/var/nuget" \
    ENABLE_DYNAMIC_INSTALL="true" \
    PYTHONIOENCODING="UTF-8" \
    LANG="C.UTF-8" \
    LANGUAGE="C.UTF-8" \
    LC_ALL="C.UTF-8"

ENTRYPOINT [ "benv" ]
