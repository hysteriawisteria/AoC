# Advent of Code 2023 day 18 part 2 in awk
## Author: Chris Menard

BEGIN {
    x = 1
    y = 1
    ind = "123456789abcde"
}

$1 ~ /[RDLU]/ {
    dir = substr($3,8,1)
    str = substr($3,3,5)

    val = 0
    for (i=1; i<=length(str); i++) {
	val = val*16 + index(ind,substr(str,i,1))
    }
}

END {

}

