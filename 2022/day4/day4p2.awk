# Advent of Code 2022 day4 part 1 in awk
## Author: Chris Menard

function contains(p1,p2,p3,p4) {
    if (p2 < p3 || p1 > p4)
	return 0
    else
	return 1
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
