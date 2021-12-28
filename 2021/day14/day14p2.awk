# Advent of Code 2021, day 14 part 2
## Author: Chris Menard

function insert(template,pairs) {

    for (pair in template) {
	new1 = substr(pair,1,1) pairs[pair]
	new2 = pairs[pair] substr(pair,2,1)

	new_template[new1] += template[pair]
	new_template[new2] += template[pair]
    }

    delete template
    for (pair in new_template) {
	template[pair] = new_template[pair]
    }

    delete new_template
}

/^[A-Z]+$/ {

    first = substr($1,1,1)
    last = substr($1,length($1),1)

    for (pos=1; pos<length($1); pos++) {
	template[substr($1,pos,2)]++
    }
}

/[A-Z]+ -> [A-Z]/ {
    pairs[$1] = $3
}

END {
    for (step=1; step <=40; step++) {

	insert(template,pairs)
    }

    count[first]++
    count[last]++
    for (pair in template) {
	count[substr(pair,1,1)] += template[pair]
	count[substr(pair,2,1)] += template[pair]
    }

    most=0
    least=count[first]
    for (elem in count) {
	
	if (count[elem] > most)
	    most = count[elem]
	if (count[elem] < least)
	    least = count[elem]
    }

    print (most/2) - (least/2)
}
	

