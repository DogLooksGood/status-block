#!/bin/bash

OUTPUT=$(acpi -b)
DESC=$(echo $OUTPUT | grep -Po "\d{1,2}%, \d\d:\d\d:\d\d" | sed "s/,//")
PERCENT=$(echo $DESC | grep -Po "\d+%" | grep -Po "\d+")

CHARGING=$(echo $OUTPUT | grep -o "Charging")

ICON_COLOR="white"

if [ -n "${CHARGING}" ]; then
    ICON_COLOR="#33FF66"
fi

if [ $PERCENT -gt 75 ]; then
    ICON=""
elif [ $PERCENT -gt 50 ]; then
    ICON=""
elif [ $PERCENT -gt 25 ]; then
    ICON=""
    ICON_COLOR="yellow"
elif [ $PERCENT -gt 0]; then
    ICON=""
    ICON_COLOR="red"
else
    ICON="battery"
fi

if [ -n "${CHARGING}" ]; then
    ICON_COLOR="#33FF66"
fi

echo "<txt><span fgcolor='${ICON_COLOR}'>$ICON</span>　$DESC </txt>"
