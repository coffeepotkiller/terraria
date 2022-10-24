#!/bin/bash

#initial variables
LATEST_ZIP=`curl -s https://terraria.fandom.com/wiki/Server | grep -Po "https?://[^\s'\"]+" | grep pc-dedicated-server | tail -1`
VERSION=`echo $LATEST_ZIP | grep -Po "[0-9]+"`
ZIP_DOWNLOAD=/home/fox/new-terraria.zip
CURRENT=/home/fox/terraria-current

#Display version that will be installed and wait for user confirmation
echo Version = $VERSION
echo URL = $LATEST_ZIP
read -p "Press any key to continue..."

#stop the server
sudo systemctl stop terraria.service

#delete old files and download new release
cd /home/fox/
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
