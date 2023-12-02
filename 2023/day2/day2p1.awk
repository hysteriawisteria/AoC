# Advent of Code 2023 day 2 part 1 in awk
## Author: Chris Menard

BEGIN {
    FS = "[;:]"
}

/[[:alnum:]]/ {
    possible = 1
    gsub("Game ","",$1)
    
    for (i=2; i<=NF; i++) {
	red = 0
	green = 0
	blue = 0
	
	if (match($i,/[0-9]+ red/)) {
	    red += substr($i,RSTART,RLENGTH - 4)
	}
	if (match($i,/[0-9]+ green/)) {
	    green += substr($i,RSTART,RLENGTH - 6)
	}
	if (match($i,/[0-9]+ blue/)) {
	    blue += substr($i,RSTART,RLENGTH - 5)
	}

	if (red > 12 || green > 13 || blue > 14) {
            possible = 0
	    break
	}
    }
    if (possible)
	tot+=$1
}

END {
    print tot
}



