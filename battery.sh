#!/bin/bash

DESC=$(acpi -b | grep -Po "\d{1,2}%, \d\d:\d\d:\d\d" | sed "s/,//")
PERCENT=$(echo $DESC | grep -Po "\d+%" | grep -Po "\d+")

CHARGING=$(acpi -b | grep -o "Charging")


if [ $PERCENT -gt 75 ]
then
    ICON=""
elif [ $PERCENT -gt 50 ]
then
    ICON=""
elif [ $PERCENT -gt 25 ]
then
    ICON=""
else
    ICON=""
fi

echo "$ICON$DESC $CHARGING"
