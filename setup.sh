#!/bin/bash

# bash script to run sh file in the terminal emulators

# Copyright (C) 2015 Md Imam Hossain

# License
#	This program is free software; you can use it for any purposes but can not redistribute it and/or modify it.
#	This program is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY.

rm -Rf src

if lspci -n | grep -o -q '1814:3290'; then 
    echo "Ralink corp. RT3290 Wireless controller detected"
    echo "This will setup Ralink corp. RT3290 Wireless Wireless Driver"
    echo "This setup package is created by Md Imam Hossain <imamdxl8805@gmail.com>"
    echo ""
    sleep 4
else
    echo "Cannot find Ralink corp. RT3290 Wireless controller"
    read -p "Press [Enter] key to exit"
    exit 1
fi

cd "`dirname "$0"`"

echo ""
echo "Installing driver build dependencies ..."
sleep 1
echo ""

sudo ./deps.sh

if [ "$?" -ne 0 ]
then
    echo "Can not install dependencies"
    echo "Continuing anyway ..."
else
    echo "[Done]"
    sleep 1
fi

echo ""
echo "Extracting driver source ..."
sleep 1
echo ""

./extract.sh > /dev/null 2>&1

if [ "$?" -ne 0 ]
then
    echo "Can not extract src.tar.gz"
    read -p "Press [Enter] key to exit"
    exit 1
fi

echo "[Done]"
sleep 1

echo ""
echo "Compiling driver source, this will take a while ..."
sleep 1
echo ""

./compile.sh > /dev/null 2>&1

if [ "$?" -ne 0 ]
then
    echo "Can not compile the driver"
    read -p "Press [Enter] key to exit"
    exit 1
fi

echo "[Done]"
sleep 1

echo ""
echo "Installing the driver ..."
sleep 1
echo ""

sudo ./install.sh > /dev/null 2>&1

if [ "$?" -ne 0 ]
then
    echo "Can not install the driver"
    read -p "Press [Enter] key to exit"
    exit 1
fi

echo "[Done]"
sleep 1

echo ""
echo "Disabling the conflicting builtin kernel drivers ..."
sleep 1
echo ""

sudo ./blacklist.sh > /dev/null 2>&1

if [ "$?" -ne 0 ]
then
    echo "Can not disable the conflicting drivers"
    echo
    echo "Rolling back the RT3290 driver installation ..."
    sleep 1
    sudo ./uninstall.sh > /dev/null 2>&1
    echo "[Done]"
    read -p "Press [Enter] key to exit"
    exit 1
fi

echo "[Done]"
sleep 1

echo ""
echo "Trying to load the driver ..."
sleep 1
echo ""

sudo ./load.sh > /dev/null 2>&1

if [ "$?" -ne 0 ]
then
    echo "Can not load the driver"
    echo
    echo "Rolling back the RT3290 driver installation ..."
    sleep 1
    sudo ./uninstall.sh > /dev/null 2>&1
    echo "[Done]"
    read -p "Press [Enter] key to exit"
    exit 1
fi

echo "[Done]"
sleep 1

echo
echo
echo "Setup was successful."
echo
read -p "Press [Enter] key to exit"

exit 0
