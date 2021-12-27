# Advent of Code 2021, day 13 part 1
## Author: Chris Menard

function foldLeft(points,line) {
    for (combined in points) {

	# x-cord is separate[1], y-cord is separate[2]
	split(combined,separate,SUBSEP)
	x = separate[1]
	y = separate[2]

	
	if (x > line) {
	    points[2*line-x,y] = "#"
	    delete points[x,y]
	}
    }
}

function foldUp(points,line) {
    for (combined in points) {

	# x-cord is separate[1], y-cord is separate[2]
	split(combined,separate,SUBSEP)
	x = separate[1]
	y = separate[2]

	
	if (y > line) {
	    points[x,2*line-y] = "#"
	    delete points[x,y]
	}
    }
}


BEGIN {FS = "[ ,=]"}

/[0-9]+,[0-9]+/ {
    points[$1,$2] = "#"
}

/fold along (x|y)=[0-9]+/ {
    if ($3 == "x") {
	foldLeft(points,$4)
    }
    else if ($3 == "y") {
	foldUp(points,$4)
    }
    print length(points)
}

