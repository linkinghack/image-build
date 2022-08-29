FROM ubuntu:jammy AS rootfs

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends systemd-sysv udev lsb-release cloud-init sudo curl gnupg && \
    rm -rf /var/lib/apt/lists/*

RUN echo "net.bridge.bridge-nf-call-iptables  = 1 \n\
net.bridge.bridge-nf-call-ip6tables = 1 \n\
net.ipv4.ip_forward                 = 1" >> /etc/sysctl.d/k8s.conf

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable" | tee /etc/apt/sources.list.d/docker.list
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends containerd.io && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/containerd && containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' > /etc/containerd/config.toml
RUN systemctl enable containerd

RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends kubelet=1.25.0-00 kubeadm=1.25.0-00 kubectl=1.25.0-00 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-mark hold kubelet kubeadm kubectl

RUN systemctl enable kubelet

RUN sed -i 's+lock_passwd: True+lock_passwd: False\n     passwd: $6$rounds=4096$jW503YJN.qwW2TMm$vCkJw.v7yxX0mgiP5vrM5C9FBYatCD/vsjsWusPf3QGi55nhmRbHQl4JM6Qm0FUMTZyA34VVe/GG/fKG.kQBx/+g' /rootfs/etc/cloud/cloud.cfg
# RUN adduser ubuntu -D
# RUN echo 'root:vmadmin' | chpasswd
# COPY shadow /etc/shadow

RUN apt update \
  && apt install openssh-server -y && systemctl enable ssh \
  && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
  && sed -i 's/#PermitRootLogin prohibit-password/#PermitRootLogin yes/' /etc/ssh/sshd_config


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

# COPY shadow /etc/shadow
