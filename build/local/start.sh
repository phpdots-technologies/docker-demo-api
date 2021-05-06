chmod -R 0777 ./storage
chmod -R 0777 ./bootstrap

docker-compose up -d

APPLICATION_IP=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' banxel_members_application)
MYSQLSERVER_IP=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' banxel_members_mysql)

echo "##################################################"
echo "Application Url: http://${APPLICATION_IP}"
echo "MySQL Server IP: ${MYSQLSERVER_IP}"
echo "##################################################"
