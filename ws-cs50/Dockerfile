FROM nicholasjoseph1994/workspace
MAINTAINER Nick 

ADD ./files/workspace /home/ubuntu/workspace
ADD ./files/cs50 /home/ubuntu/cs50
ADD ./files/bin /usr/bin
ADD ./files/etc /etc

RUN chmod -R g+w /home/ubuntu/workspace && \
    chown -R ubuntu:ubuntu /home/ubuntu && \
    apt-get install clang -y && \
    wget http://mirror.cs50.net/library50/c/library50-c-5.zip && \ 
    unzip library50-c-5.zip && \
    rm -f library50-c-5.zip && \
    cd library50-c-5 && \
    clang -c -ggdb -std=c99 cs50.c -o cs50.o && \
    ar rcs libcs50.a cs50.o && \
    chmod 0644 cs50.h libcs50.a && \
    mkdir -p /usr/local/include && \
    chmod 0755 /usr/local/include && \
    mv -f cs50.h /usr/local/include && \
    mkdir -p /usr/local/lib && \
    chmod 0755 /usr/local/lib && \
    mv -f libcs50.a /usr/local/lib && \
    cd .. && \
    rm -rf library50-c-5
   
    #moves in files
RUN mv /home/ubuntu/cs50/app.sh /etc/profile.d && \
    mv /home/ubuntu/cs50/cs50.conf /etc/apache2/conf-available && \
    ln -s /etc/apache2/conf-available/cs50.conf /etc/apache2/conf-enabled/cs50.conf && \
    mv /home/ubuntu/workspace/init.sh /home/ubuntu/init.sh && \
    rm -rf /home/ubuntu/cs50

    #changes permissions
    chmod 711 /usr/bin/version50 && \
    chmod 711 /usr/bin/check50 && \
    chmod 711 /usr/bin/check50.js && \
    chmod 711 /usr/bin/style50

    #installs node in /usr/lib
RUN apt-get install npm -y && \
    cd /usr/lib && \
    npm install optimist && \
    npm install async && \
    npm install node-zip && \
    npm install request && \
    npm install underscore && \
    npm install wrench    

