Battlestar Coin V1.2.3 Node
========

This image is to run Battlestarcoin daemon as a node but if you add your wallet.dat into /home/batl/.batl it can also be a personal wallet.

## Run this Image from command line

```
docker run -d --name battlestarcoin -p 16914:16914 -v batl:/home/batl index.docker.io/battlestarcoin/linux-node:latest
```


## Or with docker-compose.yml

```yaml
version: '2'
services:
  batlstar:
    image: battlestarcoin/linux-node:latest
    restart: always
    networks:
      - bridge
    ports:
      - 16914:16914
    volumes:
      - batl:/home/batl/
volumes:
  batl:
    name: batl
    driver: local
```

## You can then call the wallets functions via docker exec

```
docker exec -i -t battlestarcoin batld getinfo
```
