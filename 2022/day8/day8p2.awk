# Advent of Code 2022 day 8 part 2 in awk
## Author: Chris Menard

# Forest is a string: 1 <= x <= width
#                     0 <= y <= height (NR)
#
# Position (x,y) = y*width + x

function view(forest,width,height,x,y) {
    tree = substr(forest,y*width + x,1)

    # Go left
    for (left=x-1; left>=1; left--) {
	if (substr(forest,y*width + left,1) >= tree)
	    break
    }

    # Go right
    for (right=x+1; right<=width; right++) {
	if (substr(forest,y*width + right,1) >= tree)
	    break
    }

    #Go up
    for (up=y-1; up>=0; up--) {
	if (substr(forest,up*width + x,1) >= tree)
	    break
    }

    #Go down
    for (down=y+1; down<height; down++) {
	if (substr(forest,down*width + x,1) >= tree)
	    break
    }

    if (left == 0)
	left = 1
    if (right == 6)
	right =5
    if (up == -1)
	up = 0
    if (down == 5)
	down = 4

    return (x-left) * (right-x) * (y-up) * (down-y)
}

$0 ~ /[0-9]+/ {
    width = length($0)
    forest = forest $0
}

END {
    for (i=1; i<=width; i++) {
	for (j=0; j<=NR-1; j++) {
	    distance = view(forest,width,NR,i,j)
	    if (distance > ans)
		ans = distance
	}
    }
    print ans
}
