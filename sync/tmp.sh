
set -xeu
docker pull --platform=linux/arm64 docker.io/envoyproxy/envoy:v1.24.0
docker tag  docker.io/envoyproxy/envoy:v1.24.0 artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/envoyproxy/envoy:v1.24.0-arm64
docker push artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/envoyproxy/envoy:v1.24.0-arm64

docker pull --platform=linux/amd64 docker.io/envoyproxy/envoy:v1.24.0
docker tag  docker.io/envoyproxy/envoy:v1.24.0 artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/envoyproxy/envoy:v1.24.0-amd64
docker push artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/envoyproxy/envoy:v1.24.0-amd64

docker manifest create artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/envoyproxy/envoy:v1.24.0 artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/envoyproxy/envoy:v1.24.0-arm64 artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/envoyproxy/envoy:v1.24.0-amd64
docker manifest push artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/envoyproxy/envoy:v1.24.0
