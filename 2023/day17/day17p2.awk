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

# Assumes width
function findx(pos) {
    return (pos-1)%width+1
}

# Assumes width
function findy(pos) {
    return int((pos-1)/width)
}

# Assumes width
function findpos(x,y) {
    return width*y+x
}

#  Assumes width/height
function find_path(node,map,     pos,    delim,     path,     x,     y,    dir,     len) {
    delim = index(node,",")
    pos = substr(node,1,delim-1)
    path = substr(node,delim+1)


    x = findx(pos)
    y = findy(pos)
    
    # Prune out loops
    if (open[node] ~ /s{4}e{4}n{4}w{4}|s{4}w{4}n{4}e{4}|e{4}s{4}w{4}n{4}|e{4}n{4}w{4}s{4}|n{4}w{4}s{4}e{4}|n{4}e{4}s{4}w{4}|w{4}n{4}e{4}s{4}|w{4}s{4}e{4}n{4}/) {
	for (minx=1; minx<=x; minx++) {
	    for (miny=0; miny<=y; miny++) {
		closed[findpos(minx,miny)] = ""
	    }
	}
    }

    if (pos in closed) {
	delete open[node]
	return getMin(open)
    }

    # direction and steps already travelled in direction
    dir = substr(path,1,1)
    len = length(path)

    # Process travelling directions
    # Note that x: [1,width] y: [0,height-1]
    if (dir == "n" || dir == "s") {
	if (x <= width-min) {
	    add(node,"e","")
	}
	if (x > min) {
	    add(node,"w","")
	}
	if (dir == "n" && len < max && y > 0) {
	    add(node,"n",path)
	} else if (dir == "s" && len < max && y < height-1) {
	    add(node,"s",path)
	}
	
    } else if (dir == "e" || dir == "w") {
	if (y >= min) {
	    add(node,"n","")
	}
	if (y < height-min) {
	    add(node,"s","")
	}
	if (dir == "e" && len < max && x < width) {
	    add(node,"e",path)
	} else if (dir == "w" && len < max && x > 1) {
	    add(node,"w",path)
	}
    }

    delete open[node]
    return getMin(open)
}

# Assumes width
function add(node,dir,path,     delim,      pos,     npath,     x,     y,    val,     count,     i) {
    delim = index(node,",")
    pos = substr(node,1,delim-1)
    npath = path

    x = findx(pos)
    y = findy(pos)

    val = paths[open[node]]

    # Travel minimum distance
    if (npath == "") {
	count = min
    } else {
	count = 1
    }
	
    for (i=1; i<=count; i++) {
	    
	switch (dir) {
	case "n":
	    y--
	    val += substr(map,findpos(x,y),1)
	    npath = npath "n"
	    break
	case "e":
	    x++
	    val += substr(map,findpos(x,y),1)
	    npath = npath "e"
	    break
	case "s":
	    y++
	    val += substr(map,findpos(x,y),1)
	    npath = npath "s"
	    break
	case "w":
	    x--
	    val += substr(map,findpos(x,y),1)
	    npath = npath "w"
	    break
	}
    }

    nnode = findpos(x,y) "," npath
    # Account for the difference in moving 1 space versus min spaces
    if (path == "") {
	npath = open[node] npath
    } else {
	npath = open[node] dir
    }

    if (open[nnode] == "" || val < paths[open[nnode]]) {
	open[nnode] = npath
	paths[npath] = val
    }
}

# Return minimum value
# Assumes and sets gmin - used as a shortcut to find previous min
# Possible since we will always add equal or higher values than the previous minimum
function getMin(open,     val,      minval,     minPos,     idx) {
    minval = ""
    for (p in open) {
	val = paths[open[p]] - 2*findx(p) - 2*findy(p)

	if (minval == "" || val < minval) {
	    minval = val
	    minPos = p
	}
	
	if (minval == gmin) {
	    break
	}
    }
    gmin = minval
    return minPos
}

/[0-9]+/ {
    width = length($0) # Assumed by functions
    map = map $0
}

END {
    height = NR # Assumed by functions

    start = "1,"
    end = length(map)
    
    open[start] = ""
    paths[""] = 0
    add(start,"e","")
    add(start,"s","")
    delete open[start]
    next_pos = getMin(open)
    
    while (loc(next_pos) != end) {
	next_pos = find_path(next_pos,map)

	if (paths[open[next_pos]] > lim) {
	    lim +=50
	    print next_pos,open[next_pos],paths[open[next_pos]]
	}
    }

    print paths[open[next_pos]]
}
