#!/bin/bash
#Author: Andrej Mernik, 2008, http://andrej.mernik.eu/clanki/linux/utcachemanager/
#License: GPLv3

#Unreal Tournament install directory
UTdir="/home/user/games/ut"
#Unreal Tournament cache directory
CacheDir="/home/user/.loki/ut/Cache"


#keep reading from the cache.ini until the end
while read inputline
do
#split the line to two pieces
CODE=${inputline%=*}
TMPREALNAME=${inputline#*=}
#remove the carriage return
REALNAME=`echo -e $TMPREALNAME | sed 's/\r//g' `

#get the extension
EXTENSION=${REALNAME#*.}

if [ $EXTENSION ]
then
	#Unreal music file
        if [ "$EXTENSION" == 'umx' ]; then mv "$CacheDir/$CODE.uxx" "$UTdir/Music/$REALNAME"
	#unreal audio file
        elif [ "$EXTENSION" == 'uax' ]; then mv "$CacheDir/$CODE.uxx" "$UTdir/Sounds/$REALNAME"
	#Unreal system file 
        elif [ "$EXTENSION" == 'int' ]; then mv "$CacheDir/$CODE.uxx" "$UTdir/System/$REALNAME"
	#Unreal system file 
        elif [ "$EXTENSION" == 'u' ]; then mv "$CacheDir/$CODE.uxx" "$UTdir/System/$REALNAME"
	#Unreal texture file
        elif [ "$EXTENSION" == 'utx' ]; then mv "$CacheDir/$CODE.uxx" "$UTdir/Textures/$REALNAME"
        #unreal map file
	elif [ "$EXTENSION" == 'unr' ]; then mv "$CacheDir/$CODE.uxx" "$UTdir/Maps/$REALNAME"
	#else skip them
        else echo "Skipping ..."
	echo $inputline >> "tmpcache.ini"
        fi
fi
done < $CacheDir/cache.ini
mv "tmpcache.ini" "$CacheDir/cache.ini"
