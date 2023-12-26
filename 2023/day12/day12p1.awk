# Advent of Code 2023 day 12 part 1 in awk
## Author: Chris Menard

function recur(pattern, seq, pos, prevchar, group, len) {

    char = substr(pattern,pos,1)
    split(seq,groups,",")

    if (pos > length(pattern) && group == length(groups) && len == groups[group]) {
	return 1
    } else if (pos > length(pattern)) {
	return 0
    }
    
    if (prevchar == ".") {
	if (char == "#") {
	    if (group >= length(groups)) {
		return 0
	    } else {
		return recur(pattern, seq, pos+1, char, group+1, 1)
	    }
	    
	} else if (char == ".") {
	    return recur(pattern, seq, pos+1, char, group, len)
	    
	} else if (char == "?") {
	    if (group >= length(groups)) {
		return recur(pattern, seq, pos+1, ".", group, len)
	    } else {
		return recur(pattern, seq, pos+1, ".", group, len) + recur(pattern, seq, pos+1, "#", group+1, 1)
	    }
	}
	
    } else if (prevchar == "#") {
	if (char == "#") {
	    if (len == groups[group]) {
		return 0
	    } else {
		return recur(pattern, seq, pos+1, char, group, len+1)
	    }
	} else if (char == ".") {
	    if (len == groups[group]) {
		return recur(pattern, seq, pos+1, char, group, len)
	    } else {
		return 0
	    }
	} else if (char == "?") {
	    if (len == groups[group]) {
		return recur(pattern, seq, pos+1, ".", group, len)
	    } else if (len < groups[group]) {
		return recur(pattern, seq, pos+1, "#", group, len+1)
	    }
	}
    }
}

/[.#?]+/ {
    count = recur($1, $2, 1, ".", 0, 0)
    tot += count
}

END {
    print tot
}
