---
pagetitle: Home Server
---

# Home Server

I have a single-board computer that I use as a home server for my family's storage needs (and for fun!). The server primarily runs [Nextcloud](https://nextcloud.com), a self-hosted cloud storage and collaboration platform. It also runs [Pi-hole](https://pi-hole.net), which acts as a DNS server for our LAN. I sometimes to write about my server on my [blog](/blog), so check that out if you're interested in what I've been up to lately.

## Software

My server runs [Armbian's Ubuntu 20.04 server image](https://www.armbian.com/rockpro64/), but its various services are all containerized and managed with Docker compose:

- [Nextcloud](https://hub.docker.com/_/nextcloud) - cloud storage and collaboration application
- [MariaDB](https://hub.docker.com/_/mariadb) - database for Nextcloud
- [Redis](https://hub.docker.com/_/redis) - memcache for Nextcloud
- [Pi-hole](https://hub.docker.com/r/pihole/pihole) - DNS server
- [Traefik](https://hub.docker.com/_/traefik) - reverse proxy

I use [restic](https://restic.net) and [rclone](https://rclone.org) to run regular backups. [This nifty program](https://github.com/anaganisk/digitalocean-dynamic-dns-ip) keeps my DNS records updated since I don't have a static IP address. And a [WireGuard VPN](https://www.wireguard.com/) makes it possible for me to connect when I'm away from home.

## Storage

The server has two 1 TB hard drives, which act as mirrors under the ZFS file system.

## Hardware

The server is a [Pine64 RockPro64](https://www.pine64.org/rockpro64/) in a [NAS case](https://pine64.com/product/rockpro64-metal-desktop-nas-casing/). It has [Pine64's largest heat sink](https://pine64.com/product/rockpro64-30mm-tall-profile-heatsink/) and a [fan](https://pine64.com/product/fan-for-rockpro64-metal-desktop-nas-casing/) for active cooling. Two 1TB Western Digital Red hard drives are connected via a [PCI-E to SATA adapter](https://pine64.com/product/rockpro64-pci-e-to-dual-sata-ii-interface-card/).

## Tweaks

- Armbian's Ubuntu image is great and for the most part just works -- even with the ZFS DKMS module. However, it's missing any sort of fan control, so I had to figure that out myself with the help of [ATS](https://github.com/tuxd3v/ats) and [this forum post](https://forum.armbian.com/topic/12936-how-to-control-fan-on-rockpro64/). It was a bit complicated for me, so I wrote a [blog post](/blog/rockpro64-fan-control.html) with the exact details.

- By default, `systemd-resolved` is running on port 53 on Ubuntu. Since I'm using Pi-hole as my DNS server, I need it to be on port 53 instead. [This article](https://www.linuxuprising.com/2020/07/ubuntu-how-to-free-up-port-53-used-by.html) explains how to stop `systemd-resolved` from using port 53.

*[Last updated Jan 20, 2021]*
