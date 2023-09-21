# github.com/tiredofit/docker-unit-php

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-unit-php?style=flat-square)](https://github.com/tiredofit/docker-unit-php/releases)
[![Build Status](https://img.shields.io/github/workflow/status/tiredofit/docker-unit-php/build?style=flat-square)](https://github.com/tiredofit/docker-unit-php/actions?query=workflow%3Abuild)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/docker-unit.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/unit-php/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/docker-unit.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/unit-php/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

## About

This will build a Docker Image for [Unit with PHP Support](https://unit.nginx.org) to serve applications.

- Supports PHP 7.3-8.2

## Maintainer

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Creating configuration](#creating-configuration)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Enabling / Disabling Specific Extensions](#enabling--disabling-specific-extensions)
    - [Debug Options](#debug-options)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
  - [PHP Extensions](#php-extensions)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)


## Installation
### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/unit-php).

```
docker pull tiredofit/unit:(imagetag)
```

Builds of the image are also available on the [Github Container Registry](https://github.com/tiredofit/unit/pkgs/container/unit-php)

```
docker pull ghcr.io/tiredofit/docker-unit-php:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| PHP version | Alpine Base | Tag            |
| ----------- | ----------- | -------------- |
| latest      | edge        | `:alpine-edge` |
| 8.2.x       | 3.18        | `:alpine-8.2`  |
| 8.1.x       | 3.18        | `:alpine-8.1`  |
| 8.0.x       | 3.16        | `:alpine-8.0`  |
| 7.4.x       | 3.15        | `:alpine-7.4`  |
| 7.3.x       | 3.12        | `:alpine-7.3`  |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

### Creating configuration

This image expects that you place 3+ files into the `/etc/unit/sites.available` directory along with setting the variable `UNIT_SITE_ENABLED`.

- The image will look for the following files:
  - `$UNIT_SITE_ENABLED-listener.json` - Configuration of the listening port, IP, and what to do upon recieving a connection
  - `$UNIT_SITE_ENABLED-uptream.json` - Configuration of the upstream to pass traffic to. This is an optional file and not used regularly
  - `$UNIT_SITE_ENABLED-route.json` - Configuration of route configuration for above listener. This dictates the files to respond to and how to route to an application
  - `$UNIT_SITE_ENABLED-application.json` - Configuration of the application, which can perform certain actions or call application engines based on the name

See the [Unit Configuration](https://unit.nginx.org/configuration/) to understand how this works.

Sample `site-listener.json` file:

```
{
  "{{UNIT_LISTEN_IP}}:{{UNIT_LISTEN_PORT}}": {
    "pass": "application/php"
  }
}
```

Sample `site-application.json` file:

```
{
  "php": {
    "type": "php",
    "root": "{{UNIT_WEBROOT}}"
  }
}
```

If you do not create any configuration, a default configuration will be created, and a sample PHP page will be generated if requested to show that the server is working.

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory       | Description |
| --------------- | ----------- |
| `/var/log/unit` | Logfiles    |
| `/www/html`     | Web root    |

* * *
### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |
| [Unit](https://github.com/tiredofit/docker-unit/)      | Unit Base Image                        |

| Parameter                             | Description                                                                                              | Default                                        |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `PHP_APC_SHM_SIZE`                    | APC Cache Memory size - `0` to disable                                                                   | `128M`                                         |
| `PHP_APC_TTL`                         | APC Time to live in seconds                                                                              | `7200`                                         |
| `PHP_POST_INIT_COMMAND`           | If you wish to execute a command before php-fpm executes, enter it here and seperate multiples by comma. |                                                |
| `PHP_POST_INIT_SCRIPT`            | If you wish to execute a script before php-fpm executes, enter it here and seperate multiples by comma.  |                                                |
| `PHP_HIDE_X_POWERED_BY`               | Hide X-Powered by response                                                                               | `TRUE`                                         |
| `PHP_LOG_ACCESS_FILE`                 | PHP Access Logfile Name                                                                                  | `access.log`                                   |
| `PHP_LOG_ERROR_FILE`                  | Logfile name                                                                                             | `error.log`                                    |
| `PHP_LOG_LEVEL`                       | PHP Log Level `alert` `error` `warning` `notice` `debug`                                                 | `notice`                                       |
| `PHP_LOG_ACCESS_FORMAT`               | Log format - `default` or `json`                                                                         | `default`                                      |
| `PHP_LOG_LIMIT`                       | Characters to log                                                                                        | `2048`                                         |
| `PHP_LOG_LOCATION`                    | Log Location for PHP Logs                                                                                | `/www/logs/php-fpm`                            |
| `PHP_MEMORY_LIMIT`                    | How much memory should PHP use                                                                           | `128M`                                         |
| `PHP_OPCACHE_INTERNED_STRINGS_BUFFER` | OPCache interned strings buffer                                                                          | `8`                                            |
| `PHP_OPCACHE_JIT_BUFFER_SIZE`         | JIT Buffer Size `0` to disable                                                                           | `50M`                                          |
| `PHP_OPCACHE_JIT_MODE`                | JIT [CRTO](https://wiki.php.net/rfc/jit) Mode - > PHP 8.x                                                | `1255`                                         |
| `PHP_OPCACHE_MAX_ACCELERATED_FILES`   | OPCache Max accelerated files                                                                            | `10000`                                        |
| `PHP_OPCACHE_MEM_SIZE`                | OPCache Memory Size - Set `0` to disable or via other env vars                                           | `128`                                          |
| `PHP_OPCACHE_REVALIDATE_FREQ`         | OPCache revalidate frequency in seconds                                                                  | `2`                                            |
| `PHP_OPCACHE_MAX_WASTED_PERCENTAGE`   | Max wasted percentage cache                                                                              | `5`                                            |
| `PHP_OPCACHE_VALIDATE_TIMESTAMPS`     | Validate timestamps `1` or `0`                                                                           | `1`                                            |
| `PHP_OPCACHE_SAVE_COMMENTS`           | Opcache Save Comments `0` or `1`                                                                         | `1`                                            |
| `PHP_OPCACHE_MAX_FILE_SIZE`           | Opcache maximum file size                                                                                | `0`                                            |
| `PHP_OPCACHE_OPTIMIZATION_LEVEL`      | Opcache optimization level                                                                               | `0x7FFFBFF`                                    |
| `PHP_POST_MAX_SIZE`                   | Maximum Input Size for POST                                                                              | `2G`                                           |
| `PHP_TIMEOUT`                         | Maximum Script execution Time                                                                            | `180`                                          |
| `PHP_UPLOAD_MAX_SIZE`                 | Maximum Input Size for Uploads                                                                           | `2G`                                           |

#### Enabling / Disabling Specific Extensions

Enable extensions by using the PHP extension name ie redis as `PHP_ENABLE_REDIS=TRUE`. Core extensions are enabled by default are:

| Parameter              | Default |
| ---------------------- | ------- |
| `PHP_ENABLE_APCU`      | `TRUE`  |
| `PHP_ENABLE_BCMATH`    | `TRUE`  |
| `PHP_ENABLE_BZ2`       | `TRUE`  |
| `PHP_ENABLE_CTYPE`     | `TRUE`  |
| `PHP_ENABLE_CURL`      | `TRUE`  |
| `PHP_ENABLE_DOM`       | `TRUE`  |
| `PHP_ENABLE_EXIF`      | `TRUE`  |
| `PHP_ENABLE_FILEINFO`  | `TRUE`  |
| `PHP_ENABLE_GD`        | `TRUE`  |
| `PHP_ENABLE_ICONV`     | `TRUE`  |
| `PHP_ENABLE_IMAP`      | `TRUE`  |
| `PHP_ENABLE_INTL`      | `TRUE`  |
| `PHP_ENABLE_JSON`      | `TRUE`  |
| `PHP_ENABLE_MBSTRING`  | `TRUE`  |
| `PHP_ENABLE_MYSQLI`    | `TRUE`  |
| `PHP_ENABLE_MYSQLND`   | `TRUE`  |
| `PHP_ENABLE_OPCACHE`   | `TRUE`  |
| `PHP_ENABLE_OPENSSL`   | `TRUE`  |
| `PHP_ENABLE_PDO`       | `TRUE`  |
| `PHP_ENABLE_PDO_MYSQL` | `TRUE`  |
| `PHP_ENABLE_PGSQL`     | `TRUE`  |
| `PHP_ENABLE_PHAR`      | `TRUE`  |
| `PHP_ENABLE_SESSION`   | `TRUE`  |
| `PHP_ENABLE_SIMPLEXML` | `TRUE`  |
| `PHP_ENABLE_TOKENIZER` | `TRUE`  |
| `PHP_ENABLE_XML`       | `TRUE`  |
| `PHP_ENABLE_XMLREADER` | `TRUE`  |
| `PHP_ENABLE_XMLWRITER` | `TRUE`  |

To enable all extensions in image use `PHP_KITCHENSINK=TRUE`. Head inside the image and see what extensions are available by typing `php-ext list all`

#### Debug Options
To enable XDebug set `PHP_ENABLE_XDEBUG=TRUE`. Visit the [PHP XDebug Documentation](https://xdebug.org/docs/all_settings#remote_connect_back) to understand what these options mean.
If you debug a PHP project in PHPStorm, you need to set server name using `PHP_IDE_CONFIG` to the same value as set in PHPStorm. Usual value is localhost, i.e. `PHP_IDE_CONFIG="serverName=localhost"`.

For Xdebug 3 :
| Parameter                         | Description                                                          | Default             |
| --------------------------------- | -------------------------------------------------------------------- | ------------------- |
| `PHP_XDEBUG_OUTPUT_DIR`           | Where to store Logs                                                  | `/www/logs/xdebug/` |
| `PHP_XDEBUG_MODE`                 | This setting controls which Xdebug features are enabled.             | `develop`           |
| `PHP_XDEBUG_START_WITH_REQUEST`   | Enable Autostarting as opposed to GET/POST                           | `default`           |
| `PHP_XDEBUG_DISCOVER_CLIENT_HOST` | Xdebug will try to connect to the client that made the HTTP request. | `1`                 |
| `PHP_XDEBUG_CLIENT_HOST`          | Set this to your IP Address                                          | `127.0.0.1`         |
| `PHP_XDEBUG_CLIENT_PORT`          | XDebug Remote Port                                                   | `9003`              |

### Networking

| Port | Protocol | Description    |
| ---- | -------- | -------------- |
| `80` | `http`   | Unit Webserver |

## Maintenance
Inside the image are tools to perform modification on how the image runs.

### Shell Access
For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is e.g. unit-php) bash
```
### PHP Extensions
If you want to enable or disable or list what PHP extensions are available, type `php-ext help`

## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.

## References

* <https://>
