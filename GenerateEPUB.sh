#!/bin/bash
echo This batch script will generate a new folder \(\!\);
echo that will only contain the EPUB files available;
echo in the collection \(Yaoi ignored\).;
echo The files generated are hardlinks which means;
echo you can delete the files in the original location;
echo and keep only this new folder and you\'ll keep only;
echo the EPUB files and nothing else.;
echo Hardlinks do not actually take the space they say;
echo they do so don\'t worry about generating this even;
echo if you plan to keep everything in the original place.;
echo .;
echo .;
echo .;
echo Deleting processment files if present.;
mkdir \! || true;
EPUB=$(pwd);
cd ..;
BASE=$(pwd);
cd "$EPUB";
rm files.txt || true;
rm files_.txt || true;
rm paths.txt || true;
rm paths_.txt || true;
echo .;
echo .;
echo Analyzing main folder \(slow process on updates\).;
echo .;
echo .;
echo .;
find "$BASE" -name "*.epub" ! -path "*/\!*/*" | while read line; do
	echo "Processing file '$line'";
	name=$(basename "$line");
	newdirname=$(basename "$(dirname "$line")");
	dname="${EPUB}/!/${newdirname}";
	mkdir "$dname" || true;
	ln "$line" "${dname}/${name}"
done 
echo .
