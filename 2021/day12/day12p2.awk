# Advent of Code 2021, day 12 part 2
## Author: Chris Menard

# Plan:
# Will store paths in a path array where path[begin] = dest1,dest2,...
# Will need to ensure we store both path directions
# Will start at path[start] and recursively navigate through the array
# Will return when we reach 'end' with a value
# If destx is a small room, we will replace the contents of path[destx] with a visited character
# When encountering a visited character, we just return 0. Also true if we end back at the start

function addPath(path,start,end) {

    if (path[start] == "") 
	path[start] = end
    else
	path[start] = path[start] "," end
}

function print_paths(path) {
    for (i in path) {
	printf "%s -> %s\n",i,path[i]
    }

    printf "\n"
}

function traverse(src,path,visited,twice,   subtotal,   paths) { # Make sure subtotal/paths are local

    # Return if we've visited a small cave unless we haven't visited a cave twice yet
    if (src ~ /[a-z]+/ && visited ~ src) {
	
	if (twice == "")
	    twice = src
	else 
	    return 0
    }

    visited == "" ? visited = src : visited = visited "," src

    if (src == "end") {
#	print visited
	return 1
    }

    subtotal = 0
    paths=path[src]

    while (paths != "") {
	match(paths,/([a-zA-Z]+),?([a-zA-Z,]*)/,parts)
	first = parts[1]
	paths = parts[2]

	subtotal += traverse(first,path,visited,twice)
    }

    return subtotal
}

BEGIN {
    FS="-"
}

/[a-zA-Z]+\-[a-zA-Z]+/ {
    if ($1 == "start") {
	addPath(path,$1,$2)
	next
    }
    else if ($2 == "start") {
	addPath(path,$2,$1)
	next
    }
    else {
	addPath(path,$1,$2)
	addPath(path,$2,$1)
    }
}

END {

    total += traverse("start",path,"","")

    print total
}
    
