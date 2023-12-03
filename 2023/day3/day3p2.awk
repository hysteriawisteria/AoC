# Advent of Code 2023 day 3 part 2 in awk
## Author: Chris Menard

# Return gear ration if '*' at 'val' on row 'i' is a valid gear
function gear(i,val,     j,     k,     ret,     pos,     count) {
    regex = "[0-9]"
    count = 1
    delete num

    # j: vertical, k: horizontal; pos tracks number
    for (j=-1; j<=1; j++) {
	for (k=-1; k<=1; k++) {

	    # search left
	    pos = k
	    while (substr(input[i+j],val+pos,1) ~ regex) {
		num[count] = substr(input[i+j],val+pos,1) num[count]
		pos--
	    }

	    #search right
	    if (k < 1)
		pos=k+1
	    while (substr(input[i+j],val+pos,1) ~ regex) {
		num[count] = num[count] substr(input[i+j],val+pos,1)
		k=pos
		pos++
	    }
	    count++
	}
    }

    if (length(num) == 2) {
	ret = 1
	for (count in num) {
	    ret*=num[count]
	}
    }

    return ret
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

	val = index(input[i],"*")
	while (val != 0) {

	    tot += gear(i,val)
	    input[i] = substr(input[i],1,val-1) "." substr(input[i],val+1)
	    val = index(input[i],"*")
	}
    }

    print tot
}



