FROM centos:7

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN yum update -y && yum install -y gzip git curl python openssl-devel && yum groupinstall -y "Development Tools" && yum install -y nodejs npm && yum clean all

RUN mkdir /opt/etherpad && git clone https://github.com/ether/etherpad-lite.git /opt/etherpad

EXPOSE 9001

RUN useradd etherpad
RUN chown -R etherpad /opt/etherpad
USER etherpad

RUN su - etherpad -c /opt/etherpad/bin/installDeps.sh

WORKDIR /opt/etherpad
VOLUME /opt/etherpad/etc
RUN ln -sf etc/settings.json settings.json

npm install ep_adminpads
npm install ep_align
npm install ep_headings

CMD /opt/etherpad/bin/run.sh
