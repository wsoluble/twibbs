#!/bin/bash

# install Spider Storage Engin (サービス起動時に最初に実行される) mariadb:10.5以降は不要

# install
echo "source /usr/share/mysql/install_spider.sql;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}

# spider_same_server_link
# echo "SET GLOBAL spider_same_server_link=1;" | mysql -uroot -p${MYSQL_ROOT_PASSWORD}

# server
echo "CREATE SERVER master FOREIGN DATA WRAPPER mysql OPTIONS (HOST '${MYSQL_HOST_NAME_MASTER}', PORT 3306, USER 'spider', PASSWORD '${MYSQL_SPIDER_PASSWORD}');" | mysql -uroot -p$MYSQL_ROOT_PASSWORD

# バックグラウンドで処理するので次の処理を始めるまで待つ
sleep 10s

# mariadb起動を待つ処理 (使わない)
<< COMMENTOUT
until (mysqladmin ping -uroot -p${MYSQL_ROOT_PASSWORD} --silent | grep "is alive")
do
    echo 'waiting for mysqld to be connectable...'
    sleep 2;
done
COMMENTOUT
