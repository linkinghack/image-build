docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD

# build eosio-cdt.181 base image
# docker build -t linkinghack/eos-cdt-1.8.1-base:ubuntu18.04 -f ./dockerfiles/eos-cdt.181.base.Dockerfile ./context;
# docker push linkinghack/eos-cdt-1.8.1-base:ubuntu18.04;

# build cloud ide images
docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/go-code-server:1.17 -f ./dockerfiles/cloud-ide/go.Dockerfile ./dockerfiles/cloud-ide --push;

