# Advent of Code 2022 day 3 part 1 in awk
## Author: Chris Menard

BEGIN {
    priorities="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
}
$0 ~ /[a-zA-Z]+/ {
    line[NR%3]=$0

    if (NR%3 == 0) {

	match1=""
	for (i=1; i<=length(line[0]); i++) {
	    if (match(line[1],substr(line[0],i,1)) > 0)
		match1 = match1 substr(line[0],i,1)
	}

	for (i=1; i<=length(match1); i++) {
	    if (match(line[2],substr(match1,i,1) ) > 0) {
		ans += index(priorities,substr(match1,i,1))
		break
	    }
	}
    }
}

END {
    print ans
}
