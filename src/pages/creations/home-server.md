---
pagetitle: Home Server
---

# Home Server

I have an old desktop computer that I use as a home server for my family's storage needs. The server primarily runs [Nextcloud](https://nextcloud.com), a self-hosted cloud storage and collaboration platform. It also runs [Pi-hole](https://pi-hole.net), which acts as a DNS server for our LAN. I sometimes to write about my server on my [blog](/blog), so check that out if you're intersted in what I've been up to lately.

## Software

My server runs Debian 10, but its various services are all containerized and managed with Docker compose:

- [Nextcloud](https://hub.docker.com/_/nextcloud) - cloud storage and collaboration application
- [MariaDB](https://hub.docker.com/_/mariadb) - database for Nextcloud
- [Redis](https://hub.docker.com/_/redis) - memcache for Nextcloud
- [Pi-hole](https://hub.docker.com/r/pihole/pihole) - DNS server
- [Traefik](https://hub.docker.com/_/traefik) - reverse proxy

I use [restic](https://restic.net) and [rclone](https://rclone.org) to run regular backups. [This nifty program](https://github.com/anaganisk/digitalocean-dynamic-dns-ip) keeps my DNS records updated since I don't have a static IP address. And a [WireGuard VPN](https://www.wireguard.com/) makes it possible for me to connect when I'm away from home.

## Storage

The server has two 1 TB hard drives, which act as mirrors under the ZFS filesystem.

## Hardware

The server is an HP Compaq Elite 8300 SFF with the following key components:

- Intel Core i7-3770 CPU
- 16 GB DDR3 RAM
- 128 GB SSD
- two 1 TB Western Digital Red hard drives
