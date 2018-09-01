# Ubuntu Linux 18.04.1 on the Chuwi Hi10 Pro

I'm collecting all the bits and pieces here that are needed to run Ubuntu 18.04.1 on the Chuwi Hi10 Pro.

### My device:
  * Chuwi Hi10 ___Pro___
  * HQ64 series, CPU Atom x5-Z8350
  * serial number HQ64G421709xxxxx
  * Ubuntu 18.04.1, stock kernel 4.15
  
### Installation

  * Create USB install stick with Ubuntu 18.04.1
  * To boot from an external medium, press F7 when the CHUWI logo appears.
  * After installation, reboot and hit F7 again, then select "ubuntu".
  * If boot hangs with "Started user manager for UID 120" (or similar):
    * Switch to text console with Ctrl-Alt-F4
    * Edit `/etc/gdm3/custom.conf`
    * Set `WaylandEnable=false`

### GPU

Intel HD Graphics - works out of the box, accelerated FullHD videos in Youtube on Firefox play smoothly.

### Backlight Control

see https://bugs.freedesktop.org/show_bug.cgi?id=96571 - probably just needs to throw i915 out of initrd, or otherwise force i2c-designware-pci to be loaded ASAP on boot (kernel cmdline?).

### WiFi

RTL8723BS - works out of the box, easily getting 4 MB/s downloads. No complaints.

### Suspend

Works out of the box, pleasant surprise :-)

### Screen rotation

Works (surprisingly) out of the box. Thanks systemd ;-)

### Audio

Headphones work wih the UCM files from alsa-lib-1.1.6 (see `sound/`).
Speakers need some GPIO tweaking.

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

### Sources:
  * Generic tips: https://github.com/danielotero/linux-on-hi10
  * Similar HW: https://wiki.gnome.org/BastienNocera/Ondav975w
  * Generic tips: https://jonathansblog.co.uk/hardware-hacking
  * Factory restore: https://forum.chuwi.com/thread-2341-1-1.html
  * Generic tips: https://txlab.wordpress.com/2017/03/11/running-ubuntu-on-chuwi-hi10-pro-tablet/
  * Touchscreen FW: https://github.com/onitake/gsl-firmware/tree/master/firmware/chuwi/hi10_pro-z8350

