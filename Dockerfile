FROM ubuntu:18.04
RUN apt-get update && apt-get upgrade -y
RUN apt-get install apache2 -y
EXPOSE 80
COPY index.html /var/www/html/index.html
