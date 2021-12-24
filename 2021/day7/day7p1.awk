# Advent of Code 2021, day 7 part 1
## Author: Chris Menard

function abs(value) {
    return value > 0 ? value : -value
}

BEGIN {RS="[,\n]"}

/[0-9]+/ {input[NR]=+$0}

END {
    # Find min and max
    asort(input)
    min=input[1]
    len=length(input)
    max=input[len]

    print min,max,len

    # Find candidate value that minimizes fuel consumed
    mintotval=0
    mintot=0
    for (candidate=min; candidate<=max; candidate++) {
	total=0
	for (i=1; i<=len; i++) {
	    total+=abs(candidate - input[i])
	}
	
	mintot == 0 ? mintot = total : mintot=mintot # Correct initialization for mintot on first iteration
	if (total < mintot) {

	    mintot = total
	    mintotval=candidate
	}
    }
    print mintotval,mintot
}

