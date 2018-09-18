#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root (use sudo) " 1>&2
	exit 1
fi

echo "Please pair PiSoundBox to Your Phone in 30s ..."
timeout --kill-after=5 30 bt-agent -c NoInputNoOutput


echo "================================"
echo "Add device to trust list..."
echo "================================"
DEVICE_NAME=""
touch devices.txt
bt-device -l > ./devices.txt
sed -i '1d' ./devices.txt
cat ./devices.txt | while read line
do
	DEVICE_NAME=$(echo $line | awk '{print $1}')
	bt-device --set $DEVICE_NAME Trusted on
done

