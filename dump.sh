#!/usr/local/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Copyright 2020 Cale "Yavin" Woodley

# You can download the latest version of this script from:
# https://github.com/cwoodley/retrode-copy_MiSTer

# User settings
SOURCE=/Volumes/Retrode # Path to where retrode is mounted
DESTINATION_ROOT=~/stuff/temp/ # Root path for roms to get copied to e.g Games

# Core specific paths
# If your DESTINATION_ROOT is Games and PATH_SNES is snes,
# *.sfc files will be copied to Games/snes
PATH_SNES=snes
PATH_MD=megadrive # Mega Drive/Genesis
PATH_GB=gameboy # GB, GBC
PATH_GBA=gba
PATH_SMS=sms # Sega Master System & Game Gear

# Do not modify below
declare -A rominfo
rompaths=( [sfc]=$PATH_SNES [bin]=$PATH_MD [gb]=$PATH_GB [gba]=$PATH_GBA [sms]=$PATH_SMS [gg]=$PATH_SMS )

for ext in "${!rompaths[@]}";
do
    :
    echo "Looking for $ext files"
    # Look for rom files based on file extension
    file=$(find $SOURCE -maxdepth 1 -type f -name "*.$ext")

    if [ $file ]
    then
        destination=$DESTINATION_ROOT${rompaths[$i]}/

        # check if destination exists and create if we need to
        [ ! -d "$destination" ] && mkdir -p "$destination"

        echo "Copying $file to $destination"
        cp $file $destination
        echo -e "\e[92mComplete\e[0m"
        exit 0
    fi
done

echo "Didn't find anything in $SOURCE"
exit 1