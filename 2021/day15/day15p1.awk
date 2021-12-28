# Advent of Code 2021, day 15 part 1
## Author: Chris Menard

# We'll try Dijkstra's algorithm and see if that manages this problem
#
# Storing the cavern as a string: 1 <= x <= width
#                                 0 <= y <  height
#
# Position (x,y) = y*width + x

# Return true if we find the end, otherwise return false
# Add processed nodes to the closed list and update open nodes with traversal cost
function find_path(pos,cavern,width,height) {
    n = pos - width
    e = pos + 1
    s = pos + width
    w = pos - 1

    # If not on top row, process north
    if (n > 0 &&
	! (n in closed)) {
	
	process(pos,n,cavern)

	if (n == end)
	    return n
    }

    if (pos%width != 0 &&
	! (e in closed)) {
	
	process(pos,e,cavern)

	if (e == end)
	    return e
    }

    if (pos <= width*height - width &&
	! (s in closed)) {
	
	process(pos,s,cavern)

	if (s == end) 
	    return s
    }
	

    if (pos%width != 1 &&
	! (w in closed)) {
	
	process(pos,w,cavern)

	if (w == end)
	    return w
    }

    closed[pos] = open[pos]
    delete open[pos]

    return getMin(open)
}

function getMin(open) {
    first = 1

    for (pos in open) {
	
	if (first) {
	    min = open[pos]
	    first = 0
	    minPos = pos
	}

	if (open[pos] < min) {
	    min = open[pos]
	    minPos = pos
	}
    }
    
    return minPos
}


function process(pos,neighbor,cavern) {

    if (open[pos] + substr(cavern,neighbor,1) < open[neighbor] ||
	open[neighbor] == "") {

	open[neighbor] = open[pos] + substr(cavern,neighbor,1)
    }
}

/[0-9]+/ {
    cavern = cavern $1
    width = length($1)
}

END {
    height = NR
    start = 1
    end = width * height

    open[start] = 0
    next_pos = find_path(start,cavern,width,height)

    # Find the path starting from the start
    while(next_pos != end) {
	next_pos = find_path(next_pos,cavern,width,height)
    }

    print open[end]

}
