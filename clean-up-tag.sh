#!/bin/bash

"%F"=$1

"%G"=$2


if [[ ",$2," = *",AUDIOBOOK,"* ]]; then

cp -r "$1" "/book/audio-import"

elif [[ ",$2," = *",BOOK,"* ]]; then

cp -al "$1" "/book/Calibre-import"

elif [[ ",$2," = *",LIGHTNOVEL,"* ]]; then

cp -al "$1" "/book/Library-import"

fi
