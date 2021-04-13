FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install nginx -y
RUN apt-get install vim -y
RUN apt-get install wget -y

WORKDIR var/www/html

RUN wget https://ru.wordpress.org/latest-ru_RU.tar.gz
RUN wget  https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz
RUN tar -xvf latest-ru_RU.tar.gz && tar -xvf phpMyAdmin-5.1.0-all-languages.tar.gz
RUN rm phpMyAdmin-5.1.0-all-languages.tar.gz && rm latest-ru_RU.tar.gz
RUN mv phpMyAdmin-5.1.0-all-languages phpMyAdmin

RUN apt-get install php7.3-fpm -y
RUN apt-get install mariadb-server -y
RUN apt-get install php7.3-mysql -y
RUN apt-get install php7.3-mbstring -y
RUN apt-get install php7.3-cli -y
RUN apt-get install php7.3-gd -y
RUN apt-get install openssl -y

COPY srcs/wp-config.php wordpress/
COPY srcs/config.sample.inc.php phpMyAdmin/
COPY srcs/scrypt.sh .
COPY srcs/nginx_on.conf /etc/nginx/sites-available/

COPY srcs/nginx_on.conf .
COPY srcs/nginx_off.conf .

RUN rm -f /etc/nginx/sites-enabled/default && rm -f /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/nginx_on.conf /etc/nginx/sites-enabled/
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt -subj "/C=RU/ST=Russia/L=Kazan/O=School21/OU=21School/CN=myssl"

EXPOSE 80 443
RUN chmod +x ./scrypt.sh
# RUN chmod 666 ./wordpress/wp_config.php

CMD [ "./scrypt.sh" ]