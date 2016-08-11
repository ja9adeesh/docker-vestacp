FROM phusion/baseimage:0.9.15

MAINTAINER ivan@lagunovsky.com

ENV VESTA /usr/local/vesta

RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install git unzip nano \
 && apt-get clean

ADD install-ubuntu.sh /install-ubuntu.sh
RUN chmod +x /install-ubuntu.sh

RUN bash /install-ubuntu.sh \
  --password admin \
  --mysql yes --postgresql no \
  -y no -f \
  && apt-get clean

ADD dovecot /etc/init.d/dovecot
RUN chmod +x /etc/init.d/dovecot

RUN cd /usr/local/vesta/data/ips && mv * 127.0.0.1 \
    && cd /etc/nginx/conf.d && sed -i -- 's/172.*.*.*:80 default;/80 default;/g' * && sed -i -- 's/172.*.*.*:8080/127.0.0.1:8080/g' * \
    && cd /home/admin/conf/web && sed -i -- 's/172.*.*.*:80 default;/80 default;/g' * && sed -i -- 's/172.*.*.*:8080/127.0.0.1:8080/g' *

RUN rm -f /etc/service/sshd/down \
    && /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN mkdir /vesta-start \
    && mkdir /vesta-start/etc \
    && mkdir /vesta-start/var \
    && mkdir /vesta-start/local \
    && mv /home /vesta-start/home \
    && rm -rf /home \
    && ln -s /vesta/home /home \
    && mv /etc/php /vesta-start/etc/php \
    && rm -rf /etc/php \
    && ln -s /vesta/etc/php /etc/php \
    && mv /etc/nginx   /vesta-start/etc/nginx \
    && rm -rf /etc/nginx \
    && ln -s /vesta/etc/nginx /etc/nginx \
    && mv /etc/exim4   /vesta-start/etc/exim4 \
    && rm -rf /etc/exim4 \
    && ln -s /vesta/etc/exim4 /etc/exim4 \
    && mv /etc/dovecot /vesta-start/etc/dovecot \
    && rm -rf /etc/dovecot \
    && ln -s /vesta/etc/dovecot /etc/dovecot \
    && mv /etc/mysql   /vesta-start/etc/mysql \
    && rm -rf /etc/mysql \
    && ln -s /vesta/etc/mysql /etc/mysql \
    && mv /root /vesta-start/root \
    && rm -rf /root \
    && ln -s /vesta/root /root \
    && mv /usr/local/vesta /vesta-start/local/vesta \
    && rm -rf /usr/local/vesta \
    && ln -s /vesta/local/vesta /usr/local/vesta \
    && mv /etc/shadow /vesta-start/etc/shadow \
    && rm -rf /etc/shadow \
    && ln -s /vesta/etc/shadow /etc/shadow \
    && mv /etc/bind /vesta-start/etc/bind \
    && rm -rf /etc/bind \
    && ln -s /vesta/etc/bind /etc/bind \
    && mv /etc/profile /vesta-start/etc/profile \
    && rm -rf /etc/profile \
    && ln -s /vesta/etc/profile /etc/profile \
    && rm -rf /var/lib/mysql \
    && ln -s /vesta/var/mysql /var/lib/mysql \
    && mv /var/log /vesta-start/var/log \
    && rm -rf /var/log \
    && ln -s /vesta/var/log /var/log

VOLUME /vesta

RUN mkdir -p /etc/my_init.d
ADD startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

EXPOSE 22 80 8083 3306 443 25 993 110 53 54
