ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.18

FROM docker.io/tiredofit/unit:${DISTRO}-${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

ARG PHP_BASE

ENV PHP_BASE=${PHP_BASE:-"8.2"} \
    PHP_ENABLE_APCU=TRUE \
    PHP_ENABLE_BCMATH=TRUE \
    PHP_ENABLE_BZ2=TRUE \
    PHP_ENABLE_CTYPE=TRUE \
    PHP_ENABLE_CURL=TRUE \
    PHP_ENABLE_DOM=TRUE \
    PHP_ENABLE_EXIF=TRUE \
    PHP_ENABLE_FILEINFO=TRUE \
    PHP_ENABLE_GD=TRUE \
    PHP_ENABLE_ICONV=TRUE \
    PHP_ENABLE_IMAP=TRUE \
    PHP_ENABLE_INTL=TRUE \
    PHP_ENABLE_MBSTRING=TRUE \
    PHP_ENABLE_MYSQLI=TRUE \
    PHP_ENABLE_MYSQLND=TRUE \
    PHP_ENABLE_OPCACHE=TRUE \
    PHP_ENABLE_OPENSSL=TRUE \
    PHP_ENABLE_PDO=TRUE \
    PHP_ENABLE_PDO_MYSQL=TRUE \
    PHP_ENABLE_PGSQL=TRUE \
    PHP_ENABLE_PHAR=TRUE \
    PHP_ENABLE_SESSION=TRUE \
    PHP_ENABLE_SIMPLEXML=TRUE \
    PHP_ENABLE_TOKENIZER=TRUE \
    PHP_ENABLE_XML=TRUE \
    PHP_ENABLE_XMLREADER=TRUE \
    PHP_ENABLE_XMLWRITER=TRUE \
    CONTAINER_NAME=unit-php-app \
    CONTAINER_ENABLE_MESSAGING=TRUE \
    UNIT_ENABLE_CREATE_SAMPLE_HTML=FALSE \
    IMAGE_NAME="tiredofit/unit-php" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-unit-php/"

### Dependency Installation
RUN case "${PHP_BASE}" in \
       8.2 ) export php_folder="82" export build_gnupg=true ;; \
       8.1 ) export php_folder="81" export build_gnupg=true ;; \
       *) export php_folder=${PHP_BASE:0:1} ; export build_gnupg=false ;; \
    esac ; \
    export PHP_8_2_RUN_DEPS=" \
                            gnu-libiconv \
                            mariadb-connector-c \
                            php82 \
                            php82-bcmath \
                            php82-brotli \
                            php82-bz2 \
                            php82-calendar \
                            php82-cli \
                            php82-common \
                            php82-ctype \
                            php82-curl \
                            php82-dba \
                            php82-dom \
                            php82-embed \
                            php82-enchant \
                            php82-exif \
                            php82-ffi \
                            php82-fileinfo \
                            php82-ftp \
                            php82-gd \
                            php82-gettext \
                            php82-gmp \
                            php82-iconv \
                            php82-imap \
                            php82-intl \
                            php82-ldap \
                            php82-litespeed \
                            php82-mbstring \
                            php82-mysqli \
                            php82-mysqlnd \
                            php82-odbc \
                            php82-opcache \
                            php82-openssl \
                            php82-pcntl \
                            php82-pdo \
                            php82-pdo_dblib \
                            php82-pdo_mysql \
                            php82-pdo_odbc \
                            php82-pdo_pgsql \
                            php82-pdo_sqlite \
                            php82-pear \
                            php82-pecl-amqp \
                            php82-pecl-apcu \
                            php82-pecl-ast \
                            php82-pecl-couchbase \
                            php82-pecl-igbinary \
                            php82-pecl-imagick \
                            php82-pecl-lzf \
                            php82-pecl-maxminddb \
                            php82-pecl-memcache \
                            php82-pecl-memcached \
                            php82-pecl-mongodb \
                            php82-pecl-msgpack \
                            php82-pecl-protobuf \
                            php82-pecl-psr \
                            php82-pecl-redis \
                            php82-pecl-swoole \
                            php82-pecl-uploadprogress \
                            php82-pecl-uuid \
                            php82-pecl-xdebug \
                            php82-pecl-xhprof \
                            php82-pecl-xhprof-assets \
                            php82-pecl-yaml \
                            php82-pecl-zstd \
                            php82-pgsql \
                            php82-phar \
                            php82-posix \
                            php82-pspell \
                            php82-session \
                            php82-shmop \
                            php82-simplexml \
                            php82-snmp \
                            php82-soap \
                            php82-sockets \
                            php82-sodium \
                            php82-sqlite3 \
                            php82-sysvmsg \
                            php82-sysvsem \
                            php82-sysvshm \
                            php82-tidy \
                            php82-tokenizer \
                            php82-xml \
                            php82-xmlreader \
                            php82-xmlwriter \
                            php82-xsl \
                            php82-zip \
                            " && \
     export PHP_8_1_RUN_DEPS=" \
                            gnu-libiconv \
                            mariadb-connector-c \
                            php81 \
                            php81-bcmath \
                            php81-brotli \
                            php81-bz2 \
                            php81-calendar \
                            php81-common \
                            php81-ctype \
                            php81-curl \
                            php81-dba \
                            php81-dom \
                            php81-embed \
                            php81-enchant \
                            php81-exif \
                            php81-ffi \
                            php81-fileinfo \
                            php81-fpm \
                            php81-ftp \
                            php81-gd \
                            php81-gettext \
                            php81-gmp \
                            php81-iconv \
                            php81-imap \
                            php81-intl \
                            php81-ldap \
                            php81-litespeed \
                            php81-mbstring \
                            php81-mysqli \
                            php81-mysqlnd \
                            php81-odbc \
                            php81-opcache \
                            php81-openssl \
                            php81-pcntl \
                            php81-pdo \
                            php81-pdo_dblib \
                            php81-pdo_mysql \
                            php81-pdo_odbc \
                            php81-pdo_pgsql \
                            php81-pdo_sqlite \
                            php81-pear \
                            php81-pecl-amqp \
                            php81-pecl-apcu \
                            php81-pecl-ast \
                            php81-pecl-couchbase \
                            php81-pecl-event \
                            php81-pecl-igbinary \
                            php81-pecl-imagick \
                            php81-pecl-lzf \
                            php81-pecl-mailparse \
                            php81-pecl-maxminddb \
                            php81-pecl-memcache \
                            php81-pecl-memcached \
                            php81-pecl-mongodb \
                            php81-pecl-msgpack \
                            php81-pecl-protobuf \
                            php81-pecl-psr \
                            php81-pecl-rdkafka \
                            php81-pecl-redis \
                            php81-pecl-ssh2 \
                            php81-pecl-swoole \
                            php81-pecl-uploadprogress \
                            php81-pecl-uuid \
                            php81-pecl-vips \
                            php81-pecl-xdebug \
                            php81-pecl-xhprof \
                            php81-pecl-xhprof-assets \
                            php81-pecl-yaml \
                            php81-pecl-zstd \
                            php81-pgsql \
                            php81-phar \
                            php81-posix \
                            php81-pspell \
                            php81-session \
                            php81-shmop \
                            php81-simplexml \
                            php81-snmp \
                            php81-soap \
                            php81-sockets \
                            php81-sodium \
                            php81-sqlite3 \
                            php81-sysvmsg \
                            php81-sysvsem \
                            php81-sysvshm \
                            php81-tidy \
                            php81-tokenizer \
                            php81-xml \
                            php81-xmlreader \
                            php81-xmlwriter \
                            php81-xsl \
                            php81-zip \
                            " && \
    \
    source /assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    package install .php-build-deps \
                build-base \
                gpgme-dev \
                php${php_folder}-dev \
                && \
    \
    package install .php-run-deps \
                ca-certificates \
                git \
                gnupg \
                gpgme \
                openssl \
                mariadb-client \
                postgresql-client \
                $(printenv PHP_$(echo ${PHP_BASE} | sed 's|\.|_|g')_RUN_DEPS) \
                && \
    \
    ### PHP Setup
    ## Temp Fix for graphicsmagick
    if [ -f "/etc/php${php_folder}/*magick*.ini" ]; then mv /etc/php${php_folder}/conf.d/*magick*.ini /tmp; fi; \
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php${php_folder}/php.ini && \
    if [ -f "/usr/bin/php${php_folder}" ] ; then ln -sf /usr/bin/php${php_folder} /usr/sbin/php ; fi ; \
    if [ -f "/usr/bin/pecl${php_folder}" ] ; then ln -sf /usr/bin/pecl${php_folder} /usr/sbin/pecl; fi ; \
    rm -rf /etc/logrotate.d/php* && \
    \
    ### Install PHP Composer
    if [ "${PHP_BASE:0:1}" = "5" ] ; then echo "suhosin.executor.include.whitelist = phar" >> /etc/php${PHP_BASE:0:1}/php.ini ; fi;  \
    curl -sSLk https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    if [ -f "/etc/php${php_folder}/*magick*.ini" ]; then mv /tmp/*magick.ini* /etc/php${php_folder}/conf.d/ ; fi ; \
    \
    ### Build Extra Extensions
    if [ "${build_gnupg,,}" = "true" ] ; then \
    pecl install gnupg ; \
    echo "extension=gnupg.so" > /etc/php${php_folder}/conf.d/20-gnupg.ini ; \
    fi ; \
    mkdir -p /etc/php${php_folder}/mods-available/ && \
    #### Disabling any but core extensions - When using this image as a base for other images, you'll want to turn turn them on before running composer with the inverse of phpdisomd (phpenmod) to keep things clean
    set +x && \
    for module in /etc/php${php_folder}/conf.d/*.ini; do if [ ! -L "${module}" ] ; then if [ "$(echo $(basename $module) | grep -c '^[0-9][0-9].*')" = "0" ] ; then mv "${module}" "$(dirname ${module})/20_$(basename ${module})" ; module="$(dirname ${module})/20_$(basename ${module})"; fi ; if ! grep -w -i -q ";priority" "$module"; then echo ";priority=$(basename $module .ini | cut -d _ -f1)" >> $module ; mv "${module}" /etc/php${php_folder}/mods-available/$(basename ${module} .ini | cut -c 4-).ini; fi; fi; done; \
    rm -rf /etc/php${php_folder}/conf.d/* && \
    sed -i "s|;priority=00|;priority=10|g" /etc/php${php_folder}/mods-available/opcache.ini && \
    php_env_plugins_enabled="$(set | sort | grep PHP_ENABLE_ | grep -i TRUE | cut -d _ -f 3 | cut -d = -f 1 |  tr [A-Z] [a-z])" && \
    cat /etc/php${php_folder}/mods-available/opcache.ini && \
    for module in $php_env_plugins_enabled ; do if [ -f "/etc/php${php_folder}/mods-available/${module}.ini" ] ; then priority=$(cat /etc/php${php_folder}/mods-available/${module}.ini | grep ";priority" | cut -d = -f2) ; ln -sf "/etc/php${php_folder}/mods-available/${module}.ini" /etc/php${php_folder}/conf.d/${priority}-${module}.ini ; fi ; done ; \
    if [ "${PHP_BASE:0:1}" != "8" ] ; then priority=$(cat /etc/php${PHP_BASE:0:1}/mods-available/json.ini | grep ";priority" | cut -d = -f2) ; ln -sf "/etc/php${PHP_BASE:0:1}/mods-available/json.ini" /etc/php${PHP_BASE:0:1}/conf.d/${priority}-json.ini ; fi ; \
    set -x && \
    \
    ### Cleanup
    package remove .php-build-deps && \
    package cleanup && \
    rm -rf \
           /tmp/* \
           /usr/src/* \
           /var/log/*

COPY install /
