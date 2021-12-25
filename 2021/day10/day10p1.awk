# Advent of Code 2021, day 10 part 1
## Author: Chris Menard

BEGIN {
    total = 0
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
	} else if (char == ")") {
	    
	    if (lvlpos[level] == "(") {
		delete lvlpos[level]
		level--
	    } else {
		total += 3
		next
	    }
	} else if (char == "]") {
		    
	    if (lvlpos[level] == "[") {
		delete lvlpos[level]
		level--
	    } else {
		total += 57
		next
	    }
	} else if (char == "}") {

	    if (lvlpos[level] == "{") {
		delete lvlpos[level]
		level--
	    } else {
		total += 1197
		next
	    }
	} else {

	    if (lvlpos[level] == "<") {
		delete lvlpos[level]
		level--
	    } else {
		total += 25137
		next
	    }
	}
    }
}

END { print total }
