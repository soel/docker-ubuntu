FROM ubuntu:13.10

RUN apt-get update


RUN apt-get -y install openssh-server net-tools less make gcc python-setuptools supervisor git git-flow tree debian-archive-keyring git strace  language-pack-ja rsyslog curl dnsutils build-essential

RUN mkdir -p /var/run/sshd 
RUN sed -i -e 's/^\(session\s\+required\s\+pam_loginuid.so$\)/#\1/' /etc/pam.d/sshd
RUN echo 'root:password' |chpasswd

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 80

CMD /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
