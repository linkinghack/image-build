docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD

# build eosio-cdt.181 base image
docker build -t linkinghack/eos-cdt-1.8.1-base:ubuntu18.04 -f ./dockerfiles/eos-cdt.181.base.Dockerfile .;
docker push linkinghack/eos-cdt-1.8.1-base:ubuntu18.04;
