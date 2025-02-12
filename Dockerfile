ARG DISTRO=alpine
ARG DISTRO_VARIANT=edge

FROM docker.io/tiredofit/unit:${DISTRO}-${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

ARG PHP_BASE

ENV PHP_BASE=${PHP_BASE:-"8.3"} \
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

RUN case "${PHP_BASE}" in \
       8.4 ) export php_folder="83" export build_gnupg=true ;; \
       8.3 ) export php_folder="83" export build_gnupg=true ;; \
       8.2 ) export php_folder="82" export build_gnupg=true ;; \
       8.1 ) export php_folder="81" export build_gnupg=true ;; \
       *) export php_folder=${PHP_BASE:0:1} ; export build_gnupg=false ;; \
    esac ; \
        export PHP_8_3_RUN_DEPS=" \
                            php83 \
                            php83-bcmath \
                            php83-brotli \
                            php83-bz2 \
                            php83-calendar \
                            php83-common \
                            php83-ctype \
                            php83-curl \
                            php83-dba \
                            php83-dom \
                            php83-embed \
                            php83-enchant \
                            php83-exif \
                            php83-ffi \
                            php83-fileinfo \
                            php83-ftp \
                            php83-gd \
                            php83-gettext \
                            php83-gmp \
                            php83-iconv \
                            php83-imap \
                            php83-intl \
                            php83-ldap \
                            php83-litespeed \
                            php83-mbstring \
                            php83-mysqli \
                            php83-mysqlnd \
                            php83-odbc \
                            php83-opcache \
                            php83-openssl \
                            php83-pcntl \
                            php83-pdo \
                            php83-pdo_dblib \
                            php83-pdo_mysql \
                            php83-pdo_odbc \
                            php83-pdo_pgsql \
                            php83-pdo_sqlite \
                            php83-pear \
                            php83-pecl-amqp \
                            php83-pecl-apcu \
                            php83-pecl-ast \
                            php83-pecl-couchbase \
                            php83-pecl-igbinary \
                            php83-pecl-maxminddb \
                            php83-pecl-memcache \
                            php83-pecl-memcached \
                            php83-pecl-mongodb \
                            php83-pecl-msgpack \
                            php83-pecl-psr \
                            php83-pecl-redis \
                            php83-pecl-swoole \
                            php83-pecl-uploadprogress \
                            php83-pecl-xdebug \
                            php83-pecl-xhprof \
                            php83-pecl-xhprof-assets \
                            php83-pecl-yaml \
                            php83-pecl-zstd \
                            php83-pgsql \
                            php83-phar \
                            php83-posix \
                            php83-pspell \
                            php83-session \
                            php83-shmop \
                            php83-simplexml \
                            php83-snmp \
                            php83-soap \
                            php83-sockets \
                            php83-sodium \
                            php83-sqlite3 \
                            php83-sysvmsg \
                            php83-sysvsem \
                            php83-sysvshm \
                            php83-tidy \
                            php83-tokenizer \
                            php83-xml \
                            php83-xmlreader \
                            php83-xmlwriter \
                            php83-xsl \
                            php83-zip \
                            " && \
    export PHP_8_2_RUN_DEPS=" \
                            php82 \
                            php82-bcmath \
                            php82-brotli \
                            php82-bz2 \
                            php82-calendar \
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
    export PHP_8_0_RUN_DEPS=" \
                            php8 \
                            php8-bcmath \
                            php8-brotli \
                            php8-bz2 \
                            php8-calendar \
                            php8-common \
                            php8-ctype \
                            php8-curl \
                            php8-dba \
                            php8-dom \
                            php8-embed \
                            php8-enchant \
                            php8-exif \
                            php8-ffi \
                            php8-fileinfo \
                            php8-ftp \
                            php8-gd \
                            php8-gettext \
                            php8-gmp \
                            php8-iconv \
                            php8-imap \
                            php8-intl \
                            php8-ldap \
                            php8-litespeed \
                            php8-mbstring \
                            php8-mysqli \
                            php8-mysqlnd \
                            php8-odbc \
                            php8-opcache \
                            php8-openssl \
                            php8-pcntl \
                            php8-pdo \
                            php8-pdo_dblib \
                            php8-pdo_mysql \
                            php8-pdo_odbc \
                            php8-pdo_pgsql \
                            php8-pdo_sqlite \
                            php8-pear \
                            php8-pecl-amqp \
                            php8-pecl-apcu \
                            php8-pecl-ast \
                            php8-pecl-couchbase \
                            php8-pecl-event \
                            php8-pecl-igbinary \
                            php8-pecl-imagick \
                            php8-pecl-lzf \
                            php8-pecl-mailparse \
                            php8-pecl-maxminddb \
                            php8-pecl-mcrypt \
                            php8-pecl-memcache \
                            php8-pecl-memcached \
                            php8-pecl-mongodb \
                            php8-pecl-msgpack \
                            php8-pecl-oauth \
                            php8-pecl-protobuf \
                            php8-pecl-psr \
                            php8-pecl-rdkafka \
                            php8-pecl-redis \
                            php8-pecl-ssh2 \
                            php8-pecl-swoole \
                            php8-pecl-timezonedb \
                            php8-pecl-uploadprogress \
                            php8-pecl-uuid \
                            php8-pecl-vips \
                            php8-pecl-xdebug \
                            php8-pecl-xhprof \
                            php8-pecl-xhprof-assets \
                            php8-pecl-yaml \
                            php8-pecl-zstd \
                            php8-pgsql \
                            php8-phar \
                            php8-posix \
                            php8-pspell \
                            php8-session \
                            php8-shmop \
                            php8-simplexml \
                            php8-snmp \
                            php8-soap \
                            php8-sockets \
                            php8-sodium \
                            php8-sqlite3 \
                            php8-sysvmsg \
                            php8-sysvsem \
                            php8-sysvshm \
                            php8-tideways_xhprof \
                            php8-tidy \
                            php8-tokenizer \
                            php8-xml \
                            php8-xmlreader \
                            php8-xmlwriter \
                            php8-xsl \
                            php8-zip \
                            " && \
    \
    export PHP_7_4_RUN_DEPS=" \
                            php7 \
                            php7-bcmath \
                            php7-brotli \
                            php7-bz2 \
                            php7-calendar \
                            php7-common \
                            php7-ctype \
                            php7-curl \
                            php7-dba \
                            php7-dom \
                            php7-embed \
                            php7-enchant \
                            php7-exif \
                            php7-ffi \
                            php7-fileinfo \
                            php7-ftp \
                            php7-gd \
                            php7-gettext \
                            php7-gmp \
                            php7-iconv \
                            php7-imap \
                            php7-intl \
                            php7-json \
                            php7-ldap \
                            php7-mbstring \
                            php7-mysqli \
                            php7-mysqlnd \
                            php7-odbc \
                            php7-opcache \
                            php7-openssl \
                            php7-pcntl \
                            php7-pdo \
                            php7-pdo_dblib \
                            php7-pdo_mysql \
                            php7-pdo_odbc \
                            php7-pdo_pgsql \
                            php7-pdo_sqlite \
                            php7-pear \
                            php7-pecl-amqp \
                            php7-pecl-apcu \
                            php7-pecl-ast \
                            php7-pecl-couchbase \
                            php7-pecl-event \
                            php7-pecl-gmagick \
                            php7-pecl-imagick \
                            php7-pecl-igbinary \
                            php7-pecl-lzf \
                            php7-pecl-mailparse \
                            php7-pecl-maxminddb \
                            php7-pecl-mcrypt \
                            php7-pecl-memcache \
                            php7-pecl-memcached \
                            php7-pecl-mongodb \
                            php7-pecl-msgpack \
                            php7-pecl-oauth \
                            php7-pecl-protobuf \
                            php7-pecl-psr \
                            php7-pecl-redis \
                            php7-pecl-ssh2 \
                            php7-pecl-timezonedb \
                            php7-pecl-uploadprogress \
                            php7-pecl-uuid \
                            php7-pecl-vips \
                            php7-pecl-xdebug \
                            php7-pecl-xhprof \
                            php7-pecl-xhprof-assets \
                            php7-pecl-yaml \
                            php7-pecl-zmq \
                            php7-pgsql \
                            php7-phalcon \
                            php7-phar \
                            php7-posix \
                            php7-pspell \
                            php7-session \
                            php7-shmop \
                            php7-simplexml \
                            php7-snmp \
                            php7-soap \
                            php7-sockets \
                            php7-sodium \
                            php7-sqlite3 \
                            php7-tidy \
                            php7-tokenizer \
                            php7-xml \
                            php7-xmlreader \
                            php7-xmlrpc \
                            php7-xmlwriter \
                            php7-xsl \
                            php7-zip \
                            " && \
    \
    export PHP_7_3_RUN_DEPS=" \
                            php7 \
                            php7-bcmath \
                            php7-brotli \
                            php7-bz2 \
                            php7-calendar \
                            php7-common \
                            php7-ctype \
                            php7-curl \
                            php7-dba \
                            php7-dom \
                            php7-embed \
                            php7-enchant \
                            php7-exif \
                            php7-fileinfo \
                            php7-ftp \
                            php7-gd \
                            php7-gettext \
                            php7-gmp \
                            php7-iconv \
                            php7-imap \
                            php7-intl \
                            php7-json \
                            php7-ldap \
                            php7-litespeed \
                            php7-maxminddb \
                            php7-mbstring \
                            php7-mysqli \
                            php7-mysqlnd \
                            php7-odbc \
                            php7-opcache \
                            php7-openssl \
                            php7-pcntl \
                            php7-pdo \
                            php7-pdo_dblib \
                            php7-pdo_mysql \
                            php7-pdo_odbc \
                            php7-pdo_pgsql \
                            php7-pdo_sqlite \
                            php7-pear \
                            php7-pecl-amqp \
                            php7-pecl-apcu \
                            php7-pecl-ast \
                            php7-pecl-couchbase \
                            php7-pecl-event \
                            php7-pecl-gmagick \
                            php7-pecl-igbinary \
                            php7-pecl-imagick \
                            php7-pecl-lzf \
                            php7-pecl-mailparse \
                            php7-pecl-mcrypt \
                            php7-pecl-memcache \
                            php7-pecl-memcached \
                            php7-pecl-msgpack \
                            php7-pecl-oauth \
                            php7-pecl-protobuf \
                            php7-pecl-psr \
                            php7-pecl-redis \
                            php7-pecl-ssh2 \
                            php7-pecl-timezonedb \
                            php7-pecl-uploadprogress \
                            php7-pecl-uuid \
                            php7-pecl-vips \
                            php7-pecl-xdebug \
                            php7-pecl-xhprof \
                            php7-pecl-yaml \
                            php7-pecl-zmq \
                            php7-pgsql \
                            php7-phalcon \
                            php7-phar \
                            php7-posix \
                            php7-pspell \
                            php7-recode \
                            php7-session \
                            php7-shmop \
                            php7-simplexml \
                            php7-snmp \
                            php7-soap \
                            php7-sockets \
                            php7-sodium \
                            php7-sqlite3 \
                            php7-tidy \
                            php7-tokenizer \
                            php7-wddx \
                            php7-xml \
                            php7-xmlreader \
                            php7-xmlrpc \
                            php7-xmlwriter \
                            php7-xsl \
                            php7-zip \
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
                gnu-libiconv \
                gnupg \
                gpgme \
                mariadb-client \
                mariadb-connector-c \
                openssl \
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
