#!/bin/sh

#test -f /usr/share/acpi-support/key-constants || exit 0

BRIGHTNESS=$(cat /sys//devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness)
if [ x"$1" = x"down" ]; then
        echo "$(( $BRIGHTNESS - 100))" > /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness
else
        echo "$(( $BRIGHTNESS + 100))" > /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness
fi

#if [ ! -x /usr/bin/toshset ]; then
#        exit;
#fi
#BRIGHTNESS=$(/usr/bin/toshset -q inten | sed 's/^ lcd intensity: \([0-7]\)\/7/\1/')

#if [ x"$1" = x"down" ]; then
#        /usr/bin/toshset -inten $(( $BRIGHTNESS - 1)) > /dev/null
#else
#        /usr/bin/toshset -inten $(( $BRIGHTNESS + 1)) > /dev/null
#fi
