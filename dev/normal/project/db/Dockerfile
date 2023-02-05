FROM mariadb:10.4 AS img-mariadb

SHELL ["/bin/bash", "-c"]
# ENV DEBCONF_NOWARNINGS yes
# ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -yqq \
    && apt-get install --no-install-recommends \
        mariadb-plugin-spider \
        php \
        php-mysql \
#        php-pdo \
        php-mbstring \
        -yqq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
