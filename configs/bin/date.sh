#!/bin/bash

month=$(date -u | awk '{print $3}')
day=$(date -u | awk '{print $2}')
hour=$(date -u | awk '{print $5}')

echo " $month $day | $hour"
