---
pagetitle: On Self-Hosting
---

# On Self-Hosting

<div class="text-center">*[Last updated June 30, 2020]*</div>

Ever since I aquired an old hand-me-down PC a few years ago, I've been interested in running a home server. When I got that computer, I tried self-hosting a [Nextcloud](https://nextcloud.com) instance but gave up quickly - my Linux skills were nearly non-existent, and the increase I saw in my electricity bills was about as much as I would have been saving by ditching my cloud storage provider. All in all, I figured I'd be better off letting professionals keep track of my important data.

It wasn't long before I decided to give self-hosting another shot, though. Facing expanding storage needs and armed with more Linux skills and development experience, I started thinking about Nextcloud again. The hosts of the aptly-named [Self-Hosted](https://selfhosted.show/) podcasts were always talking about running all kinds of server applications with Docker, so I determined to try doing just that.

I started experimenting with the [official Nextcloud Docker image](https://hub.docker.com/_/nextcloud/) and discovered that using a containerized application is *much* easier than worrying about all the dependencies myself. In my first attempt at self-hosting, I'd been overwhelmed by installing and configuring PHP, MariaDB, Apache, and Nextcloud all at once, but Docker simplified things immensely.

I also lowered the stakes by [using a VPN](https://github.com/trailofbits/algo) to access the server instead of opening it up to the public Internet - I don't trust my server admin skills enough to take on a whole world of cyber criminals. (Hopefully I'll write another post about that soon.) In the process of setting up the VPN, I wound up installing [Pi-hole](https://pi-hole.net) on my server as well. Thanks to Docker, adding another service felt simple and exciting rather than overwhelming, and that's when I realized that I'd caught the self-hosting bug.

Since then, I've wondered why self-hosting is so satisfying. The feeling I get from hosting my own cloud services is akin to the fulfillment that comes from fixing an appliance or building a new shelf for my home. Running my own server also provides me with the opportunity to practice some of the administration skills that can really come in handy as a software developer. Additionally, I'm sick of the lack of privacy available from cloud services, so self-hosting is a natural solution.

At the end of the day, though, it's not about costs and benefits anymore; to me, it just feels fun! If you've never tried self-hosting, I highly recommend finding an old PC (or getting a cheap single-board computer) and playing around - you may just catch the bug too.
