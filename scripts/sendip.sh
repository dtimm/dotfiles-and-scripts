#!/bin/bash
nowip=$(curl -s http://ipecho.net/plain | grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
if [ -z "$nowip" ]
then
	exit
fi
lastip=$(cat /home/pi/scripts/currentip.txt)
if [ "$lastip" != "$nowip" ]
then
	echo "$nowip" > /home/pi/scripts/currentip.txt
	mutt -s "ip changed" timmmeister@gmail.com < /home/pi/scripts/currentip.txt
	echo "ip updated"
fi


