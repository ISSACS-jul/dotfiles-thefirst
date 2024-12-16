#!/bin/bash
# 2019-04-08 - Cursor source conversion script
# Exports all of the SVG cursor files to a PNG of the specified size

#SIZE=${SIZE:-72}
CWD=$(pwd)


timetotal=0
FILECOUNT=0

function svgtopng() {
    SIZE=$1
    if [ ! -d "$CWD/$SIZE" ]; then
        mkdir -p $CWD/$SIZE || exit
    fi
    for s in *.svg; do 
        starttime=$(date +%s.%N)
        # Convert the path to a PNG file with inkscape, 
		# resulting in a file named xport
        inkscape -z -export $s -w $SIZE > /dev/null 2>&1
        # Move the new file to the correct size directory.  
		# The '%.svg' does a substring 
        # removal on the filename string of the current SVG file.
        if [ $? -eq 0 ]; then
            optipng -silent -o7 xport
            mv xport $CWD/$SIZE/${s%.svg}.png
            endtime=$(date +%s.%N)
            totaltime=$(bc <<< "($endtime-$starttime)%86400")
            printf "Exported %s to %s/%s.png in %0.2f seconds\n" $s $SIZE ${s%.svg} $totaltime
            lasttime=$(bc <<< "$totaltime + $timetotal")
            timetotal=$lasttime
            (( FILECOUNT+= 1 ))
        else
            echo -e "\nError exporting $s"
        fi
    done
}


for size in 48 64 72 96; do
	svgtopng $size
    t=$(bc <<< "($timetotal)%86400")
    printf "%d files processed in %0.2f seconds\n\n" $FILECOUNT $t
done

t=$(bc <<< "($timetotal)%86400")
printf "%d files processed in %0.2f seconds\n\n" $FILECOUNT $t

exit 0
