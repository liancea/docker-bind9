FROM ubuntu:bionic

COPY ./crontab /etc/crontab
COPY ./update-rootzone.sh ./start-bind.sh /usr/local/bin/

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get -y -o Dpkg::Options::="--force-confold" install bind9 dnsutils wget cron && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	chmod 0750 /usr/local/bin/update-rootzone.sh /usr/local/bin/start-bind.sh && \
	/usr/local/bin/update-rootzone.sh --skip-reload && \
	mkdir /var/bind9-distconfig && \
	cp -a /etc/bind /var/bind9-distconfig/etc_bind && \
	cp -a /var/lib/bind /var/bind9-distconfig/var_lib_bind

VOLUME [ "/etc/bind", "/var/lib/bind" ]
EXPOSE 53/udp 53/tcp

ENTRYPOINT [ "/usr/local/bin/start-bind.sh" ]
HEALTHCHECK CMD dig @localhost 1.0.0.127.in-addr.arpa >/dev/null

