#! /bin/csh -f

set i = 2
set j = 0

pdfjam "1.pdf" "2.pdf" --fitpaper 'false' --rotateoversize 'false' --suffix joined

while ( $i < 27 )

    @ j = ( $i + 1 )

    pdfjam "$i-joined.pdf" "$j.pdf" --fitpaper 'false' --rotateoversize 'false' --suffix joined

    rm -f "$i-joined.pdf"

    @ i++

end

