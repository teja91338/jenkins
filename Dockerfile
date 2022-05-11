FROM centos:7
RUN yum -y install httpd
COPY index.html /var/www/html/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
