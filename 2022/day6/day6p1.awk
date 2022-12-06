# Advent of Code 2022 day 6 part 1 in awk
## Author: Chris Menard

function uniq() {
    if (char[0] == char[1] || char[0] == char[2] || char[0] == char[3] ||
	char[1] == char[2] || char[1] == char[3] ||
	char[2] == char[3])
	return 0
    else
	return 1
}
	

$0 ~ /[a-z]+/ {
    for (i=1; i<=length($0); i++) {
	char[i%4] = substr($0,i,1)

	if (i >= 4 && uniq()) {
	    print i
	    break
	}
    }
}
	    
	    
	

	
