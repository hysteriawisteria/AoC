# Advent of Code 2023 day 21 part 1 in awk
## Author: Chris Menard

BEGIN {
    steps = 64
}

function find_set(map,width,height,     pos,     x,     y) {
    for (pos in open) {
	x = substr(pos,1,index(pos,",")-1)
        y = substr(pos,index(pos,",")+1)

	visit(x+1,y,map,open[pos])
	visit(x-1,y,map,open[pos])
	visit(x,y+1,map,open[pos])
	visit(x,y-1,map,open[pos])

	delete open[pos]
    }
}

function visit(x,y,map,step) {
    tmpx = x % width
    tmpy = y % height

    tmpx = tmpx <= 0 ? tmpx + width : tmpx
    tmpy = tmpy <= 0 ? tmpy + height : tmpy

    if (substr(map[tmpy],tmpx,1) != "#") {
	open[x "," y] = step + 1
    }
}

/[.#S]+/ {
    map[NR] = $1

    if ($1 ~ /S/) {
	startx = index($1,"S")
	starty = NR
    }
}

END {
    width = length(map[1])
    height = length(map)

    open[startx "," starty] = 0
    
    for (i=1; i<=steps; i++) {
	find_set(map,width,height)
    }

    print length(open)
}
