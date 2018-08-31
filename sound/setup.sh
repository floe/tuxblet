#!/bin/bash

cp -a bytcr-rt5651/ /usr/share/alsa/ucm/
chmod -R go+rX /usr/share/alsa/ucm/bytcr-rt5651/

cp blacklist-hdmi-lpe-audio.conf /etc/modprobe.d/
chmod 644 /etc/modprobe.d/blacklist-hdmi-lpe-audio.conf
