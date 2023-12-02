# Advent of Code 2023 day 2 part 2 in awk
## Author: Chris Menard

BEGIN {
    FS = "[;:]"
}

/[[:alnum:]]/ {
    gsub("Game ","",$1)
    rmax = 0
    gmax = 0
    bmax = 0
    
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
	if (red > rmax)
	    rmax = red
	if (green > gmax)
	    gmax = green
	if (blue > bmax)
	    bmax = blue
    }
    tot += rmax*gmax*bmax
}

END {
    print tot
}



