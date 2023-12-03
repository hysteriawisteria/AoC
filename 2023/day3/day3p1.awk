# Advent of Code 2023 day 3 part 1 in awk
## Author: Chris Menard

# Return true if the number of length 'len' starting at 'val' on row 'i' is a engine part
function part(i,val,len) {
    regex = "[^0-9.]"

    # check left side
    if (substr(input[i],val-1,1) ~ regex)
	return 1

    # check right side
    if (substr(input[i],val+len,1) ~ regex)
	return 1

    # check top and bottom
    for (pos=val-1; pos<=val+len; pos++) {
	if (substr(input[i-1],pos,1) ~ regex ||
	    substr(input[i+1],pos,1) ~regex)
	    return 1
    }
    return 0
}

/[0-9.]+/ {
    input[NR] = "." $1 "."
}

END {
    # pad top and bottom of array
    bot = length(input) + 1
    input[bot] = sprintf("%*s",length(input[1]),"")
    gsub(/ /,".",input[bot])

    input[0] = sprintf("%*s",length(input[1]),"")
    gsub(/ /,".",input[0])

    for (i=1; i<=bot-1; i++) {

	val = match(input[i],/[0-9]+/)
	while (val != 0) {
	    num = substr(input[i],val,RLENGTH)

	    if (part(i,val,RLENGTH)) {
		tot += num
	    }

	    gsub(/0-9/,".",num)
	    input[i] = sprintf("%s%*s%s",substr(input[i],1,val-1),length(num),"",substr(input[i],val+RLENGTH))
	    gsub(/ /,".",input[i])
	    val = match(input[i],/[0-9]+/)
	}
    }

    print tot
}



