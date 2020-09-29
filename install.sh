#/bin/bash

PROXY_PATH=/cnt/.proxy
PWD=$(pwd)

if [ ! -d /cnt ]
then
    mkdir /cnt
fi

git clone https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion.git $PROXY_PATH

touch ${PROXY_PATH}/.env

echo "NGINX_WEB=nginx-web" >> ${PROXY_PATH}/.env
echo "DOCKER_GEN=nginx-gen" >> ${PROXY_PATH}/.env
echo "LETS_ENCRYPT=nginx-letsencrypt" >> ${PROXY_PATH}/.env
echo "IP=0.0.0.0" >> ${PROXY_PATH}/.env
echo "NETWORK=proxy" >> ${PROXY_PATH}/.env
echo "NGINX_FILES_PATH=./nginx-data" >> ${PROXY_PATH}/.env

curl https://raw.githubusercontent.com/archlemon/docker-proxy-env/master/docker-compose.override.yml >> ${PROXY_PATH}/docker-compose.override.yml
curl https://raw.githubusercontent.com/archlemon/docker-proxy-env/master/proxy.conf >> ${PROXY_PATH}/proxy.conf

cd $PROXY_PATH

${PROXY_PATH}/start.sh

cd $PWD
