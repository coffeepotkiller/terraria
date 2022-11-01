#!/bin/bash

#make sure we're home
cd /home/fox/

#initial variables
LATEST_ZIP=`curl -s https://terraria.fandom.com/wiki/Server | grep -Po "https?://[^\s'\"]+" | grep pc-dedicated-server | tail -1`
VERSION=`echo $LATEST_ZIP | grep -Po "[0-9]+"`
ZIP_DOWNLOAD=/home/fox/new-terraria.zip
CURRENT=/home/fox/terraria-current
PREVIOUS=/home/fox/terraria-previous
CURRENT_VERSION=`cat terraria-current/changelog.txt | head -1 |  grep -Po "[0-9]" | tr -d '\n'`


#Display version that will be installed and wait for user confirmation to proceed
echo Current Version Detected = $CURRENT_VERSION
echo
echo New Version = $VERSION
echo New URL = $LATEST_ZIP
read -p "Do you want to proceed with update? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi


#stop the server
sudo systemctl stop terraria.service

#backup+clean old files and download new release
rm -rf $PREVIOUS/*
cp -r $CURRENT/* $PREVIOUS/
rm $ZIP_DOWNLOAD
rm -rf $CURRENT/*
wget $LATEST_ZIP -O $ZIP_DOWNLOAD

#copy new release to server directory
unzip -o $ZIP_DOWNLOAD
cp -r $VERSION/Linux/* $CURRENT/
chmod +x $CURRENT/TerrariaServer.bin.x86_64

#start server back up
sudo systemctl start terraria.service

#cleanup
rm -rf $VERSION
