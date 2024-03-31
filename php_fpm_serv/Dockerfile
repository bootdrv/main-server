FROM php:8.3-fpm
COPY ./hello.php /var/www/
RUN apt-get update
RUN apt-get install apt-utils -y
RUN apt-get install -y iputils-ping
RUN apt-get install nano -y
RUN apt-get install htop -y
RUN apt-get install atop -y
RUN apt-get install mc -y
RUN apt-get install net-tools -y
RUN apt-get install telnet -y
EXPOSE 9000
