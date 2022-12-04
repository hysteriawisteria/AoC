# Advent of Code 2022 day4 part 1 in awk
## Author: Chris Menard

function contains(p1,p2,p3,p4) {
    if ((p1 <= p3 && p2 >= p4) ||
	(p3 <= p1 && p4 >= p2))
	return 1
    else
	return 0
}

BEGIN {
    FS = "[-,]"
}

$0 ~ /[0-9]+-[0-9]+,[0-9]+-[0-9]+/ {
    ans += contains($1,$2,$3,$4)
}

END {
    print ans
}
