FROM ubuntu:bionic

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get -y install bind9 dnsutils && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

VOLUME [ "/etc/bind", "/var/lib/bind" ]
EXPOSE 53/udp 53/tcp

ENTRYPOINT [ "/usr/sbin/named", "-g", "-u", "bind" ]
HEALTHCHECK CMD dig @localhost 1.0.0.127.in-addr.arpa >/dev/null

