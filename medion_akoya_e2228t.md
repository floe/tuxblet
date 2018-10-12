### Sound
  * install driver/ucm from https://github.com/John-Hsu/Nuvoton/tree/master/NAU88L24/Intel-cht-bsw/kernel-4.15.x
  
### Accelerometer
  * patch drivers/iio/accel/kxcjk_1013.c
  * add ACPI ids KIOX010A/KIOX020A
  
### Lid switch
  * add button.lid_init_state=open to kernel cmdline
