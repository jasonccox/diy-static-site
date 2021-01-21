---
pagetitle: Fan Control on Armbian's Ubuntu 20.04 RockPro64 Server Image
---

# Fan Control on Armbian's Ubuntu 20.04 RockPro64 Server Image

When my old desktop PC that was acting as a home server failed on me recently, I switched back to using my [RockPro64](https://www.pine64.org/rockpro64/) for the job. Previously I'd used it with [ayufan's Debian Buster image](https://github.com/ayufan-rock64/linux-build/releases/tag/0.9.14), but this time I decided to try out [Armbian's Ubuntu 20.04 server image](https://www.armbian.com/rockpro64/) based on the 5.9 Linux kernel. Everything went beautifully -- even installing the ZFS DKMS module -- except that there doesn't seem to be any built-in fan control.

> Check out the [dedicated page about my home server](/creations/home-server.html) if you're interested in more of the details of how it's set up!

Thankfully, [this forum post](https://forum.armbian.com/topic/12936-how-to-control-fan-on-rockpro64/) had all the information I needed to eventually get [ATS](https://github.com/tuxd3v/ats) working. However, it took some digging and experimentation, so I've documented the process below. (All of these commands should be run as root.)

1. Load the `pwm-fan` kernel module:

    ```
    # modprobe pwm-fan
    ```

2. Install ATS:

    ```
    # apt install lua5.3 liblua5.3-dev luarocks gcc make
    # luarocks build https://raw.githubusercontent.com/tuxd3v/ats/master/ats-0.2-0.rockspec
    ```

3. Replace `hwmon0` with `hwmon3` in `/etc/ats.conf`'s `PWM_CTL` entry:

    ```
    # sed -i 's/hwmon0/hwmon3/' /etc/ats.conf
    ```

4. Reboot.

> Step 3 was where the trickiness came in. Originally `/etc/ats.conf` had `PWM_CTL` set to `/sys/class/hwmon/hwmon0/pwm1`, but that file didn't exist on my system, even after loading the `pwm-fan` module. With a little poking around and some help from the above-mentioned forum post, I did find `/sys/class/hwmon/hwmon2/pwm1`, and changing `PWM_CTL` to reflect that (plus a `systemctl restart ats`) initially got the fan control working. However, after a reboot, that `pwm1` file had moved to `/sys/class/hwmon/hwmon3/pwm1` and seems to have stayed there since. I'm not quite sure why my system is different in that way, but I'm glad that it's working!

*[Last updated Jan 20, 2021]*
