# Advent of Code 2023 day 6 part 1 in awk
## Author: Chris Menard

BEGIN {tot=1}

/Time/ {
    for (i=2; i<=NF; i++) {
	time = time $i
    }
}

/Distance/ {
    for (i=2; i<=NF; i++) {
	dist = dist $i

    }
}

END {
    print int((time + sqrt(time^2-4*(dist+.1)))/2) - int((time - sqrt(time^2-4*(dist+.1)))/2)
}

    
    
	
