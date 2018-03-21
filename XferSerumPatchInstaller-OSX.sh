#!/usr/bin/env bash
set -e

#################################################################################################
# XferSerumPatchInstaller-OSX @ https://github.com/essobi/XferSerumPatchInstaller-OSX by Essobi #
#################################################################################################

### Will copy all *.fxp *.wav and *.shp in the subdirectories from where it is executed.
### Example:  Backup your user patches with something like...
### cp -Rp /Library/Audio/Presets/Xfer\ Records/Serum\ Presets/*/User/ /Volumes/BackupDisk/SerumUser/

### If you need to recover the user patches...
### cd /Volumes/BackupDisk/SerumUser
### ./XferSerumPatchInstaller-OSX.sh
### And wait...

## If anyone actually bothers to use this, I'll maintain it/update it as long as it remains flexible enough for my use cases.
## Open an issue if you have a problem, but don't expect quick turn-around.  It's free.
## Otherwise hack away.
## I needed a way to take a broken OSX system disk or a backup and transfer all the old Serum user presets from it to my new OSX disk.


## Backup your /Library/Audio/Presets/Xfer\ Records/Serum\ Presets/${dirn}/User path so you don't muck up already installed presets.
## I opted to copy the local dir, instead of mv the file.
## Make sure local names don't collide, or you're ok with the same folders being merged.  I don't check for mkdir errors, but only mkdir if file count > 0

function CopyFiles() {
    fX=$1
    t=$2
    dirn=$3
    if [ ${fX} -gt 0 ] ; then
	echo "Found.. ${fX} ${t}"
	mkdir -p "/Library/Audio/Presets/Xfer Records/Serum Presets/${dirn}/User/${C}" || ( echo "Failed to mkdir for ${dirn} for ${C}" && exit 255 )
	find . -type f -name \*.${t} -print0 | xargs -0 -n1 -I % cp '%' "/Library/Audio/Presets/Xfer Records/Serum Presets/${dirn}/User/${C}" \
	    || ( echo "Failed to copy something in ${PWD} for ${t}" && exit 255 ) 
    fi
}


### Expects you to be in the top directory with a struct of ./PRESETNAMETHATISQUOTESAFE/ANYNUMBERofFOLDERSAndSUBFOLDER/filesThatGetCopied[*.wav|*.fxp|*.shp]
### Looking for a dir struct of ./PRESETFOLDERNAME/*.fxp *.wav or *.shp for presets/wavtables/lfoshapes respectively.
## build dir list with first line removed since it's . Expects it to be quotable.
## I didn't make this path safe.  If there's a space, period or otherwise a string that needs quotes, it needs changed.

DIRLIST=$(find . -maxdepth 1 -type d | sed '1d'  )

## For each dir cd to it.. Find *.fxp/wav/shp and move to /Library/Audio/Presets/Xfer Records/[Presets/${XXXX}/LFO Shapes/User/${X}/
for X in ${DIRLIST} ; do
    C=$(echo ${X} | cut -c 3-99)
    cd ${X} || ( echo "Failed in ${PWD}." && exit 254 )
    ff=$(find . -type f -name "*.fxp" | sed '1d' | wc -l)
    fw=$(find . -type f -name "*.wav" | sed '1d' | wc -l)
    fs=$(find . -type f -name "*.shp" | sed '1d' | wc -l)
    CopyFiles ${ff} fxp "Presets" || ( echo "Failed in ${PWD}." && exit 254 )
    CopyFiles ${fw} wav "Tables" || ( echo "Failed in ${PWD}." && exit 254 )
    CopyFiles ${fs} shp "LFO Shapes" || ( echo "Failed in ${PWD}." && exit 254 )
    cd ..
done

du -chs /Library/Audio/Presets/Xfer\ Records/Serum\ Presets/*/User ./

