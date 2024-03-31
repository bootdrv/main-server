FROM ubuntu:20.04
RUN apt-get update -y
RUN apt-get install apt-utils -y
RUN DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install htop -y
RUN apt-get install atop -y
RUN apt-get install vim -y
RUN apt-get install net-tools -y
RUN apt-get install mc -y
EXPOSE 80
EXPOSE 443
RUN apt-get install nginx -y
COPY ./nginx_conf/conf.d/default.conf /etc/nginx/sites-available/default
ENTRYPOINT ["nginx", "-g", "daemon off;"]
