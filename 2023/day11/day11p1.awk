# Advent of Code 2023 day 11 part 1 in awk
## Author: Chris Menard

function print_input(     i) {
    for (i=1; i<=length(input); i++) {
	print input[i]
    }
}

function abs(number) {
    return number > 0 ? number : -number
}

# Expands the input, also finds galaxies
function expand(     i,     j,     k,     str,      len,     char,     count) {
    count = 1
    
    len = length(input)
    for (i=1; i<=len; i++) {
	if (input[i] ~ /^\.+$/) {
	    for (j=len+1; j>i+1; j--) {
		input[j] = input[j-1]
	    }
	    input[i+1] = sprintf("%*s",length(input[1]),"")
	    gsub(/ /,".",input[i+1])
	    i++
	    len++
	}
    }
    
    len=length(input[1])
    for (i=1; i<=len; i++) {
	str = ""
	
	for (j=1; j<=length(input); j++) {

	    char = substr(input[j],i,1)
	    if (char == "#") {
		gals[count] = i "," j
		count++
	    }
		
	    str = str substr(input[j],i,1)

	}
	if (str ~ /^\.+$/) {
	    for (k=1; k<=length(input); k++) {
		input[k] = substr(input[k],1,i) "." substr(input[k],i+1)
	    }
	    i++
	    len++
	}
    }
}

	


/[.]/ {
    input[NR] = $1
}

END {
    expand()

    for (i=1; i<=length(gals)-1; i++) {
	for (j=i+1; j<=length(gals); j++) {
	    split(gals[i],first,",")
	    split(gals[j],second,",")

	    dist = abs(second[2] - first[2]) + abs(second[1] - first[1])
	    tot += dist

	}
    }

    print tot
}
