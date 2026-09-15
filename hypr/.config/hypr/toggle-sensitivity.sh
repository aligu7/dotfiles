#!/bin/bash

# Values you want to toggle between
LOW="0"
HIGH="-0.7" # (mouse)

current=$(hyprctl getoption input:sensitivity -j | jq -r '.float')

if (($(echo "$current == $LOW" | bc -l))); then
  hyprctl keyword input:sensitivity "$HIGH"
else
  hyprctl keyword input:sensitivity "$LOW"
fi
