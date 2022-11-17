# [Containers-Tetricz](#containers-tetricz)

- [Containers-Tetricz](#containers-tetricz)
  - [Container list](#container-list)
  - [Build](#build)

## [Container list](#container-list)

- [JMusic-Bot](jmusic-bot/)
- [Minecraft](minecraft/)
- [Nextcloud](nextcloud/)
- [OpenVPN](openvpn/)
- [Technitium DNS Server](technitium/)
- [yt-archive](yt-archive/)

## [Build](#build)

```bash
make help
```

To build a specific IMAGE, run; where service is one in the docker-compose.yml:

```bash
make build IMAGE=service
```
