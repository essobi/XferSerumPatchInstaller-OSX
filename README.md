# XferSerumPatchInstaller-OSX

For OSX:  Will traverse a directory with sub-directories looking for fxp, wav, shp files and copy them into an existing Xfer Records Serum install.

## HOWTO
Will copy all *.fxp *.wav and *.shp in the subdirectories from where it is executed.                       
Example:  Backup your user patches with something like...
```
cp -Rp "/Library/Audio/Presets/Xfer Records/Serum Presets/Presets/User/" /Volumes/Storage/Presets/

```
If you need to recover the user patches (the script expects to be in the directory of the backups).
```
cd /Volumes/Storage/Presets/
./XferSerumPatchInstaller-OSX.sh
```
And wait... It's going to be a while if you're using USB disks on /Volumes/BackupDisk. 
PSA: you can hit ctrl-t on OSX to see what the status is during most commands, including copy.

## Open an issue if you have a problem, or branch and submit a PR.


