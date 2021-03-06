#!/bin/bash

echo "CREATE USER 'spider'@'%' IDENTIFIED BY '${MYSQL_SPIDER_PASSWORD}';" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}

echo "GRANT ALL PRIVILEGES ON *.* TO 'spider'@'%' IDENTIFIED BY '${MYSQL_SPIDER_PASSWORD}' WITH GRANT OPTION;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}

echo "FLUSH PRIVILEGES;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}
