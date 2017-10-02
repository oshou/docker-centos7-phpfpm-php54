# pull base image
FROM centos:7

# locale & timezone
RUN sed -i -e "s/LANG=\"en_US.UTF-8\"/LANG=\"ja_JP.UTF-8\"/g" /etc/locale.conf && \
    cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# system update
RUN  yum -y update

# install repository
COPY conf/unit.repo /etc/yum.repos.d/unit.repo
COPY conf/nginx.repo /etc/yum.repos.d/nginx.repo
RUN  yum install -y epel-release && \
     rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel7.noarch.rpm && \
     rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# install packages
RUN  yum install -y \
        # tools
        less \
        libcurl \
        net-tools && \
     yum install -y --enablerepo=unit \
        # nginx
        nginx && \
     yum install -y --enablerepo=remi-php54 \
        # php
        php \
        php-fpm \
        php-devel \
        php-embedded \
        php-mcrypt \
        php-mbstring \
        php-gd \
        php-mysql \
        php-pdo \
        php-xml \
        php-pecl-apcu \
        php-pecl-zendopcache && \
     # cache cleaning
     yum clean all

# nginx
RUN rm -rf /etc/nginx/conf.d/*
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/vhost-phpfpm.conf /etc/nginx/conf.d/vhost-phpfpm.conf

# php
COPY ./conf/php.ini /etc/php.ini
COPY ./conf/php-fpm.conf /etc/php-fpm.conf
COPY ./conf/www.conf /etc/php-fpm.d/www.conf
COPY ./conf/index.php /var/www/html/index.php
COPY ./conf/startup.sh /usr/local/startup.sh
RUN chmod 755 /usr/local/startup.sh

# document root
RUN groupadd --gid 1000 www-data && \
    useradd www-data --uid 1000 --gid 1000 && \
    chmod -R 755 /var/www && \
    chown -R www-data:www-data /var/www

# listen port
EXPOSE 9000

# startup
CMD /usr/local/startup.sh
