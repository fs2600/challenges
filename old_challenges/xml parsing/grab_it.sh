#!/bin/sh

#this program downloads an rss or xml file and downloads the newest file 
#sort of like itunes grabs your podcasts
#Works best with packetstorm newsfeed's format
#but does technically work with any xml feed
 
#referenced code on their site 
#http://packetstormsecurity.org/backend/downloadnewpss.sh.txt

#shyft 2008
#ft smith 2600

FEED="$1"

if ["$FEED" eq ""];
then
	FEED="http://packetstormsecurity.org/whatsnew20.xml"
	echo "no feed specified grabbing packetstorm news feed\n\n\n"
fi	

mkdir ./downloads

curl -s $FEED |grep -o http://*.* | awk '{ gsub( "<\/link>" , "") ; print }' |wget -P ./downloads -i -
