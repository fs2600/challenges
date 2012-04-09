#!/bin/sh
#download all mp3s from an Ivy League Spins page. 
#09APR12
#shyft
URL=$1;
DATE=`date +%d%b%y`;
#2mkdir $DATE;
#cd $DATE;
for file in $(curl -s $URL |grep soundFile |for url in $(awk -F "soundFile:\"" {'print $2;print "\n"'}|sed s/\"\}\)\;//g); do echo $url|base64 -d 2>/dev/null; echo ""; done);
do
    wget -P $DATE $file;
done
