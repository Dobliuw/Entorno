#!/bin/sh  

echo "%{F#FFFF00} %{F#ffffff}$(/usr/bin/hostname -I | awk '{print $1}')%{u-}"
