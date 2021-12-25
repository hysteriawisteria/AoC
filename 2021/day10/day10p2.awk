# Advent of Code 2021, day 10 part 2
## Author: Chris Menard

function opposite(char) {
    
    if (char == "<")
	return ">"
    if (char == ">")
	return "<"
    if (char == "{")
	return "}"
    if (char == "}")
	return "{"
    if (char == "[")
	return "]"
    if (char == "]")
	return "["
    if (char == "(")
	return ")"
    if (char == ")")
	return "("
}

/[[{}()<>\]]+/ {
    level=0
    delete lvlpos
    
    for (i=1; i<=length($1); i++) {
	char = substr($1,i,1)

	if (char == "[" ||
	    char == "<" ||
	    char == "(" ||
	    char == "{") {

	    level++
	    lvlpos[level] = char
	} else if (lvlpos[level] == opposite(char)) {
	    
	    delete lvlpos[level]
	    level--
	} else { # Corrupted line
	    next
	}

    }

    # At this point, we've moved to the next record if the line is corrupt, so we know it is incomplete
    # lvlpos will have the opposite characters needed to complete the record
    for (i=length(lvlpos); i>=1; i--) {
	char = lvlpos[i]

	if (char == "(")
	    val = 1
	else if (char == "[")
	    val = 2
	else if (char == "{")
	    val = 3
	else if (char == "<")
	    val = 4

	total[NR] = 5*total[NR] + val
    }

}

END {
    asort(total)
    print total[(length(total)+1)/2]
}
