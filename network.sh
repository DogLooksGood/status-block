#!/bin/bash
# shows traffic on the specified device
# Execute every second.

INF=$1

netFile="/tmp/.net-measure"

function human_readable {
        VALUE=$1
        BIGGIFIERS=( B K M G )
        CURRENT_BIGGIFIER=0
        while [ $VALUE -gt 10000 ] ;do
                VALUE=$(($VALUE/1000))
                CURRENT_BIGGIFIER=$((CURRENT_BIGGIFIER+1))
        done
	printf "% 5d%s\n" "$VALUE" "${BIGGIFIERS[$CURRENT_BIGGIFIER]}"
}

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

RX_SPD_RAW=$(($RX-$PREV_RX))
TX_SPD_RAW=$(($TX-$PREV_TX))

RX_SPD=$(human_readable $RX_SPD_RAW)
TX_SPD=$(human_readable $TX_SPD_RAW)

if [ $TX_SPD_RAW -eq 0 ]; then
    echo "<txt>　${TX_SPD}"
else
    echo "<txt><span fgcolor='yellow'></span>　${TX_SPD}"
fi
if [ $RX_SPD_RAW -eq 0 ]; then
    echo "　${RX_SPD}　</txt>"
else
    echo "<span fgcolor='#22FF33'></span>　${RX_SPD}　</txt>"
fi


#echo "${TX_SPD}"

echo "${RX}" > "${netFile}"
echo "${TX}" >> "${netFile}"
