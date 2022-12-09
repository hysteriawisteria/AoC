# Advent of Code 2022 day 9 part 1 in awk
## Author: Chris Menard

# Head is at hx,hy
# Tail is at tx,ty

BEGIN {
    hx = 0
    hy = 0
    tx = 0
    ty = 0
}

function moveT() {
    if (hx == tx && hy == ty+2)
	ty++
    else if (hx == tx && hy == ty-2)
	ty--
    else if (hy == ty && hx == tx+2)
	tx++
    else if (hy == ty && hx == tx-2)
	tx--
    else if (hy == ty+2 && hx != tx) {
	ty++
	tx = hx
    }
    else if (hy == ty-2 && hx != tx) {
	ty--
	tx=hx
    }
    else if (hx == tx+2 && hy != ty) {
	tx++
	ty = hy
    }
    else if (hx == tx-2 && hy != ty) {
	tx--
	ty = hy
    }

    visited[tx","ty]++
}

$1 == "R" {
    for (i=0; i<$2; i++) {
        hx++
        moveT()
    }
}

$1 == "U" {
    for (i=0; i<$2; i++) {
	hy++
	moveT()
    }
}

$1 == "L" {
    for (i=0; i<$2; i++) {
	hx--
	moveT()
    }
}

$1 == "D" {
    for (i=0; i<$2; i++) {
	hy--
	moveT()
    }
}

END {
    print length(visited)
}

	
    
