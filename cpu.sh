#!/bin/bash
# Source: http://askubuntu.com/a/450136

PREV_TOTAL=0
PREV_IDLE=0

cpuFile="/tmp/.cpu-measure"

if [[ -f "${cpuFile}" ]]; then
  fileCont=$(cat "${cpuFile}")
  PREV_TOTAL=$(echo "${fileCont}" | head -n 1)
  PREV_IDLE=$(echo "${fileCont}" | tail -n 1)
fi

CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
unset CPU[0]                          # Discard the "cpu" prefix.
IDLE=${CPU[4]}                        # Get the idle CPU time.

# Calculate the total CPU time.
TOTAL=0

for VALUE in "${CPU[@]:0:4}"; do
  let "TOTAL=$TOTAL+$VALUE"
done

if [[ "${PREV_TOTAL}" != "" ]] && [[ "${PREV_IDLE}" != "" ]]; then
  # Calculate the CPU usage since we last checked.
  let "DIFF_IDLE=$IDLE-$PREV_IDLE"
  let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
  let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"
  if [[ $DIFF_USAGE -gt 75 ]]; then
      printf "<txt>　<span fgcolor='#FF7777'>%-2d%%</span>　</txt>" $DIFF_USAGE
  elif [[ $DIFF_USAGE -gt 35 ]]; then
      printf "<txt>　<span fgcolor='#999933'>%-2d%%</span>　</txt>" $DIFF_USAGE
  else
      printf "<txt>　%-2d%%　</txt>" $DIFF_USAGE
  fi
else
  echo "?"
fi

# Remember the total and idle CPU times for the next check.
echo "${TOTAL}" > "${cpuFile}"
echo "${IDLE}" >> "${cpuFile}"
