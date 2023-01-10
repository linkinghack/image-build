#!/bin/bash
set -ex

echo
# echo "Installing .NET Core SDK $DOTNET_SDK_VER from $sdkStorageAccountUrl ..."
echo "Installing .NET Core SDK with package manager"
echo

debianFlavor="$DEBIAN_FLAVOR"

fileName="dotnet.tar.gz"

if [ -z "$debianFlavor" ]; then
    # Use default sdk file name
    fileName="$PLATFORM_NAME-$VERSION.tar.gz"
    # default as bullseye
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
elif [ "$debianFlavor" == "buster" ]; then
    ## Debian 10 
    # Use default sdk file name
    fileName="dotnet-$DOTNET_SDK_VER.tar.gz"
    wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
else
    fileName="dotnet-$debianFlavor-$DOTNET_SDK_VER.tar.gz"
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
fi

## Trust Microsoft keys
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

## Install Dotnet Core SDK 7.0
apt-get update && \
apt-get install -y wget \
apt-get install -y dotnet-sdk-3.1 \
apt-get install -y dotnet-sdk-7.0

# downloadFileAndVerifyChecksum dotnet $DOTNET_SDK_VER $fileName $sdkStorageAccountUrl

# globalJsonContent="{\"sdk\":{\"version\":\"$DOTNET_SDK_VER\"}}"

# If the version is a preview version, then trim out the preview part
# Example: 3.0.100-preview4-011223 will be changed to 3.0.100
# DOTNET_SDK_VER=${DOTNET_SDK_VER%%-*}

SDK_DIR=/opt/dotnet
DOTNET_SDK_VER=$(dotnet --version)
# DOTNET_DIR=$SDK_DIR/$DOTNET_SDK_VER
mkdir -p $DOTNET_DIR
# tar -xzf $fileName -C $DOTNET_DIR
# rm $fileName

# declare -x dotnet=$SDK_DIR/$DOTNET_SDK_VER/dotnet
# export dotnet

# Install MVC template based packages
if [ "$INSTALL_PACKAGES" == "true" ]
then
    echo
    echo Installing MVC template based packages ...
    mkdir warmup
    cd warmup
    # echo "$globalJsonContent" > global.json
    $dotnet new mvc
    $dotnet restore
    cd ..
    rm -rf warmup
fi

if [ "$INSTALL_TOOLS" == "true" ]; then
    toolsDir="$SDK_DIR/$DOTNET_SDK_VER/tools"
    mkdir -p "$toolsDir"
    dotnet tool install --tool-path "$toolsDir" dotnet-sos
    chmod +x "$toolsDir/dotnet-sos"
    dotnet tool install --tool-path "$toolsDir" dotnet-trace
    chmod +x "$toolsDir/dotnet-trace"
    dotnet tool install --tool-path "$toolsDir" dotnet-dump
    chmod +x "$toolsDir/dotnet-dump"
    dotnet tool install --tool-path "$toolsDir" dotnet-counters
    chmod +x "$toolsDir/dotnet-counters"
    dotnet tool install --tool-path "$toolsDir" dotnet-monitor --version 6.*
    chmod +x "$toolsDir/dotnet-monitor"
fi
