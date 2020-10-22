FROM ubuntu:xenial as makecoin

MAINTAINER battlestarcoin <admin@battlestarcoin.org>

WORKDIR /home

RUN apt update && \
	apt install -y git build-essential libssl-dev libdb++-dev libboost-all-dev libqrencode-dev libminiupnpc-dev && \
	rm -rf /var/lib/apt/lists/* && \
	git clone https://github.com/BattlestarCoin/BattlestarCoin.git coin && \
	cd /home/coin/src && \
	make -f makefile.unix
		
FROM ubuntu:xenial

MAINTAINER battlestarcoin <admin@battlestarcoin.org>

RUN groupadd -r batl && useradd -r -g batl batl

COPY --from=makecoin /home/coin/src/battlestarcoind /usr/sbin/batld
COPY docker-entrypoint.sh /entrypoint.sh

RUN apt update && \
	apt install -y libdb5.3++-dev libminiupnpc-dev libboost-all-dev libssl1.0.0  && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir /home/batl && \
	mkdir /home/batl/.batl && \
	echo "rpcuser=$(cat /dev/urandom | fold -w 80 | base64 | head -n 1)\nrpcpassword=$(cat /dev/urandom | base64 | fold -w 80 | head -n 1)" > /home/batl/.batl/batl.conf && \
	chown -R batl:batl /home/batl /entrypoint.sh && \
	chown -R batl:batl /usr/sbin/batld /entrypoint.sh && \
	chmod +x /usr/sbin/batld /entrypoint.sh
	   
WORKDIR /home/batl/

USER batl

EXPOSE 16914

ENTRYPOINT ["/entrypoint.sh"]

CMD ["batld"]
