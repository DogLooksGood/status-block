#!/bin/bash
# shows traffic on the specified device
# Execute every second.

INF="wlp2s0"

netFile="/tmp/.net-measure"

function human_readable {
        VALUE=$1
        BIGGIFIERS=( B K M G )
        CURRENT_BIGGIFIER=0
        while [ $VALUE -gt 10000 ] ;do
                VALUE=$(($VALUE/1000))
                CURRENT_BIGGIFIER=$((CURRENT_BIGGIFIER+1))
        done
        #echo "value: $VALUE"
        #echo "biggifier: ${BIGGIFIERS[$CURRENT_BIGGIFIER]}"
        echo "$VALUE${BIGGIFIERS[$CURRENT_BIGGIFIER]}"
}

###REAL STUFF

PREV_RX=0
PREV_TX=0

if [[ -f "${netFile}" ]]; then
    fileCont=$(cat "${netFile}")
    PREV_RX=$(echo "${fileCont}" | head -n 1)
    PREV_TX=$(echo "${fileCont}" | tail -n 1)
fi

LINE=`grep ${INF} /proc/net/dev | sed s/.*://`;
RX=`echo $LINE | awk '{print $1}'`
TX=`echo $LINE | awk '{print $9}'`

RX_SPEED=$(($RX-$PREV_RX))
TX_SPEED=$(($TX-$PREV_TX))

echo "  `human_readable $TX_SPEED`/s  `human_readable $RX_SPEED`/s "
echo "${RX}" > "${netFile}"
echo "${TX}" >> "${netFile}"
