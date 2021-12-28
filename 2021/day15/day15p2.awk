# Advent of Code 2021, day 15 part 2
## Author: Chris Menard

# We'll try Dijkstra's algorithm and see if that manages this problem
#
# Storing the cavern as a string: 1 <= x <= width
#                                 0 <= y <  height
#
# Position (x,y) = y*width + x

# Return true if we find the end, otherwise return false
# Add processed nodes to the closed list and update open nodes with traversal cost
function find_path(pos,cavern,width,height,mult) {
    n = pos - width
    e = pos + 1
    s = pos + width
    w = pos - 1

    # If not on top row, process north
    if (n > 0 &&
	! (n in closed)) {
	
	process(pos,n,cavern,width,height,mult)

	if (n == end)
	    return n
    }

    if (pos%width != 0 &&
	! (e in closed)) {
	
	process(pos,e,cavern,width,height,mult)

	if (e == end)
	    return e
    }

    if (s <= width*height &&
	! (s in closed)) {
	
	process(pos,s,cavern,width,height,mult)

	if (s == end) 
	    return s
    }
	

    if (pos%width != 1 &&
	! (w in closed)) {
	
	process(pos,w,cavern,width,height,mult)

	if (w == end)
	    return w
    }

    closed[pos] = open[pos]
    delete open[pos]

    return getMin(open,width,height)
}

function getMin(open,width,height) {
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

function process(pos,neighbor,cavern,width,height,mult) {

    # Get value of neighbor, assuming that the cavern risk level is 1 higher
    # for each multiple of the original width (width/mult) and height (height/mult)
    # we move away from the original (width/mult) x (height/mult) area

    val = substr(cavern,neighbor,1)
    val = adjust_value(val,neighbor,width,height,mult)

    if (open[pos] + val < open[neighbor] || open[neighbor] == "")
	open[neighbor] = open[pos] + val

}

# Adjustment math:
#   width: pos-1 mod width to give line number, divide that by original width to get extra value
#   height pos-1 divided by the width * original height
function adjust_value(val,p,width,height,mult) {
    val += int(((p-1)%width)/(width/mult)) + int((p-1)/(width*height/mult))

    while (val > 9)
	val -= 9

    return val
}

function print_cavern(cavern,width,height) {
    for (line=0; line<height; line++) {
	printf "%s\n", substr(cavern,line*width+1,width)
    }
    printf "\n"
}
function print_modified(cavern,width,height,mult) {
    for (pos=1; pos<=length(cavern); pos++) {

	val = substr(cavern,pos,1)

	val = adjust_value(val,pos,width,height,mult)
	
	printf "%s", val

	if (pos%width == 0)
	    printf "\n"
    }
    printf "\n"
}


BEGIN {mult=5} # Increase cavern size by mult times

/[0-9]+/ {
    
    for (i=1; i<=mult; i++)
	cavern = cavern $1
    
    width = mult * length($1)
}

END {
    orig_cavern=cavern
    
    # Do a mult x height cavern
    for (i=1; i<mult; i++)
	cavern = cavern orig_cavern

    height = mult * NR
    start = 1
    end = width * height

    # print_modified(cavern,width,height,mult)
    # exit 1

    open[start] = 0
    next_pos = find_path(start,cavern,width,height,mult)

    # Find the path starting from the start
    while(next_pos != end) {
	next_pos = find_path(next_pos,cavern,width,height,mult)

    }

    print open[end]
}
