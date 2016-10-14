#!/bin/bash

# bash script to run sh file in the terminal emulators

# Copyright (C) 2015 Md Imam Hossain

# License
#	This program is free software; you can use it for any purposes but can not redistribute it and/or modify it.
#	This program is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY.

cd "`dirname "$0"`"

cd src

make install

if [ "$?" -ne 0 ]
then
    exit 1
fi

cd ..

cd firmware

mkdir -p /lib/firmware/

cp rt3290.bin /lib/firmware/

cd ..

cp activate-net-rt /etc/init.d/



exit 0
