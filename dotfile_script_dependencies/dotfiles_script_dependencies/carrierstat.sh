#!/bin/bash

if [[ $(cat /sys/class/net/wlp58s0/carrier) = 1 ]]
then
  echo "online"
else
  echo "offline"
fi
