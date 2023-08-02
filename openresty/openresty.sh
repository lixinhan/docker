#版本
OPENRESTY_VERSION=1.21.4.2
#外漏端口
OPENRESTY_PORT=80
#定义基础路径
BASE_PATH=/Users/lixinhan/Desktop/docker/openresty
#容器名称
CONTAINER_NAME=openresty${OPENRESTY_VERSION}
#镜像名称
IMAGE_NAME=openresty/openresty:${OPENRESTY_VERSION}-0-alpine-fat

if [ ! -d "${BASE_PATH}" ]; then
mkdir ${BASE_PATH}
cd ${BASE_PATH}
mkdir conf log
fi
docker run --name ${CONTAINER_NAME} -p 80:80 -d ${IMAGE_NAME}
docker cp ${CONTAINER_NAME}:/etc/nginx/conf.d/. ${BASE_PATH}/conf
docker cp ${CONTAINER_NAME}:/usr/local/openresty/nginx/logs/. ${BASE_PATH}/log
docker rm -f ${CONTAINER_NAME}
docker run \
-d \
--name ${CONTAINER_NAME} \
-p ${OPENRESTY_PORT}:80 \
-v ${BASE_PATH}/conf/:/etc/nginx/conf.d/ \
-v ${BASE_PATH}/log/:/usr/local/openresty/nginx/logs/ \
--restart=always \
${IMAGE_NAME}
