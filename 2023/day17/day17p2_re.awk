# Advent of Code 2023 day 17 part 2 in awk
## Author: Chris Menard

## (x,y) = width*y + x
##         1 <= x <= width
##         0 <= y <= height-1

# paths[path] = heat loss
# open[node] = path
# node = [location on map],[last 3 movements]

BEGIN {
    min = 4
    max = 10
}

function loc(node) {
    return substr(node,1,index(node,",")-1)
}

function findx(pos,width) {
    return (pos-1)%width+1
}

function findy(pos,width) {
    return int((pos-1)/width)
}

function find_path(node,map,width,height,     pos,    n,     e,     s,     w,     dir) {
    delim = index(node,",")
    pos = substr(node,1,delim-1)
    path = substr(node,delim+1)

    x = findx(pos,width)
    y = findy(pos,width)

    # direction and steps already travelled in direction
    dir = substr(path,1,1)
    len = length(path)
    
    # North if enough space, not 180 turn,
    if (x > (min - len) && dir != "s" && (dir == "" || (dir == "n" && len < max) || len >= min)) {
	
    if (n > (min-len)*width && !(n in closed) && dir != "s") {
	visit(node,n,map,"n")
    }

    # East
    if (pos%width != 0 && !(e in closed) && dir != "w") {
	visit(node,e,map,"e")
    }

    # South
    if (s <= height*width && !(s in closed) && dir != "n") {
	visit(node,s,map,"s")
    }

    # West
    if (pos%width != 1 && !(w in closed) && dir !="e") {
	visit(node,w,map,"w")
    }

    closed[node] = open[node]
    delete open[node]
    
    return getMin(open)
}

function getMin(open,     val,      min,     minPos,     idx) {
   min = ""
  for (p in open) {
      val = paths[open[p]]
      if (min == "" || val < min) {
	  min = val
	  minPos = p
      }
   }
  return minPos
}

function visit(node,neighbor,map,dir,     val,     npath,     nnode) {
    path = substr(node,index(node,",")+1)
    pdir = substr(path,1,1)

    if (length(path) < 4 && path != "" && pdir != dir) {
	return
    } else if (path == "" || pdir == dir) {
	npath = path dir
    } else {
	npath = dir
    }

    if ((open[node] dir) ~ /s{4}e{4}n{4}w{4}|e{4}s{4}w{4}n{4}/) {
	closed[neighbor] = ""
    }
    
    # Avoid going 10 in a row
    if (length(npath) == 10) {
	return 1
    }

    val = paths[open[node]] + substr(map,neighbor,1)
    nnode = neighbor "," npath

    if (open[nnode] == "" || val < paths[open[nnode]]) {
        open[nnode] = open[node] dir
	paths[open[node] dir] = val
    }
    
    return 0
}

/[0-9]+/ {
    width = length($0)
    map = map $0
}

END {
    height = NR

    start = "1,"
    end = length(map)

    open[start] = ""
    paths[""] = 0
    next_pos = find_path(start,map,width,height)

    lim = 50
    
    while (loc(next_pos) != end || length(substr(next_pos,index(next_pos,",")+1)) < 4) {
	next_pos = find_path(next_pos,map,width,height)

#	if (paths[open[next_pos]] > lim) {
#	    lim +=50
	    print next_pos,open[next_pos],paths[open[next_pos]]
#	}
    }

    print paths[open[next_pos]]
}
