# Advent of Code 2022 day 3 part 1 in awk
## Author: Chris Menard

BEGIN {
    priorities="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
}
$0 ~ /[a-zA-Z]+/ {
    part1 = substr($0,1,length($0)/2)
    part2 = substr($0,length($0)/2+1)

    for (i=1; i<=length(part1); i++) {
	if (index(part2,substr(part1,i,1)) > 0) {
	    ans += index(priorities,substr(part1,i,1))
	    break
	}
    }
}

END {
    print ans
}
