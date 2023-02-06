# [Containers-Tetricz](#containers-tetricz)

[![JMusic-Bot](https://jenkins.tetricz.com/buildStatus/icon?job=Container+Builds%2FJMusic-Bot+Container+Build&subject=JMusic-Bot&style=flat-square)](https://jenkins.tetricz.com/job/Container%20Builds/job/JMusic-Bot%20Container%20Build/)
[![Minecraft](https://jenkins.tetricz.com/buildStatus/icon?job=Container+Builds%2FMinecraft-Containers&subject=Minecraft&style=flat-square)](https://jenkins.tetricz.com/job/Container%20Builds/job/Minecraft-Containers/)
[![Nextcloud](https://jenkins.tetricz.com/buildStatus/icon?job=Container+Builds%2FNextcloud+Container+Build&subject=Nextcloud&style=flat-square)](https://jenkins.tetricz.com/job/Container%20Builds/job/Nextcloud%20Container%20Build/)
[![OpenVPN](https://jenkins.tetricz.com/buildStatus/icon?job=Container+Builds%2FOpenVPN+Container+Build&subject=OpenVPN&style=flat-square)](https://jenkins.tetricz.com/job/Container%20Builds/job/OpenVPN%20Container%20Build/)
[![Technitium-DNS-Server](https://jenkins.tetricz.com/buildStatus/icon?job=Container+Builds%2FTechnitium-DNS-Server+Container+Build&subject=Technitium-DNS-Server&style=flat-square)](https://jenkins.tetricz.com/job/Container%20Builds/job/Technitium-DNS-Server%20Container%20Build/)
[![YT-Archive](https://jenkins.tetricz.com/buildStatus/icon?job=Container+Builds%2FYT-Archive+Build&subject=YT-Archive&style=flat-square)](https://jenkins.tetricz.com/job/Container%20Builds/job/YT-Archive%20Build/)

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
