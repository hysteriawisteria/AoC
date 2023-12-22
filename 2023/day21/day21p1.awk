# Advent of Code 2023 day 21 part 1 in awk
## Author: Chris Menard

BEGIN {
    steps = 64
}

function find_set(map,width,height) {
    for (pos in open) {
	n = pos - width
	e = pos + 1
	s = pos + width
	w = pos -1

	# North
	if (n > 0 && !(n in closed)) {
	    visit(pos,n,map)
	}

	# East
	if (pos%width != 0 && !(e in closed)) {
	    visit(pos,e,map)
	}
	
	# South
	if (s <= height*width && !(s in closed)) {
	    
	    visit(pos,s,map)
	}
	
	# West
	if (pos%width != 1 && !(w in closed)) {
	    visit(pos,w,map)
	}
	
	if (open[pos] == steps) {
	    closed[pos] = open[pos]
	}
	delete open[pos]
    }
}

function visit(pos,neighbor,map) {

    if (substr(map,neighbor,1) != "#") {
	open[neighbor] = open[pos] + 1
    }
}

/[.#S]+/ {
    width = length($0)
    map = map $0
}

END {
    height = NR

    start = index(map,"S")

    open[start] = 0

    for (i=1; i<=steps; i++) {
	find_set(map,width,height)
    }

    print length(open)
}
