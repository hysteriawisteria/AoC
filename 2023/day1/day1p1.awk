# Advent of Code 2023 day 1 part 1 in awk
## Author: Chris Menard

function reverse(string,     i,     newstring) {
    for (i=0; i<length(string); i++) {
	newstring = newstring substr(string,length(string)-i,1)
    }
    return newstring
}

$0 ~ /[[:alnum:]]/ {
    mirror=reverse($0)
    char1=substr($0,match($0,/[0-9]/),1)
    char2=substr(mirror,match(mirror,/[0-9]/),1)
    num = char1 char2
    tot += num
}

END {
    print tot
}

