---
pagetitle: Creations
---

# Creations

I love creating things. It's a big part of why I enjoy software development, and it often motivates me to take a DIY approach to solve my problems. Below are some of my creations; so far they're all computer projects, but I hope to add more non-tech creations soon.

- [static-site](https://github.com/jasonccox/static-site): The code behind this website! I use [pandoc](https://pandoc.org) to convert Markdown to HTML and have a Makefile to orchestrate the whole process.

- [Home Server](home-server.html): An old desktop PC running [Nextcloud](https://nextcloud.com) and [Pi-hole](https://pi-hole.net). I've had a lot of fun getting into self-hosting and have learned tons along the way.

- [topdf](https://github.com/jasonccox/topdf): Bash script wrapper for [pandoc](https://pandoc.org) that I use to convert (primarily Markdown) files to PDFs. I appreciate pandoc's incredible power and flexibility, but I can't ever remember what options to pass to it without this script.

- [Webfolio](https://github.com/jasonccox/grav-theme-webfolio): Theme for [Grav CMS](https://getgrav.org) that powered my old portfolio website. This was one of my favorite projects because other people actually used it; I loved getting an occasional email thanking me for the theme or asking for help getting it working. (I've since moved on from Grav for simplicity's sake, but I'm still happy to help existing users! I'd also love to find a new maintainer -- [email me](mailto:hi@jasoncarloscox.com).)

- [restic-rclone](https://github.com/jasonccox/restic-rclone-docker): Dockerfile for running scheduled backups using [restic](https://restic.net) with [rclone](https://rclone.org) as the backend. I used to run this on my home server but have since abandoned it in favor of running restic and rclone directly on the host OS to integrate my backups with ZFS snapshots. (There's also an [image](https://hub.docker.com/r/jasonccox/restic-rclone) available on Docker Hub, but it's quickly becoming out-of-date...)

- [arch-install](https://github.com/jasonccox/arch-install): My [Arch Linux](https://archlinux.org) install scripts from back when I had the time to run Arch.

- [jsonbody](https://github.com/jasonccox/jsonbody): Golang middleware for receiving, validating, and sending JSON in HTTP requests/responses. A few years ago I started writing a web server in Go and was surprised that I couldn't find an easy way to manage JSON request/response bodies, so I wrote this.
