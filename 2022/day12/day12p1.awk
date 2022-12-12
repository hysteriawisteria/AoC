# Advent of Code 2022 day 12 part 1 in awk
## Author: Chris Menard

## (x,y) = width*y + x
##         1 <= x <= width
##         0 <= y <= height-1

function elev(pos,map) {
    char = substr(map,pos,1)
    
    if (char == "S") {
	return 1
    } else if (char == "E") {
	return 26
    } else {
	return index("abcdefghijklmnopqrstuvwxyz",char)
    }
}

function find_path(pos,map,width,height) {
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

    closed[pos] = open[pos]
    delete open[pos]

    return getMin(open)
}

function getMin(open) {
    min = ""
    for (p in open) {
	if (min == "" || open[p] < min) {
	    min = open[p]
	    minPos = p
	}
    }
    return minPos
}

function visit(pos,neighbor,map) {

    if ((elev(pos,map) > elev(neighbor,map)-2) && # Check height of neighbor
	(open[pos] + 1 < open[neighbor] ||  # Check for shorter path
	 open[neighbor] == "")) {

	open[neighbor] = open[pos] + 1
    }
}

$0 ~ /[a-z]+/ {
    width = length($0)
    map = map $0
}

END {
    height = NR

    start = index(map,"S")
    end = index(map,"E")

    open[start] = 0
    next_pos = find_path(start,map,width,height)

    while (next_pos != end) {
	next_pos = find_path(next_pos,map,width,height)
    }

    print open[end]
}

	
