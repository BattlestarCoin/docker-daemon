BattlestarCoin Next V2.13.2.8 Node
========

This image is to run Battlestarcoin daemon as a node but if you add your wallet.dat into /home/batlnext/.batlnext, you can also use this as a personal headless wallet.  The wallet will stake if you add coins.

### Start the node from docker command line 

```
docker run -d --name batlnext -p 16914:16914 -v batlnext:/home/batlnext --restart unless-stopped ghcr.io/battlestarcoin/docker-daemon:master
```


### Start the node with docker-compose.yml

```yaml
version: '2'
services:
  batlnext:
    image: ghcr.io/battlestarcoin/docker-daemon:master
    restart: unless-stopped
    networks:
      - bridge
    ports:
      - 16914:16914
    volumes:
      - batlnext:/home/batlnext/
volumes:
  batlnext:
    name: batlnext
    driver: local
```

### You can then call the wallets functions via docker exec

```
docker exec batlnext batlnext-cli getinfo
```

### You can set the RPC username, password and allowed ips via environment variables.

```

Docker compose example: 

    environment:
      - RPCUSER=kj321l3kj21n3
      - PRCPASS=plok546k546po
      - RPCIP=172.16.5.1
      
```

```

Docker command line example

  docker run -d --name batlnext -p 16914:16914 -v batlnext:/home/batlnext --restart unless-stopped -e RPCUSER=kj321l3kj21n3 -e RPCPASS=plok546k546po -e RPCIP=172.16.5.1 ghcr.io/battlestarcoin/docker-daemon:master

```

You would only need to pass these environment variables when you set up or wish to change the settings, they can then be removed.  They are also not required.
