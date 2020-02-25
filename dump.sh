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

SOURCE=/Volumes/Retrode
DESTINATION_ROOT=~/stuff/temp/

declare -A rominfo
rominfo=( [sfc]=snes [bin]=gen [gb]=gameboy [gba]=gba [sms]=sms [gg]=gamegear )

for i in "${!rominfo[@]}";
do
    :
    echo "Looking for $i files"
    # Look for rom files based on file extension
    file=$(find $SOURCE -maxdepth 1 -type f -name "*.$i")

    if [ $file ]
    then
        destination=$DESTINATION_ROOT${rominfo[$i]}/

        [ ! -d "$destination" ] && mkdir -p "$destination"

        echo "Copying $file to $destination"
        cp $file $destination
        echo -e "\e[92mComplete\e[0m"
        exit 0
    fi
done

echo "Didn't find anything in $SOURCE"
exit 1