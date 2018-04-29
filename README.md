# chuwi-hi10-pro

I'm collecting all the bits and pieces here that are needed to run Ubuntu 18.04 with vanilla kernel 4.15 on the Chuwi Hi10 Pro (HQ64 series, CPU Z8350, serial number HQ64G421709xxxxx).

## GPU

Works out of the box, accelerated FullHD videos in Youtube on Firefox play smoothly.

## WiFi

RTL8723BS - works out of the box, easily getting 4 Mb/s downloads. No complaints.

## Suspend

Works out of the box, pleasant surprise :-)

## Audio

Not working (yet).

## Touchscreen

put firmware/mssl1680.fw into /lib/firmware/silead/. Needs calibration.

## Screen rotation

Works (surprisingly) out of the box.

## Bluetooth

Rather annoying, seems to require kernel patch + some custom hciattach? Since this is being worked on, I may just use an USB Bluetooth dongle in the dock for the moment.
  * https://github.com/lwfinger/rtl8723bs_bt (custom hciattach + fw)
  * https://raw.githubusercontent.com/Manouchehri/vi8/master/Ubuntu_support_files/rfkill.patch (rfkill tweak)
  * https://github.com/lwfinger/rtl8723bs_bt/issues/26 (problem with recent kernels)
  * https://github.com/Miouyouyou/MyyQi/issues/7 (lenghty discussion for similar platform)
