#!/usr/bin

MEM=$(free -h|grep Mem|awk '{print $3}')
printf " $MEM\n"
