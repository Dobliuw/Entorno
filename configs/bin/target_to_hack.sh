#!/bin/bash

ip_address=$(cat /home/dobliuw/.config/bin/target | awk '{print $1}')
machine_name=$(cat /home/dobliuw/.config/bin/target | awk '{print $2}')

[[ "$ip_address" && "machine_name" ]] && echo "%{F#EF5350}什 %{F#ffffff}$ip_address - $machine_name." || echo "%{F#EF5350}什 No target."
