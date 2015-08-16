#!/bin/bash

# Apply wacom settings script
#   Checks ~/.profile for "wacom" and if not there appends the wacom
#   settings found in this file.

function wacom {
    echo >> ~/.profile
    echo "# Wacom settings" >> ~/.profile
    echo "xsetwacom set 'Wacom Intuos3 6x8 stylus' Button 2 3" >> ~/.profile
    echo "xsetwacom set 'Wacom Intuos3 6x8 stylus' Button 3 2" >> ~/.profile
}

grep -q Wacom ~/.profile || wacom
