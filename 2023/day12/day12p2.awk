# Advent of Code 2023 day 12 part 1 in awk
## Author: Chris Menard

## Credit to clrfl on github for the idea behind the NFA algorithm
##     https://github.com/clrfl

function print_arr(arr,      idx) {
    for (idx in arr) {
	printf "(%s: %s)", idx, arr[idx]
    }
    print ""
    print ""
}

# traverse the pattern via the NFA
function traverse(pattern, seq,     nfa,     groups,     states,     i,     j,     pos,     state,     new_states) {
    nfa[1] = "."

    state = 2
    split(seq,groups,",")
    for (i=1; i<=length(groups); i++) {
	for (j=1; j<= groups[i]; j++) {
	    nfa[state] = "#"
	    state++
	}
	nfa[state] = "."
	state++
    }

    states[1] = 1

    for (pos=1; pos<=length(pattern); pos++) {

	char = substr(pattern,pos,1)

	for (state in states) {

	    if (char == ".") {
		if (state+1 <= length(nfa) && nfa[state+1] == ".") {
		    new_states[state+1] = new_states[state+1] + states[state]
		}
		if (nfa[state] == ".") {
		    new_states[state] = states[state] + new_states[state]
		}
	    
	    } else if (char == "#") {
		if (state+1 <= length(nfa) && nfa[state+1] == "#") {
		    new_states[state+1] = new_states[state+1] + states[state]
		}
	    
	    } else if (char == "?") {
		if (state+1 <= length(nfa)) {
		    new_states[state+1] = new_states[state+1] + states[state]
		}
		if (nfa[state] == ".") {
		    new_states[state] = states[state] + new_states[state]
		}
	    } else {
		print "ERROR: Impossible character"
	    }
	}

	delete states
	for (state in new_states) {
	    states[state] = new_states[state]
	}
	delete new_states
    }

    return states[length(nfa)] + states[length(nfa)-1]
}
	


/[.#?]+/ {
    pattern = $1 "?" $1 "?" $1 "?" $1 "?" $1
    seq = $2 "," $2 "," $2 "," $2 "," $2

    tot += traverse(pattern,seq)
}

END {
    print tot
}
