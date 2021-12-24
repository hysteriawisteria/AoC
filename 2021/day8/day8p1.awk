# Advent of Code 2021, day 8 part 1
## Author: Chris Menard

BEGIN {FS ="|"
    total=0
}

/([a-g]+ )+|([a-g]+ ?)+/ {
    split($2,input," ")


    for (i in input) {
	len=length(input[i])
	
	if (len == 2 || # number 1
	    len == 3 || # number 7
	    len == 4 || # number 4
	    len == 7)   # number 8
	    total++
    }
}

END {
    print total
}
