FROM ubuntu:jammy AS rootfs
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable" | tee /etc/apt/sources.list.d/docker.list
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends containerd.io && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/containerd && containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' > /etc/containerd/config.toml
RUN sed -i 's|k8s.gcr.io/pause:3.6|artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/pause:3.8|g' /etc/containerd/config.toml \
  && sed -i 's|registry.k8s.io/pause:3.6|artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/pause:3.8|g' /etc/containerd/config.toml \
  && sed -i 's|registry.k8s.io/pause:3.8|artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/pause:3.8|g' /etc/containerd/config.toml \
  && sed -i 's|registry.k8s.io/pause:3.8|artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/pause:3.8|g' /etc/containerd/config.toml
RUN systemctl enable containerd


FROM smartxworks/capch-rootfs-cdi-1.24.0
COPY --from=rootfs /etc/containerd/config.toml /etc/containerd/config.toml
