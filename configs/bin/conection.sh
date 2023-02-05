#!/bin/bash

active=$(service networking status | grep "active")

[[ "$active" ]] && echo -e " " || echo -e "睊"
