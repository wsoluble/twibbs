#!/bin/bash

cd $(dirname $0)

chmod 755 ./logs/db/
chown 999:999 ./logs/db/

chmod 755 ./logs/initdb/
chown 999:999 ./logs/initdb/

chmod 755 ./logs/cron/
chown 0:0 ./logs/cron/

chmod 755 -R ./project/cron/cron.d
chown 0:0 -R ./project/cron/cron.d
chmod 755 -R ./project/cron/script
chown 0:0 -R ./project/cron/script

# chmod 755 -R ./project/web/public/
# chown 33:33 -R ./project/web/public/

# chmod 755 -R ./project/volumes/web/public/
# chown 33:33 -R ./project/volumes/web/public/
