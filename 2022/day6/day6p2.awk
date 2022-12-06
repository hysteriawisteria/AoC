# Advent of Code 2022 day 6 part 1 in awk
## Author: Chris Menard

function uniq() {
    for (i=0; i<length(char)-1; i++) {
	for (j=(i+1); j<length(char); j++) {
	    if (char[i] == char[j])
		return 0
	}
    }
    return 1
}
	

$0 ~ /[a-z]+/ {
    for (pos=1; pos<=length($0); pos++) {
	char[pos%14] = substr($0,pos,1)

	if (pos >= 14 && uniq()) {
	    print pos
	    break
	}
    }
}
	    
	    
	

	
