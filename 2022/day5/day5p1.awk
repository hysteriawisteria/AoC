# Advent of Code 2022 day 5 part 1 in awk
## Author: Chris Menard

# Move one crate from col1 to col2
function move(col1,col2) {
    crates[col2] = substr(crates[col1],1,1) crates[col2]
    crates[col1] = substr(crates[col1],2)
}

$0 ~ /\[[A-Z]\]/ {
    arr = 0
    pos = match($0,/[A-Z]/)
    while (pos != 0) {
	arr += (pos - pos%4)/4 + 1
	crates[arr] = crates[arr] substr($0,pos,1)
	$0 = substr($0,pos+2)
	pos = match($0,/[A-Z]/)
    }
}

$0 ~ /move/ {
    for (i=0; i<$2; i++)
	move($4,$6)
}

END {
    for (i in crates)
	printf "%s", substr(crates[i],1,1)
}

