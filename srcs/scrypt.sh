service mysql start
service nginx start
service php7.3-fpm

echo "create database base default character set utf8 collate utf8_unicode_ci;" | mysql
echo "grant all on base.* to 'user'@'localhost' identified by 'password';" | mysql
echo "flush privileges;" | mysql

прописать:
можно здесь прописать скрипт для опенссл или в докерфайле

bash или sh