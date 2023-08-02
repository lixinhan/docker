#定义mysql版本
MYSQL_VERSION=5.7
#定义mysql密码
MYSQL_PASSWORD=111111
#定义mysql暴露的端口
MYSQL_PORT=3306
#定义基础路径
BASE_PATH=/Users/lixinhan/Desktop/docker/mysql${MYSQL_VERSION}
#容器名称
CONTAINER_NAME=mysql${MYSQL_VERSION}
IMAGE_NAME=mysql:${MYSQL_VERSION}
#创建存储目录
if [ ! -d "${BASE_PATH}" ]; then
mkdir ${BASE_PATH}
cd ${BASE_PATH}
mkdir conf log data
#创建基础镜像
docker run  -d --name ${CONTAINER_NAME} -p ${MYSQL_PORT}:3306 -e MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD} ${IMAGE_NAME}
echo "创建基础镜像"
#移动配置文件
docker cp ${CONTAINER_NAME}:/etc/mysql/. ${BASE_PATH}/conf
docker cp ${CONTAINER_NAME}:/var/log/. ${BASE_PATH}/log
docker cp ${CONTAINER_NAME}:/var/lib/mysql/. ${BASE_PATH}/data
echo "移动配置文件"
#删除基础镜像
docker rm -f ${CONTAINER_NAME}
echo "删除基础镜像"
else
echo "已存在目录没有初始化数据，如需初始化数据，可以删除'${BASE_PATH}'目录"
fi

if [ `docker ps -a|grep  mysql5.7|wc -l` -eq 0 ];then
#创建正式使用的镜像
docker run \
 -d \
--name ${CONTAINER_NAME} \
-e MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD} \
-p ${MYSQL_PORT}:3306 \
-v ${BASE_PATH}/conf:/etc/mysql \
-v ${BASE_PATH}/log:/var/log \
-v ${BASE_PATH}/data:/var/lib/mysql \
--restart=always \
${IMAGE_NAME}
echo  "创建镜像成功"
else
echo  "镜像已存在，没有重新创建"
fi
