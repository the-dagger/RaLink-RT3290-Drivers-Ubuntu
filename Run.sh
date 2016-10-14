#!/bin/bash

# bash script to run sh files in the terminal emulators

# Copyright (C) 2014-2015 Md Imam Hossain

# License
#	This program is free software; you can use it for any purposes but can not redistribute it and/or modify it.
#	This program is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY.

RRVal=0

CDIR="`dirname "$0"`"

if [ $CDIR == "." ]; then
    CDIR="`pwd`"
fi

cd $CDIR

if [ -f /usr/bin/gnome-terminal ]
then
    /usr/bin/gnome-terminal --title="RT3290 Driver installation" --working-directory="$CDIR" -e "./setup.sh"
    RRVal=$?
elif [ -f /usr/bin/konsole ]
then
    /usr/bin/konsole --workdir="$CDIR" --hide-menubar --show-tabbar  -e ./setup.sh
    RRVal=$?
elif [ -f /usr/bin/xterm ]
then
    /usr/bin/xterm -title "RT3290 Driver installation" -e "cd \"$CDIR\" && ./setup.sh"
    RRVal=$?
else
    echo "Can not start installation, please check if you have terminal emulator installed" > tempm
    xdg-open tempm
fi

if [ $RRVal -ne 0 ]
then
    echo "Installation was unsuccessful" > tempm
    xdg-open tempm
fi

exit $RRVal
