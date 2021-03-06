# Ubuntu Linux 18.04.1 on the Chuwi Hi10 Pro

I'm collecting all the bits and pieces here that are needed to run Ubuntu 18.04.1 on the Chuwi Hi10 Pro.

### My device:

  * Chuwi Hi10 ___Pro___
  * HQ64 series, CPU Atom x5-Z8350
  * serial number HQ64G421709xxxxx
  * BIOS version P1D6_C109D_B.237 x64
  * Ubuntu 18.04.1, stock HWE kernel 4.18
  
### Installation

  * Create USB install stick with Ubuntu 18.04.1
  * To boot from an external medium, press F7 when the CHUWI logo appears.
  * After installation, reboot and hit F7 again, then select "ubuntu".
  * If boot hangs with "Started user manager for UID 120" (or similar):
    * Switch to text console with Ctrl-Alt-F4
    * Edit `/etc/gdm3/custom.conf`
    * Set `WaylandEnable=false`
    
### Linux/Android Dual-Boot

This part is especially tricky, since there are so many poorly- or un-documented bits and pieces involved.

The built-in touch-enabled boot selector just seems to check for two files on the EFI System Partition:

  * `/EFI/BOOT/bootx64.efi` for Android (identical to `/loader.efi` on the default EFI layout)
  * `/EFI/Microsoft/Boot/bootmgfw.efi` for Windows

Consequently, after Windows has been replaced by Ubuntu, copying the `/EFI/ubuntu/` folder to `/EFI/Microsoft/Boot/` and renaming `shimx64.efi` to `bootmgfw.efi` allows booting Linux via the Windows boot selection entry.

Unfortunately, this still causes the Android install to hang on boot after Linux has been installed. I was assuming, for a very long time, that this is also an EFI-related problem. However, after _multiple_ factory resets (see https://forum.chuwi.com/thread-2341-1-1.html and https://01.org/node/2463 for instructions), I finally found out that the problem is related to the very eager Ubuntu automounter, which grabs any ext4 filesystem it can find and mounts it read-write. 

Of course, this shouldn't be a problem in theory, but this also happens for the Android system/data/etc. partitions, and whatever Ubuntu does to the ext4 FS when it's mounted, causes Android to croak. This means that even just booting a Ubuntu Live System from USB one single time will likely render the Android installation unbootable.

I've finally managed to fix this by setting the respective UUIDs to `noauto` in `/etc/fstab` as follows:

    # do _not_ automount the Android partitions
    UUID=57f8f4bc-abf4-655f-bf67-946fc0f9f25b  /none ext4 ro,noauto 0 0
    UUID=57f8f4bc-abf4-655f-bf67-946fc0f9f25b1 /none ext4 ro,noauto 0 0
    UUID=57f8f4bc-abf4-655f-bf67-946fc0f9f25b2 /none ext4 ro,noauto 0 0
    UUID=57f8f4bc-abf4-655f-bf67-946fc0f9f25b3 /none ext4 ro,noauto 0 0

If you look closely, you will notice that entries 2-4 are not actually proper UUIDs, they have an additional digit from 1-3 at the very end. The reason for this is that all the Android partitions (system, cache, data, config) have the _same_ UUID and show up with the extra digit when the automounter grabs them. I'm not sure if this UUID duplication might actually be the root cause...

As a hotfix, when booting from a live USB stick, you can also add `systemd.mask=udisks2` to the kernel commandline.

## Hardware

### GPU

Intel HD Graphics - works out of the box, accelerated FullHD videos in Youtube on Firefox play smoothly.

### Backlight Control

Works OOB on 4.18 (not on 4.15, see https://bugs.freedesktop.org/show_bug.cgi?id=96571)

### WiFi

RTL8723BS - works out of the box, easily getting 4 MB/s downloads. No complaints.

### Suspend

Works out of the box, pleasant surprise :-)

### Screen rotation

Works (surprisingly) out of the box. Thanks systemd ;-)

### Audio

Headphones work wih the UCM files from alsa-lib-1.1.6 (see `sound/`).
Speakers need some GPIO tweaking (see https://github.com/danielotero/linux-on-hi10/issues/8 for details).

### Touchscreen

Silead MSSL1680

  * copy `mssl1680.fw` from this repo into `/lib/firmware/silead/`.
  * Calibration: use https://github.com/reinderien/xcal to get xinput calibration matrix, say `n` to "Use rotation?"
  * ye olde `xinput_calibrator` won't work anymore
  * `xinput --map-to-output silead_ts DSI-1`
  
### Bluetooth

RTL8723BS - rather annoying, seems to require kernel patch + some custom hciattach? Since this is being worked on, I may just use an USB Bluetooth dongle in the dock for the moment. Proper solution seems to be on track for kernel 4.19 or maybe 4.20: https://patchwork.kernel.org/cover/10553793/
  * https://github.com/lwfinger/rtl8723bs_bt (custom hciattach + FW)
  * https://github.com/jwrdegoede/linux-sunxi/commit/95440719e05c790f1bd91ed459708df476c7fdd3 (hacky kernel patch)
  * https://raw.githubusercontent.com/Manouchehri/vi8/master/Ubuntu_support_files/rfkill.patch (rfkill tweak)

### Cameras

Will probably be enabled when CONFIG_INTEL_ATOMISP matures (Atom Imaging Signal Processor). However, this may take quite some time: https://bugzilla.kernel.org/show_bug.cgi?id=109821

### USB Connectors

Charging via USB-C connector works.  
Micro-USB connector untested.

### Micro HDMI Connector

Untested.

## Sources:
  * Generic tips: https://github.com/danielotero/linux-on-hi10
  * Similar HW: https://wiki.gnome.org/BastienNocera/Ondav975w
  * Generic tips: https://jonathansblog.co.uk/hardware-hacking
  * Factory restore: https://forum.chuwi.com/thread-2341-1-1.html
  * Generic tips: https://txlab.wordpress.com/2017/03/11/running-ubuntu-on-chuwi-hi10-pro-tablet/
  * Touchscreen FW: https://github.com/onitake/gsl-firmware/tree/master/firmware/chuwi/hi10_pro-z8350
  * Factory images: https://forum.chuwi.com/forum.php?mod=viewthread&tid=2341
  * Russian forum: https://w3bsit3-dns.com/forum/index.php?showtopic=769658&st=5160

## Additional Notes

(supposed) BIOS reset procedure, found in Russian forum:
  * Turn off the tablet.
  * Hold the power key for 15-20 seconds.
  * Release the button for 10-15 seconds.
  * Turn it on as usual.
  * All BIOS is reset to default.
