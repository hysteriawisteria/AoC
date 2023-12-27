# Advent of Code 2023 day 17 part 2 in awk
## Author: Chris Menard

## (x,y) = width*y + x
##         1 <= x <= width
##         0 <= y <= height-1

# paths[path] = heat loss
# open[node] = path
# node = [location on map],[last 3 movements]

function loc(node) {
    return substr(node,1,index(node,",")-1)
}

function find_path(node,map,width,height,     pos,    n,     e,     s,     w,     dir) {
    pos = loc(node)
    n = pos - width
    e = pos + 1
    s = pos + width
    w = pos - 1

    dir = substr(node,length(node),1)
    
    # North
    if (n > 0 && !(n in closed) && dir != "s") {
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
    if (path == "" || substr(path,1,1) == dir) {
	npath = path dir
    } else {
	npath = dir
    }

    if ((open[node] dir) ~ /senw|swne|eswn|enws|nesw|news|wsen|wnes/) {
	closed[neighbor] = ""
    }
    
    # Avoid going 4 in a row
    if (npath ~ /nnnn|eeee|wwww|ssss/) {
	return 1
    }

    val = paths[open[node]] + substr(map,neighbor,1)
    nnode = neighbor "," substr(npath,length(npath)-2)

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
    
    while (loc(next_pos) != end) {
	next_pos = find_path(next_pos,map,width,height)
    }

    print paths[open[next_pos]]
}
