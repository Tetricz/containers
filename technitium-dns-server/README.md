# Technitium DNS Server

[Technitium](https://technitium.com/dns/)

## QUICKSTART

```bash
docker run -dit -v <your/directory>:/dns/config -p 53:53/tcp -p 53:53/udp -p 5380:5380 -p 67/67/udp --name techdns tetricz/techdns
```

or

```bash
docker run -dit -v <your/directory>:/dns/config --net=host --name techdns tetricz/techdns
```

I recommend running the network in host mode. Make sure you unbind or stop any programs using port 53 if you are to use network host.

## Building the image yourself

You can build the image yourself really easily by cloning this repo and running docker compose. The compose file was written with docker engine version 19, but it should be fine with older versions.

```bash
git clone https://github.com/Tetricz/docker-techdns.git \
&& cd docker-techdns \
&& docker-compose up --build
```

The you can run the image easily after customizing the compose file.

```bash
docker-compose up -d
```
