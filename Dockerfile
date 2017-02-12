# pull base image
FROM rstr74/nvm_node_4.6.2

# rstr74/nvm_node_4.6.2_java

# Oracle Java 8 for Debian jessie
#
# URL: https://github.com/William-Yeh/docker-java8
#
# Reference:  http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html
#
# Version     0.2
#

USER root

# add webupd8 repository
RUN \
    echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update  && \
    \
    \
    echo "===> install Java"  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default python2.7 && \
    \
    \
    echo "===> clean up..."  && \
    rm -rf /var/cache/oracle-jdk8-installer  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

USER worker
ENV PYTHON /usr/bin/python2.7
RUN npm install java -g  --unsafe-perm

# define default command
CMD ["java"]