
set -xeu
docker pull --platform=linux/arm64 registry.k8s.io/kube-proxy:v1.27.4
docker tag  registry.k8s.io/kube-proxy:v1.27.4 artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/kube-proxy:v1.27.4-arm64
docker push artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/kube-proxy:v1.27.4-arm64

docker pull --platform=linux/amd64 registry.k8s.io/kube-proxy:v1.27.4
docker tag  registry.k8s.io/kube-proxy:v1.27.4 artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/kube-proxy:v1.27.4-amd64
docker push artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/kube-proxy:v1.27.4-amd64

docker manifest rm artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/kube-proxy:v1.27.4 || echo "manifest does not exists, now create it"
docker manifest create artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/kube-proxy:v1.27.4 artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/kube-proxy:v1.27.4-arm64 artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/kube-proxy:v1.27.4-amd64
docker manifest push artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/kube-proxy:v1.27.4
