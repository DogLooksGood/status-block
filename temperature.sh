#!/bin/bash
FULL_DESC=$(sensors | grep Package | awk '{print $4}')
TEMP=$(echo "${FULL_DESC}"| grep -Po "\d{2,3}")
ICON=""
COLOR=""

if [[ ${TEMP} -gt 55 ]]; then
    ICON=""
    COLOR="#FF7777"
else
    ICON=""
    COLOR="white"
fi

printf "<txt>%s　<span fgcolor='%s'>%2d°C</span>　</txt>" "${ICON}" "${COLOR}" "${TEMP}"
