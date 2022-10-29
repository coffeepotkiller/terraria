#!/bin/bash

#capture day for new backup folder
TODAY=`date '+%Y%m%d'`

#save world and wait 5 seconds to ensure it finishes
/usr/local/bin/terrariad save
sleep 5

#backup world files to new date folder on gdrive
rclone copy /home/fox/.local/share/Terraria/Worlds/ "gdrive:/terraria/$TODAY/"

