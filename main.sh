docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD

# build eosio-cdt.181 base image
# docker build -t linkinghack/eos-cdt-1.8.1-base:ubuntu18.04 -f ./dockerfiles/eos-cdt.181.base.Dockerfile ./context;
# docker push linkinghack/eos-cdt-1.8.1-base:ubuntu18.04;

# build cloud ide images
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/go-code-server:go1.18-code4.4.0-v1.3 -f ./dockerfiles/cloud-ide/go.Dockerfile ./dockerfiles/cloud-ide --push;
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/java-code-server:java8-11-18-code4.4.0-v1.3 -f ./dockerfiles/cloud-ide/java.Dockerfile ./dockerfiles/cloud-ide --push;


# build dbg-tool
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/dbg-tool:v1.4 -f ./dockerfiles/dbg-tool/Dockerfile ./dockerfiles/dbg-tool --push;

# build webproc-dnsmasq
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/webproc-dnsmasq:v1.0 -f ./dockerfiles/dnsmasq/Dockerfile ./dockerfiles/dnsmasq --push;


# build enhanced base image
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/dev-container:220726 -f ./dockerfiles/base-img/dev-base.Dockerfile ./dockerfiles/base-img/ --push;
# docker build -t linkinghack/dev-container:220726 -f ./dockerfiles/base-img/dev-base.Dockerfile ./dockerfiles/base-img/;
# docker push linkinghack/dev-container:220726;

# build VM base image for Virtink VM for ClusterAPI clusters
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs:k125-4 -f ./dockerfiles/vm/vm-rootfs-k1.25/Dockerfile ./dockerfiles/vm/vm-rootfs-k1.25 --push;
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs:k124-0 -f ./dockerfiles/vm/vm-rootfs-k1.24.0/Dockerfile ./dockerfiles/vm/vm-rootfs-k1.24.0 --push;
docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs-cdi:k125-4 -f ./dockerfiles/vm/cdi.Dockerfile ./dockerfiles/vm --push;

# build NicTool image
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/nictool:221123 -f ./dockerfiles/nictool/Dockerfile ./dockerfiles/nictool --push;