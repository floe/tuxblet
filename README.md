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

### WiFi

RTL8723BS - works out of the box, easily getting 4 MB/s downloads. No complaints.

### Suspend

Works out of the box, pleasant surprise :-)

### Screen rotation

Works (surprisingly) out of the box. Thanks systemd ;-)

### Audio

Not working (yet). See:
  * https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
  * https://github.com/AdamWill/baytrail-m/blob/master/alsa/t100_B.state

### Touchscreen

Silead MSSL1680

  * copy `mssl1680.fw` from this repo into `/lib/firmware/silead/`.
  * Calibration: use https://github.com/reinderien/xcal to get xinput calibration matrix (ye olde `xinput_calibrator` won't work)
  * `xinput --map-to-output silead_ts DSI-1`
  
### Bluetooth

RTL8723BS - rather annoying, seems to require kernel patch + some custom hciattach? Since this is being worked on, I may just use an USB Bluetooth dongle in the dock for the moment.
  * https://github.com/lwfinger/rtl8723bs_bt (custom hciattach + fw)
  * https://raw.githubusercontent.com/Manouchehri/vi8/master/Ubuntu_support_files/rfkill.patch (rfkill tweak)
  * https://github.com/lwfinger/rtl8723bs_bt/issues/26 (problem with recent kernels)
  * https://github.com/Miouyouyou/MyyQi/issues/7 (lenghty discussion for similar platform)

### Cameras

Will probably be enabled when CONFIG_INTEL_ATOMISP matures (Atom Imaging Signal Processor).

### USB Connectors

Charging via USB-C connector works.

### Micro HDMI Connector

Untested.

### Volume Buttons

Not working (yet).

### Sources:
  * Generic tips: https://github.com/danielotero/linux-on-hi10
  * Similar HW: https://wiki.gnome.org/BastienNocera/Ondav975w
  * Generic tips: https://jonathansblog.co.uk/hardware-hacking
  * Factory restore: https://forum.chuwi.com/thread-2341-1-1.html
  * Generic tips: https://txlab.wordpress.com/2017/03/11/running-ubuntu-on-chuwi-hi10-pro-tablet/
  * Touchscreen FW: https://github.com/onitake/gsl-firmware/tree/master/firmware/chuwi/hi10_pro-z8350
  
