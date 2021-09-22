#!/bin/bash

"%F"=$1

"%L"=$2


if [["$2" == 'eBook-tmp' ]]; then

cp -al "$1" "/mnt/tank-0/BOOK-COLLECTION/Calibre-import"

elif [["$2" == 'lightnovel']]; then

cp -al "$1" "/mnt/tank-0/BOOK-COLLECTION/Library-import"

fi
