# docker cp ./project/db_spider/src/test/test_mysql_ping.sh cid:/

# mysqladmin -uroot -pmeteor shutdown

until mysqladmin ping -uroot -p${MYSQL_ROOT_PASSWORD} --silent; do
  echo 'waiting for mysqld to be connectable...'
  sleep 2
done