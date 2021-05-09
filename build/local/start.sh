chmod -R 0777 ./storage
chmod -R 0777 ./bootstrap

docker-compose up -d

APPLICATION_IP=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' demo_api)
MYSQLSERVER_IP=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' demo_api_mysql)

echo "##################################################"
echo "Application Url: http://${APPLICATION_IP}"
echo "MySQL Server IP: ${MYSQLSERVER_IP}"
echo "##################################################"
