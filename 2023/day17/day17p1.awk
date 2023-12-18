# Advent of Code 2023 day 17 part 2 in awk
## Author: Chris Menard

## (x,y) = width*y + x
##         1 <= x <= width
##         0 <= y <= height-1

function find_path(pos,map,width,height) {
    n = pos - width
    e = pos + 1
    s = pos + width
    w = pos -1

    # North
    if (n > 0) {
	visit(pos,n,map,"n")
    }

    # East
    if (pos%width != 0) {
	visit(pos,e,map,"e")
    }

    # South
    if (s <= height*width) {

	visit(pos,s,map,"s")
    }

    # West
    if (pos%width != 1) {
	visit(pos,w,map,"w")
    }

    return getMin(open)
}

function getMin(open) {
    min = ""
    for (p in open) {
	val = substr(open[p],1,index(open[p],",")-1) + 0
	if (min == "" || val < min) {
	    min = val
	    minPos = p
	}
    }
    return minPos
}

function visit(pos,neighbor,map,dir,     val,    nval,     loss,     regex) {

    regex = "[" dir "]{3}"
    if (substr(open[pos],index(open[pos],";")-3,index(open[pos],";")-1) ~ regex) {
	return
    }

    val = substr(open[pos],1,index(open[pos],",")-1) + 0
    path = substr(open[pos],index(open[pos],",")+1,index(open[pos],";")-1)

    if (closed[neighbor] ~ path) {
        return
    }

    nval = substr(open[neighbor],1,index(open[neighbor],",")-1)
    loss = val + substr(map,neighbor,1)
    
    if (nval=="" || loss < nval) {
	open[neighbor] = loss "," substr(open[pos],index(open[pos],",")+1) dir
    }
}

/[0-9]+/ {
    width = length($0)
    map = map $0
}

END {
    height = NR

    start = 1
    end = length(map)

    open[start] = 0 ","
    next_pos = find_path(start,map,width,height)

    while (next_pos != end) {
	next_pos = find_path(next_pos,map,width,height)
        print next_pos,open[next_pos]
    }

    print open[end]
}
    

