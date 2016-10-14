#!/bin/bash

# bash script to run sh file in the terminal emulators

# Copyright (C) 2015 Md Imam Hossain

# License
#	This program is free software; you can use it for any purposes but can not redistribute it and/or modify it.
#	This program is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY.

cd "`dirname "$0"`"

cd src

make uninstall

rm /lib/firmware/rt3290.bin

rm /etc/modprobe.d/blacklist-ralink.conf

update-rc.d activate-net-rt remove

rm /etc/init.d/activate-net-rt

exit 0
