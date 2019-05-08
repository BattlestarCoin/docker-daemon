FROM ubuntu:zesty
MAINTAINER battlestarcoin <admin@battlestarcoin.org>

RUN groupadd -r batl && useradd -r -g batl batl

RUN sed -i 's/archive/old-releases/g' /etc/apt/sources.list && \
    sed -i 's/security\./old-releases\./g' /etc/apt/sources.list && \
    apt update && \
    apt install -y libdb5.3++-dev libminiupnpc-dev libboost-all-dev libssl1.0.0 wget && \
    mkdir /home/batl && \
    wget --no-verbose https://github.com/BattlestarCoin/BattlestarCoin/releases/download/v1.2.3-linux-daemon/battlestarcoind -O /home/batl/batld && \
    mkdir /home/batl/.batl && \
    echo "rpcuser=$(cat /dev/urandom | fold -w 80 | base64 | head -n 1)\nrpcpassword=$(cat /dev/urandom | base64 | fold -w 80 | head -n 1)" > /home/batl/.batl/batl.conf && \
    chown -R batl:batl /home/batl && \
    chmod +x /home/batl/batld
	
USER batl

EXPOSE 16914

CMD ["/home/batl/batld"]
