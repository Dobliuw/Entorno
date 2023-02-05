#!/bin/bash

tun0=$(/usr/sbin/ifconfig | grep "tun0" -A 1 | grep inet | awk 'NF{print $NF}')

[[ "$tun0" ]] && echo "%{F#BFFF00} %{F#ffffff}$tun0" || echo "%{F#EF5350} Disconected."


