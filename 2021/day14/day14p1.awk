# Advent of Code 2021, day 13 part 2
## Author: Chris Menard

function insert(template,pairs) {

    # Find the positions each pair occurs at and store in pos_arr
    for (pair in pairs) {
	
	elem = pairs[pair]
	pos = 0
	gap = index(template,pair)

	while (gap != 0) {
	    pos += gap
	    pos_arr[pos] = elem
	    gap = index(substr(template,pos+1),pair)
	}
    }

    for (pos=length(template); pos > 0; pos--) {

	template = substr(template,1,pos) pos_arr[pos] substr(template,pos+1)
    }

    delete pos_arr
    return template
}


/^[A-Z]+$/ {
    template = $1
}

/[A-Z]+ -> [A-Z]/ {
    pairs[$1] = $3
}

END {
    for (step=1; step <=10; step++) {

	if (step%5 == 0)
	    print step
	
	template = insert(template,pairs)
    }



    for (char=1; char<=length(template); char++) {
	count[substr(template,char,1)]++
    }

    most = 0
    least = length(template)

    for (i in count) {
	
	if (count[i] < least) {
	    least = count[i]
	}

	if (count[i] > most) {
	    most = count[i]
	}
    }

    print most - least
}
	

