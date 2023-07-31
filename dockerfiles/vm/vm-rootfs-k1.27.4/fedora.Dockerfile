FROM fedora:38 AS rootfs

RUN dnf update -y && \
    dnf install -y systemd-sysv udev redhat-lsb-core cloud-init sudo curl gnupg dnf-plugins-core \
    && systemctl enable cloud-init

## Systemd utils
RUN dnf install -y xfsprogs vim net-tools dnsutils conntrack socat nftables \
  && systemctl enable nftables

RUN echo "overlay \n\
br_netfilter" \
  >> /etc/modules-load.d/k8s.conf

RUN echo "net.bridge.bridge-nf-call-iptables  = 1 \n\
net.bridge.bridge-nf-call-ip6tables = 1 \n\
net.ipv4.ip_forward                 = 1" >> /etc/sysctl.d/k8s.conf

RUN dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
#     echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable" | tee /etc/apt/sources.list.d/docker.list
# RUN apt-get update -y && \
#     apt-get install -y containerd.io && \
#     rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/containerd && containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' > /etc/containerd/config.toml
RUN sed -i 's|k8s.gcr.io/pause:3.6|artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/pause:3.9|g' /etc/containerd/config.toml \
  && sed -i 's|registry.k8s.io/pause:3.6|artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/pause:3.9|g' /etc/containerd/config.toml \
  && sed -i 's|k8s.gcr.io/pause:3.8|artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/pause:3.9|g' /etc/containerd/config.toml \
  && sed -i 's|registry.k8s.io/pause:3.8|artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/pause:3.9|g' /etc/containerd/config.toml
RUN systemctl enable containerd \
  && systemctl enable docker

# RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
#     echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
# RUN apt-get update -y && \
#     apt-get install -y kubelet=1.26.1-00 kubeadm=1.26.1-00 kubectl=1.26.1-00 && \
#     rm -rf /var/lib/apt/lists/* && \
#     apt-mark hold kubelet kubeadm kubectl
# RUN cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo \
#   [kubernetes] \
#   name=Kubernetes \
#   baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch \
#   enabled=1 \
#   gpgcheck=1 \
#   gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg \
#   exclude=kubelet kubeadm kubectl \
#   EOF
COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo
RUN dnf install -y kubeadm-1.27.4-0 kubelet-1.27.4-0 kubectl-1.27.4-0 --disableexcludes=kubernetes

RUN sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

RUN systemctl enable kubelet

RUN dnf update \
  && dnf install openssh-server -y && systemctl enable ssh \
  && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
  && sed -i 's/#PermitRootLogin prohibit-password/#PermitRootLogin yes/' /etc/ssh/sshd_config

## compatible with kubernetes 1.25
# RUN update-alternatives --set iptables /usr/sbin/iptables-legacy \
#     && update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

RUN echo 'net.ipv4.conf.lxc*.rp_filter = 0' > /etc/sysctl.d/99-override_cilium_rp_filter.conf

FROM smartxworks/virtink-container-rootfs-base

COPY --from=rootfs / /rootfs
RUN ln -sf ../run/systemd/resolve/stub-resolv.conf /rootfs/etc/resolv.conf
RUN echo -e "127.0.0.1 localhost \n\
::1     localhost ip6-localhost ip6-loopback \n\
fe00::0 ip6-localnet \n\
fe00::0 ip6-mcastprefix \n\
fe00::1 ip6-allnodes \n\
fe00::2 ip6-allrouters" > /rootfs/etc/hosts
