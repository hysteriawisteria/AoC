# Advent of Code 2023 day 15 part 2 in awk
## Author: Chris Menard

BEGIN {
    for (i=7; i<128; i++) {
	_ord_[sprintf("%c",i)] = i
    }
}

function ascii(c) {
    return _ord_[c]
}

function makehash(str,     i,     hash) {
    hash = 0

    for (i=1; i<=length(str); i++) {
	hash = ((hash + ascii(substr(str,i,1))) * 17) % 256
    }

    return hash
}

/[\x00-\x7F]+/ {
    split($1,input,",")

    for (i=1; i<=length(input); i++) {

	label = substr(input[i],1,match(input[i],/[-=]/)-1)
	h = makehash(label)

	if (input[i] ~ /[a-z]+=[1-9]/) {
	    if (boxes[h] ~ label) {
		# replace just the number for the label
		boxes[h] = substr(boxes[h],1,index(boxes[h],label)+length(label)-1) substr(input[i],length(input[i]),1) substr(boxes[h],index(boxes[h],label)+length(label)+1)
	    } else {
		boxes[h] = boxes[h] "," label substr(input[i],length(input[i]),1)
	    }
	    
	} else if (input[i] ~ /[a-z]+-/) {
	    # completely remove label + number
	    if (boxes[h] ~ label) {
		boxes[h] = substr(boxes[h],1,index(boxes[h],label)-2) substr(boxes[h],index(boxes[h],label)+length(label)+1)
	    }
	    
	} else {
	    print "ERROR: doesn't match"
        }
    }
}
    

END {
    for (i=0; i<=255; i++) {
	split(boxes[i],lenses,",")

	for (j=2; j<=length(lenses); j++) {
	    tot += (i+1) * (j-1) * substr(lenses[j],length(lenses[j]),1)
	}
    }

    print tot
}



