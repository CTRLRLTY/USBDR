#!/bin/bash

DEVPATH=/etc/udev/rules.d/80-usb-deny.rules
RUNSCRIPT=/bin/device_added

if [ ! -e $DEVPATH ]
then
  echo 'ATTR{removable}=="1", ENV{ID_USB_DRIVER}=="usb-storage", ACTION=="add", SYMLINK+="usb$env{ID_VENDOR_ID}%n"' > $DEVPATH
  echo 'ATTR{removable}=="1", ENV{ID_USB_DRIVER}=="usb-storage", ACTION=="add", RUN+="/bin/device_added $env{DEVNAME}"' >> $DEVPATH
  echo '#!/bin/bash' > $RUNSCRIPT
  chmod +x /bin/device_added
  echo 'umount ${1}[1-9]' >> $RUNSCRIPT
  echo 'mkfs.vfat ${1}[1-9]' >> $RUNSCRIPT
  echo 'echo success $1 >> /tmp/scripts.log' >> $RUNSCRIPT
  echo "file created"
else
  echo "file already exist"
fi
