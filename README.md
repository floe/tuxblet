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

RTL8723BS - works out of the box, easily getting 4 Mb/s downloads. No complaints.

### Suspend

Works out of the box, pleasant surprise :-)

### Audio

Not working (yet). See:
  * https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
  * https://github.com/AdamWill/baytrail-m/blob/master/alsa/t100_B.state

### Touchscreen

Silead MSSL1680

put `mssl1680.fw` into `/lib/firmware/silead/`. Needs calibration. See:
  * https://github.com/onitake/gsl-firmware/tree/master/firmware/chuwi/hi10_pro-z8350
  * https://github.com/pbnelson/rotswap/
  
### Screen rotation

Works (surprisingly) out of the box.

### Bluetooth

RTL8723BS - rather annoying, seems to require kernel patch + some custom hciattach? Since this is being worked on, I may just use an USB Bluetooth dongle in the dock for the moment.
  * https://github.com/lwfinger/rtl8723bs_bt (custom hciattach + fw)
  * https://raw.githubusercontent.com/Manouchehri/vi8/master/Ubuntu_support_files/rfkill.patch (rfkill tweak)
  * https://github.com/lwfinger/rtl8723bs_bt/issues/26 (problem with recent kernels)
  * https://github.com/Miouyouyou/MyyQi/issues/7 (lenghty discussion for similar platform)

### Cameras

Will probably be enabled when CONFIG_INTEL_ATOMISP matures (Atom Imaging Signal Processor).

### Sources:
  * https://github.com/danielotero/linux-on-hi10
  * https://wiki.gnome.org/BastienNocera/Ondav975w
  * https://jonathansblog.co.uk/hardware-hacking
  * https://forum.chuwi.com/thread-2341-1-1.html
  * https://txlab.wordpress.com/2017/03/11/running-ubuntu-on-chuwi-hi10-pro-tablet/
