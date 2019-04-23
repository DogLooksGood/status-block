#!/bin/bash
FULL_DESC=$(sensors | grep Package | awk '{print $4}')
TEMP=$(echo "${FULL_DESC}"| grep -Po "\d{2,3}")
ICON=""

if [[ ${TEMP} -gt 55 ]]; then
    ICON=""
else
    ICON=""
fi

printf "%s%2d°C \n" "${ICON}" "${TEMP}"
