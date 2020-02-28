#!/usr/local/bin/bash
set -e
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
# e.g If your DESTINATION_ROOT is Games and PATH_SNES is snes,
# *.sfc files will be copied to Games/snes
PATH_SNES=snes
PATH_MD=megadrive # Mega Drive/Genesis
PATH_GB=gameboy # GB, GBC
PATH_GBA=gba
PATH_SMS=sms # Sega Master System & Game Gear

# Do not modify below
declare -A rompaths
rompaths=( [sfc]=$PATH_SNES [bin]=$PATH_MD [gb]=$PATH_GB [gba]=$PATH_GBA [sms]=$PATH_SMS [gg]=$PATH_SMS )

findFile () {
    find $1 -maxdepth 1 -type f -name *.$2
}

if [ ! -d $SOURCE ]
then
    echo "Unable to find where Retrode is mounted, exiting"
    exit 1
fi

echo -e "Looking for rom files in $SOURCE\n"

for ext in "${!rompaths[@]}";
do
    :
    # Look for rom files based on file extension
    source_file=$(findFile $SOURCE $ext)

    if [ $source_file ]
    then
        echo -e "Found a ${ext} file\n"
        core=${rompaths[$ext]}
        destination="${DESTINATION_ROOT}${rompaths[$ext]}/"

        # check if destination exists and create if we need to
        [ ! -d "$destination" ] && mkdir -p "$destination"

        echo -e "Copying $source_file to $destination\n"
        rsync -avh --progress $source_file $destination
        echo -e "\e[92mCopy complete\e[0m\n"

        if [ $1 = "boot" ]
        then
            echo -e "Setting up boot rom...\n"
            dest_file=$(findFile $destination $ext)
            ln -sfv $dest_file "${destination}boot0.rom"

            echo "Let's rock! Loading ${core} core"
            # load appropriate core
            echo load_core $(find /media/fat -type f -iname ${core}*.rbf) > /dev/MiSTer_cmd
            exit 0
        fi

        echo -e "\nReady to rock! Load your $core core."

        exit 0
    fi

done

echo "Couldn't find any supported rom files in $SOURCE"
exit 1