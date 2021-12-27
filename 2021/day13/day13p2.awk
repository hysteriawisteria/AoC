# Advent of Code 2021, day 13 part 2
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

function print_points(points,width,height) {
    
    for (y=0; y<height; y++) {
	for (x=0; x<width; x++) {
	    
	    if (points[x,y] == "#")
		printf "%c","#"
	    else
		printf "%c","."
	}
	printf "\n"
    }
    printf "\n"

}

BEGIN {FS = "[ ,=]"}

/[0-9]+,[0-9]+/ {
    points[$1,$2] = "#"
    
    if (width < $1)
	width = $1
    
    if (height < $2)
	height = $2
}

/fold along (x|y)=[0-9]+/ {
    if ($3 == "x") {
	foldLeft(points,$4)
	width = $4
    }
    else if ($3 == "y") {
	foldUp(points,$4)
	height= $4
    }
}

END {
    print_points(points,width,height)
}

