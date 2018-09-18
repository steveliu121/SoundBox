Script "start.sh" initilizes the bluetooth working environment for "bluealsa",
and start "bluealsa" "bluealsa-aplay".
You can change the options as you want by modify this script.

Script "pair.sh" lets the PiSoundBox could be paired/trusted/connected in 30s
(all you need to do is just touch your phone to connect the PiSoundBox in 30s),
after 30s a new bluetooth device(.eg a new phone) will not be allowed to connect.
Note: "bluez-tools" is needed by this script, you can use "aptitude install bluez-tools"
to install.
