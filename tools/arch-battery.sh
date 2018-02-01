#!/bin/bash

# read values
cd /sys/class/power_supply/BAT1

_charge=$(cat charge_now)
_full=$(cat charge_full_design)
_stat=$(cat status)

# calculate percentage

_perc=$(($((_charge * 100)) / $_full))

echo BAT: $_perc $_stat
