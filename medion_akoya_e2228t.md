### Sound
  * install driver/ucm from https://github.com/John-Hsu/Nuvoton/tree/master/NAU88L24/Intel-cht-bsw/kernel-4.15.x
  * no microphone support (yet?)
  
### Accelerometer
  * patch drivers/iio/accel/kxcjk_1013.c
  * add ACPI ids KIOX010A/KIOX020A
  * double accelerometer support WIP: https://github.com/hadess/iio-sensor-proxy/issues/166
  
### Lid switch
  * add button.lid_init_state=open to kernel cmdline
  * tablet constantly suspends otherwise

### Misc
  * add MOZ_USE_XINPUT2=1 to /etc/environment for Firefox to use touch scrolling
