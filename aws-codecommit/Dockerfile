FROM ubuntu:12.04
# Install dependencies
RUN apt-get update -y
RUN apt-get install -y apache2

# Install apache and write hello world message
RUN echo "Esta é a sua aplicação local em Docker :)" > /var/www/index.html


# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 8080

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
