#版本
REDIS_VERSION=latest
#外漏端口
REDIS_PORT=6379
#容器名称
CONTAINER_NAME=redis-${REDIS_VERSION}
#镜像名称
IMAGE_NAME=redis:${REDIS_VERSION}

docker run \
-d \
--name ${CONTAINER_NAME} \
-p ${REDIS_PORT}:6379 \
--restart=always \
${IMAGE_NAME}
