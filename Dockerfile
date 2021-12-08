FROM ubuntu:focal

MAINTAINER battlestarcoin <admin@battlestarcoin.org>

RUN groupadd -r batlnext && useradd -r -g batlnext batlnext

COPY bin/* /usr/sbin
COPY docker-entrypoint.sh /entrypoint.sh

RUN apt update && \
	apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir /home/batlnext && \
	mkdir /home/batlnext/.batlnext && \
	echo "rpcuser=$(cat /dev/urandom | fold -w 80 | base64 | head -n 1)\nrpcpassword=$(cat /dev/urandom | base64 | fold -w 80 | head -n 1)" > /home/batlnext/.batlnext/batlnext.conf && \
	chown -R batlnext:batlnext /home/batlnext /usr/sbin/batlnext* /entrypoint.sh && \
	chmod +x /usr/sbin/batlnext* /entrypoint.sh
	   
WORKDIR /home/batlnext/

USER batlnext

EXPOSE 16914

ENTRYPOINT ["/entrypoint.sh"]

CMD ["batlnextd"]
