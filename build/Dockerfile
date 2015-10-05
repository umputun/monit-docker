FROM debian:jessie

MAINTAINER Umputun

#install basic packages
RUN \
 apt-get update && apt-get upgrade -y --no-install-recommends && \
 apt-get install python-pip python-dev monit curl mysql-client inotify-tools apt-transport-https -y -qq && \
 apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
 echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
 apt-get update -qq && apt-get install -qqy docker-engine && \
 easy_install -U pip && \
 pip install plumbum pymongo awscli pytz beautifulsoup4 && \
 pip install --upgrade httpie && \
 apt-get autoremove -y && apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 rm -rf /var/lib/{apt,dpkg,cache,log}


ENV VERSION 5.14

#install fresh monit
#ADD https://mmonit.com/monit/dist/binary/${VERSION}/monit-${VERSION}-linux-x64.tar.gz /tmp/monit-${VERSION}-linux-x64.tar.gz
COPY dist/monit-$VERSION-linux-x64.tar.gz /tmp/monit-$VERSION-linux-x64.tar.gz
RUN \
 cd tmp && tar -zxf monit-$VERSION-linux-x64.tar.gz && \
 cp -f /tmp/monit-$VERSION/bin/monit /usr/bin/monit && \
 ln -s /etc/monit/monitrc /etc/monitrc


#install jq, xml2json, link httpie
ADD http://stedolan.github.io/jq/download/linux64/jq /usr/bin/jq
RUN \
 chmod +x /usr/bin/jq && \
 ln -s /usr/local/bin/http /usr/bin/http && \
 pip install https://github.com/hay/xml2json/zipball/master

#to access other containers on the host
ENV DOCKER_HOST unix:///var/run/docker.sock

#copy common monit config and srcipts
ADD conf/ /srv/monit/conf.d/
ADD scripts /srv/monit/scripts

ADD start.sh /srv/monit/start.sh
ADD monit.sh /srv/monit/monit.sh

EXPOSE 9009
VOLUME ["/etc/monit/conf.d",  "/var/log/monit", "/srv/monit", "/hostsrv", "/hostroot",]

CMD ["/srv/monit/start.sh"]
