#!/bin/bash

sleep 10s

cd $(dirname $0)
cd create_db
echo $(pwd)

php 01_RegMainTag.php > /var/log/initdb/01_RegMainTag.log
php 02_RegUsers.php > /var/log/initdb/02_RegUsers.log
php 03_RegThreads.php > /var/log/initdb/03_RegThreads.log
