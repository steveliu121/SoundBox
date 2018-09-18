#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root (use sudo)" 1>&2
	exit 1
fi


echo -e "\n\n\n"
echo "==============================="
echo "Init bluetooth dual mode"
echo "==============================="
if test -e "/sys/class/bluetooth/hci0"; then
	btmgmt power off
	btmgmt le on
	btmgmt bredr on
	btmgmt power on
	sleep 2s
	btmgmt connectable on
	btmgmt discov on
	btmgmt advertising 2

else
	echo "Please make sure the Bluetooth moudle is loaded"
	exit 1
fi


echo -e "\n\n\n"
echo "==============================="
echo "Check dependent program"
echo "==============================="
if test $(pidof dbus-daemon); then
	echo "+++dbus-daemon is already run+++"
else
	echo "Please make sure that dbus-daemon is already running"
	echo "or you can use 'dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation' to start it"
	dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation
fi

if test $(pidof bluetoothd); then
	echo "+++bluetoothd is already run+++"
else
	echo "Please make sure that bluetoothd is already runnig"
	echo "or you can use 'bluetoothd &' to start it"
	bluetoothd &
fi


echo -e "\n\n\n"
echo "==============================="
echo "Start bluealsa"
echo "==============================="
echo "****This is the default configure, you can change it as you want****"
bluealsa -p a2dp-sink &


echo -e "\n\n\n"
echo "==============================="
echo "Start bluealsa-aplay"
echo "==============================="
echo "****This is the default configuration, you can change as you want****"
echo "Please confirm the right pcm snd card you are going to use"
echo "by default using "hw:1,0""
echo ".eg you can use 'aplay -l' to show cards your system supports"
sleep 2s
bluealsa-aplay -i hci0 -d hw:1,0 --profile-a2dp 00:00:00:00:00:00 &
