# Advent of Code 2023 day 6 part 1 in awk
## Author: Chris Menard

BEGIN {tot=1}

/Time/ {
    for (i=2; i<=NF; i++) {
	time[i] = $i
    }
}

/Distance/ {
    for (i=2; i<=NF; i++) {
	tot *= (int((time[i] + sqrt(time[i]^2-4*($i+.1)))/2) - int((time[i] - sqrt(time[i]^2-4*($i+.1)))/2))
    }
}

END {
    print tot
}

    
    
	
