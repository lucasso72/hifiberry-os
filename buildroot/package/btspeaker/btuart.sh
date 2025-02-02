#!/bin/sh

echo "Calculating Bluetooth address"
if grep -q "Pi 4" /proc/device-tree/model; then
  BDADDR=
else
  SERIAL=`cat /proc/device-tree/serial-number | cut -c9-`
  B1=`echo $SERIAL | cut -c3-4`
  B2=`echo $SERIAL | cut -c5-6`
  B3=`echo $SERIAL | cut -c7-8`
  BDADDR=`printf b8:27:eb:%02x:%02x:%02x $((0x$B1 ^ 0xaa)) $((0x$B2 ^ 0xaa)) $((0x$B3 ^ 0xaa))`
fi

/opt/hifiberry/bin/bootmsg "Attaching Bluetooth interface"

uart0_pins="`wc -c /proc/device-tree/soc/gpio@7e200000/uart0_pins/brcm\,pins | cut -f 1 -d ' '`"
if [ "$uart0_pins" = "16" ] ; then
	# This line is necessary to sort out the flow control pins
	stty -F /dev/ttyAMA0 115200 raw -echo
	/usr/bin/hciattach -n /dev/ttyAMA0 bcm43xx 3000000 flow - $BDADDR
        if [ "$?" != "0" ]; then
          echo "Failed"
          /opt/hifiberry/bin/bootmsg "Attaching Bluetooth interface"
        fi
else
	echo "Looks like an Raspberry Pi 3 without flow control, BT audio will not work reliably"
	/usr/bin/hciattach -n /dev/ttyAMA0 bcm43xx 460800 noflow - $BDADDR
fi

