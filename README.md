Battlestar Coin V1.2.3 Node
========

This image is to run Battlestarcoin daemon as a node but if you add your wallet.dat into /home/batl/.batl, you can also use this as a personal wallet.  And wallet wills take if you add some coins

### Start the node from docker command line 

```
docker run -d --name batl -p 16914:16914 -v batl:/home/batl --restart unless-stopped index.docker.io/battlestarcoin/linux-node:latest
```


### Start the node with docker-compose.yml

```yaml
version: '2'
services:
  batl:
    image: battlestarcoin/linux-node:latest
    restart: unless-stopped
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

### You can then call the wallets functions via docker exec

```
docker exec batl batld getinfo
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

  docker run -d --name batl -p 16914:16914 -v batl:/home/batl --restart unless-stopped -e RPCUSER='kj321l3kj21n3' -e RPCPASS='plok546k546po' -e RPCIP='172.16.5.1' index.docker.io/battlestarcoin/linux-node:latest

```

You would only need to pass these environment variables when you set up or wish to change the settings, they can then be removed.  They are also no required.
