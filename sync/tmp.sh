
set -xeu
docker pull --platform=linux/arm64 docker.io/library/eclipse-temurin:17-jre-jammy
docker tag  docker.io/library/eclipse-temurin:17-jre-jammy artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/library/eclipse-temurin:17-jre-jammy-arm64
docker push artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/library/eclipse-temurin:17-jre-jammy-arm64

docker pull --platform=linux/amd64 docker.io/library/eclipse-temurin:17-jre-jammy
docker tag  docker.io/library/eclipse-temurin:17-jre-jammy artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/library/eclipse-temurin:17-jre-jammy-amd64
docker push artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/library/eclipse-temurin:17-jre-jammy-amd64

docker manifest rm artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/library/eclipse-temurin:17-jre-jammy || echo "manifest does not exists, now create it"
docker manifest create artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/library/eclipse-temurin:17-jre-jammy artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/library/eclipse-temurin:17-jre-jammy-arm64 artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/library/eclipse-temurin:17-jre-jammy-amd64
docker manifest push artifactory.dep.devops.cmit.cloud:20101/tools/multi-arch/library/eclipse-temurin:17-jre-jammy
