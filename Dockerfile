# Place instructions here

FROM ubuntu:latest
ENV DEBIAN_FRONTEND=nonintercative 

#update and install packages
RUN apt update
RUN apt install -y vim
RUN apt install -y apache2
RUN apt install -y sudo

#enable the UserDir module
RUN a2enmod userdir
#enable DirectoryIndex module
RUN a2enmod autoindex

#enabling other Apache modules
RUN a2enmod rewrite
RUN a2enmod alias
RUN a2enmod vhost_alias
RUN a2enmod auth_basic

#user1
RUN adduser rosa
RUN passwd -d rosa
RUN usermod -aG sudo rosa

# Set the working directory to public_html                                   
WORKDIR /home/rosa/public_html

# Copy the index.html file into the dir               
COPY rosaindex.html .                               
COPY baristas.html .
COPY index.html .
COPY bubbletea.jpg .

#user 2
RUN adduser tobi
RUN passwd -d tobi 
RUN usermod -aG sudo tobi

WORKDIR /home/tobi/public_html
COPY tobiindex.html .
COPY baristas.html .
COPY index.html .
COPY bubbletea.jpg .

#user 3
RUN adduser yogi
RUN passwd -d yogi    
RUN usermod -aG sudo yogi

WORKDIR /home/yogi/public_html
COPY yogiindex.html .
COPY baristas.html .
COPY index.html .
COPY bubbletea.jpg .

#user 4
RUN adduser santiago
RUN passwd -d santiago   
RUN usermod -aG sudo santiago

WORKDIR /home/santiago/public_html
COPY santiindex.html .
COPY baristas.html .
COPY index.html .
COPY bubbletea.jpg .

#user 5
RUN adduser paola
RUN passwd -d paola   
RUN usermod -aG sudo paola

WORKDIR /home/paola/public_html
COPY paoindex.html .
COPY baristas.html .
COPY index.html .
COPY bubbletea.jpg .

#add files to /var/www/html
WORKDIR /var/www/html
COPY index.html .
COPY forbidden.html .
COPY not-found.html .
COPY bubbletea.jpg .
COPY baristas.html .

#updated vhost file - 000-default.conf
WORKDIR /etc/apache2/sites-enabled
COPY 000-default.conf .

#making a dir for the marketing team 
RUN mkdir -p /var/www/marketing/promotions
WORKDIR /var/www/marketing/promotions

#adding the promotions.html file 
COPY promotions.html .

# Add in other directives as needed
LABEL Maintainer: "jazmin.celestino.694@my.csun.edu"

EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]
