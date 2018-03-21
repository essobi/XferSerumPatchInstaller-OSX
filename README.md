# XferSerumPatchInstaller-OSX

For OSX:  Will traverse a directory with sub-directories looking for fxp, wav, shp files and copy them into an existing Xfer Records Serum install.

## HOWTO
Will copy all *.fxp *.wav and *.shp in the subdirectories from where it is executed.                       
Example:  Backup your user patches with something like...
```
cp -Rp /Library/Audio/Presets/Xfer\ Records/Serum\ Presets/*/User/ /Volumes/BackupDisk/SerumUser/          
```
If you need to recover the user patches...                                                                 
```
cd /Volumes/BackupDisk/SerumUser                                                                           
./XferSerumPatchInstaller-OSX.sh                                                                           
```

And wait... It's going to be a while if you're using USB disks on /Volumes/BackupDisk.                                                                                                

## Open an issue if you have a problem, or submit a PR if you want to help.

