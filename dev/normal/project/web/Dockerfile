# FROM php:7.3-apache AS img-php (/login/callbackにてセッションクッキーが取得できない不具合)

# コンテナにログインして以下のコマンドを実行してOSを確認
# root@web-server:/var/www# cat /etc/issue
# Debian GNU/Linux 9
FROM php:5.6-apache AS img-php

SHELL ["/bin/bash", "-c"]

#ENV DEBCONF_NOWARNINGS yes
ENV DEBIAN_FRONTEND noninteractive
RUN docker-php-ext-install pdo_mysql 

# [dir] apache: /etc/apache2
COPY ./sites-available/ /etc/apache2/sites-available
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

# [dir] public: /var/www/public
# RUN mkdir -p /var/www/public
# COPY ./public/ /var/www/public
# 空のファイルを作成しておかないと、volumesで空のディレクトリとなる
# RUN touch /var/www/public/sitemap.xml

# [dir] app: /var/www/app
# RUN mkdir -p /var/www/app
# COPY ./app/ /var/www/app
