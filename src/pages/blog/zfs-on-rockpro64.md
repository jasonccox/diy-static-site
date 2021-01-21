---
pagetitle: Setting Up ZFS on a ROCKPro64 Running Debian Buster
---

# Setting Up ZFS on a ROCKPro64 Running Debian Buster

**Update: Although the method described below does work, I eventually switched to [Armbian's Ubuntu 20.04 server image](https://www.armbian.com/rockpro64/), and the ZFS DKMS module works there without any extra hacking.**

I recently got a [ROCKPro64](https://www.pine64.org/rockpro64/) single-board computer that I'm planning to use as a home server. Once it arrived, I quickly discovered that setting up [ZFS](https://en.wikipedia.org/wiki/ZFS) on it was going to be a bit tricky because there were issues building DKMS modules. After a few hours of troubleshooting, I finally figured it out, so I thought I'd write up what I did in hopes that it'll help someone else get ZFS installed more easily.

I initially discovered a fairly involved way of getting it all to work (see "The Hard Way" below), but later I found an easier way (see "The Easy Way" below). I'd recommend starting with the easy way and only resorting to the hard way if that doesn't work.

Both of these methods worked for me on [ayufan's minimal Debian Buster image](https://github.com/ayufan-rock64/linux-build) running kernel `4.4.190-1233-rockchip-ayufan-gd3f1be0ed310`.

## The Easy Way

1. Delete `/usr/src/linux-headers-<version>/scripts/gcc-wrapper.py`.
2. Install `dksm`, `spl-dkms`, `zfs-dkms`, and `zfsutils-linux`.
3. Load the zfs module - `modprobe zfs`.

I discovered this method thanks to [this GitHub issue comment](https://github.com/ayufan-rock64/linux-build/issues/252#issuecomment-484998288).

## The Hard Way

1. Install `devscripts` and `python`.
2. Install `dkms` and `spl-dkms`. The latter will likely fail with errors about the DKMS build failing.
3. `cd` to `/usr/src/linux-headers-4.4.190-1233-rockchip-ayufan-gd3f1be0ed310` and run `make scripts`. You may see some errors. If there is an error about missing `classmap.h`, you can comment out the line in `scripts/Makefile` that ends with `+= selinux`. I also saw some other errors about a few other headers missing from `tools/`. I fixed that by downloading the kernel source from ayufan's [repo](https://github.com/ayufan-rock64/linux-kernel/releases) and then copying the needed files from `tools/include/tools/` in the full kernel source to `tools/include/tools/` in the headers. Once `make scripts` runs successfully, you can proceed.
4. Edit `/var/lib/dkms/spl/<spl version>/source/configure`. There will be two instances of these lines:

   ```
   kuid_t userid = KUIDGT_INIT(0);
   kgid_t groupid = KGIDT_INIT(0);
   ```

   Those can be deleted. There will also be two instances of these lines:

   ```
   kuid_t userid = 0;
   kgid_t groupid = 0;
   ```

   Remove the `= 0` part of both of those.
5. Reinstall `spl-dkms`. It should succeed now.
6. Install `zfs-dkms` and `zfsutils-linux`.
3. Load the zfs module - `modprobe zfs`.

I discovered this method thanks to [this Github issue comment](https://github.com/ayufan-rock64/linux-build/issues/252#issuecomment-423789283) and [this Armbian forum post](https://forum.armbian.com/topic/6789-build-zfs-on-rk3328/?tab=comments#comment-53681).

## Notes

Via the easy way, I tried installing `dkms`, `spl-dkms`, `zfs-dkms`, and `zfsutils-linux` all from the normal repo as well as from `buster-backports` as the [Debian docs on ZFS](https://wiki.debian.org/ZFS) say to do. I only tried installing them from the normal repo when doing the hard way, but I would guess they would install from `buster-backports` as well.

*[Last updated Jan 20, 2021]*
