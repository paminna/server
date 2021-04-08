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
COPY srcs/wp-config.php wordpress/

# EXPOSE 443 80 //открытие портов
# CMD srypt.sh //запускает все сервисы
