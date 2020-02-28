## About
This script will look for rom files on your retrode device, and copy them to a target directory.  
If ran with the `boot` option, the script will create a symlink to `boot0.rom` and try to load the appropriate MiSTer core automatically

## Usage
* Download `dump.sh` and ensure it is executable by running the following shell command:
`chmod +x dump.sh`
* Configure user options (desribed below)
* Run the script:  
`./dump.sh` - copy the rom to the specified directory  
`./dump.sh boot` - copy and attempt to boot the rom using an appropriate core


## User Configurable Options
`SOURCE=/Volumes/Retrode` - Path where retrode has mounted  
`DESTINATION_ROOT=/games/` - Root path for roms to get copied to

Subfolders where roms will get copied to e.g /games/snes:  
`PATH_SNES=snes`  
`PATH_MD=megadrive`  
`PATH_GB=gameboy`  
`PATH_GBA=gba`  
`PATH_SMS=sms`  
