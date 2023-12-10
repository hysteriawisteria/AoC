# Advent of Code 2023 day 10 part 2 in awk
## Author: Chris Menard

function print_input(     i) {
    for (i=0; i<length(input); i++) {
	print input[i]
    }
}

function step(seg,     pipe,     idx) {
    pipe = substr(input[seg[0]],seg[1],1)
    
    for (idx in npipe) {
	if (idx == seg[2] || pipe !~ npipe[idx])
	    continue
	if (check(idx,seg))
	    break
    }
}

function check(dir,seg,    row,     col,     pipe) {
    
    switch (dir) {
    case 0:
	row = seg[0]-1
	col = seg[1]
	break
    case 1:
	row = seg[0]
	col = seg[1]+1
	break
    case 4:
	row = seg[0]+1
	col = seg[1]
	break
    case 3:
	row = seg[0]
	col = seg[1]-1
	break
    }
    pipe = substr(input[row],col,1)
    if (pipe ~ npipe[4-dir] || pipe =="+") {
	if (dir == 0 || seg[2] == 0)
	    mark = "+"
	else
	    mark = "="
	
	input[seg[0]] = substr(input[seg[0]],1,seg[1]-1) mark substr(input[seg[0]],seg[1]+1)
	
	seg[0] = row
	seg[1] = col
	seg[2] = 4-dir
	return 1
    }
    return 0
}

BEGIN {
    # 0 - north,  1 - east, 4 - south, 3 - west
    npipe[0] = "[|JLS]"
    npipe[1] = "[-LFS]"
    npipe[4] = "[|F7S]"
    npipe[3] = "[-7JS]"
}

/[JF7L.S-|]/ {
    input[NR]="." $1 "."
    if (index(input[NR],"S") != 0) {
	start = index(input[NR],"S")
	row = NR
    }
}

END {
    # pad top and bottom
    bot = length(input) + 1
    input[bot] = sprintf("%*s",length(input[1]),"")
    gsub(/ /,".",input[bot])

    input[0] = sprintf("%*s",length(input[1]),"")
    gsub(/ /,".",input[0])

   count = 1

    # idx 0 = row, idx 1 = col, idx 2 = direction to last node
    f[0] = row
    f[1] = start
    l[0] = row
    l[1] = start
    mark = ""

    for (idx in npipe) {
	if (check(idx,f))
	    break
    }
    
    while (f[0] != l[0] || f[1] != l[1]) {
	count++
	step(f)
    }
    
    pipe = substr(input[f[0]],f[1],1)
    
    if (f[2] == 0)
	mark = "+"
    else
	mark = "="

    input[f[0]] = substr(input[f[0]],1,f[1]-1) mark substr(input[f[0]],f[1]+1)

    #print_input()
    for (i=1; i<length(input); i++) {
	split(input[i],segs,"+")
	for (j=2; j<=length(segs); j+=2) {
	    tot += length(segs[j]) - gsub("=","#",segs[j])
	}
    }
    print tot
}


