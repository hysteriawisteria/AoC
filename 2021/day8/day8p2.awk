# Advent of Code 2021, day 8 part 1
## Author: Chris Menard

function gen_regex(entry) { # Generate a RegEx from entry that will match other strings containing the characters in the entry
    patlen = length(entry)

    # create inpat of form 'c1|c2|c3|...' where c1,c2,c3... are the characters in entry
    inpat=sprintf("%c", substr(entry,1,1))

    for (u=2; u<=patlen; u++) {
	inpat=sprintf("%s|%c", inpat, substr(entry,u,1))
    }

    return sprintf("((%s)[a-g]*){%d}(%s)", inpat, patlen-1, inpat)
}

function regex(entry) { # Generate a regex that will match the exact same length string with the same characters
    patlen = length(entry)

    inpat=sprintf("%c", substr(entry,1,1))

    for (u=2; u<=patlen; u++) {
	inpat=sprintf("%s|%c", inpat, substr(entry,u,1))
    }

    return sprintf("^(%s){%d}$", inpat, patlen)
}

function get_num(pat_arr, entry) { # Lookup number from entry using match regex in pat_arr
    for (i in pat_arr) {
	if (entry ~ i)
	    return pat_arr[i]
    }
}

BEGIN {FS ="|"
    total=0
}

/([a-g]+ )+|([a-g]+ ?)+/ {
    split($1,analysis," ")
    split($2,input," ")

    
    ## First process the analysis array
    # Find patterns for 1,4,7,8
    for (i in analysis) {
	entry=analysis[i]
	len=length(entry)
	
	if (len == 2) { # Number is a 1
	    pat_arr[regex(entry)] = 1

	    #Generate RegEx for '1' - will be used to decode 3 and then 0
	    pat1 = gen_regex(entry)
	    
	    delete analysis[i]
	}
	else if (len == 3) { # Number is a 7
	    pat_arr[regex(entry)] = 7
	    
	    delete analysis[i]
	}
	else if (len == 4) { # Number is a 4
	    pat_arr[regex(entry)] = 4
	    
	    delete analysis[i]
	}
	else if (len == 7) { # Number is an 8
	    pat_arr[regex(entry)] = 8

	    delete analysis[i]
	}
    }

    # Find pattern for 3, this will be the only 5-length pattern containing a 1
    for (i in analysis) {
	entry=analysis[i]
	len=length(entry)

	if (len == 5 && entry ~ pat1) {
	    pat_arr[regex(entry)] = 3

	    #Generate RegEx for '3' - will be used to decode 9
	    pat3 = gen_regex(entry)

	    delete analysis[i]
	}
			    
    }

    # Find patterns for 0,6,9
    for (i in analysis) {
	entry = analysis[i]
	len=length(entry)

	# Find pattern for 9, this will be the only 6-length pattern containing 3
	if (len == 6 && entry ~ pat3) {
	    pat_arr[regex(entry)] = 9

	    delete analysis[i]
	}
	else if (len == 6 && entry ~ pat1) { # Number is 0
	    pat_arr[regex(entry)] = 0

	    delete analysis[i]
	}
	else if (len == 6) { # Number is 6
	    pat_arr[regex(entry)] = 6

	    #Also save 6's pattern:
	    six = entry

	    delete analysis[i]
	}
    }

    # Find patterns for 2 and 5; 5 will be in 6, but 2 won't
    # There should be only these two numbers left, but we'll continue the same length checks as before
    for (i in analysis) {
	entry = analysis[i]
	len = length(entry)

	patx = gen_regex(entry)

	if (len == 5 && six ~ patx) { # Number is 5
	    pat_arr[regex(entry)] = 5
	}
	else if (len == 5) {
	    pat_arr[regex(entry)] = 2
	}
    }

    # Now use the result of the analysis to find the 4 digits in $2 and add them to total

    # Use pat_arr to lookup the values for the input from $2
    num = 1000*get_num(pat_arr,input[1]) + 100*get_num(pat_arr,input[2]) + 10*get_num(pat_arr,input[3]) + get_num(pat_arr,input[4])
    total+=num

    # Clean-up
    delete analysis
    delete pat_arr

}

END {
    print total
}

