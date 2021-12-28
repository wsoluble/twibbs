# https://github.com/AnalogJ/docker-cron

# FROM debian:buster-slim
FROM ubuntu

# ENV DEBIAN_FRONTEND noninteractive

# RUN apt-get update && apt-get install --no-install-recommends \
RUN apt-get update \
    && apt-get install tzdata -y \
    && apt-get install -y \
        php \
        php-mysql \
        php-mbstring \
        php-curl \
        cron \
    && which cron \
    && rm -rf /etc/cron.*/* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 空のファイルを作成しておかないと、volumesで空のディレクトリとなる
# RUN mkdir -p /output/
# RUN touch /output/sitemap.xml

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cron","-f", "-l", "2"]
