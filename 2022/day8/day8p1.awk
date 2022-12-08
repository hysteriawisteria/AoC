# Advent of Code 2022 day 8 part 1 in awk
## Author: Chris Menard

# Forest is a string: 1 <= x <= width
#                     0 <= y <= height (NR)
#
# Position (x,y) = y*width + x


# Check whether a tree in location x,y is visible in an forest with dimensions of width x height

# Check visiblility left
function visLeft(forest,width,x,y,tree) {
    visible = 1

    for (u=x-1; u>=1; u--) {
	if (substr(forest,y*width + u,1) >= tree) {
	    visible = 0
	    break
	}
    }
    return  visible
}

# Check visibility right
function visRight(forest,width,x,y,tree) {
    visible = 1

    for (u=x+1; u<=width; u++) {
	if (substr(forest,y*width + u,1) >= tree) {
	    visible = 0
	    break
	}
    }
    return visible
}

# Check visibility up
function visUp(forest,width,x,y,tree) {
    visible = 1
    
    for (v=y-1; v>=0; v--) {
	if (substr(forest,v*width + x,1) >= tree) {
	    visible = 0
	    break
	}
    }
    return visible
}

# Check visibility down
function visDown(forest,width,height,x,y,tree) {
    visible = 1
    
    for (v=y+1; v<height; v++) {
	if (substr(forest,v*width + x,1) >= tree) {
	    visible = 0
	    break
	}
    }
    return visible
}
   

function isVisible(forest,width,height,x,y) {

    tree = substr(forest,y*width + x,1)

    if (visLeft(forest,width,x,y,tree) ||
	visRight(forest,width,x,y,tree) ||
	visUp(forest,width,x,y,tree) ||
	visDown(forest,width,height,x,y,tree))
	return 1
    else
	return 0
}

$0 ~ /[0-9]+/ {
    width = length($0)
    forest = forest $0
}

END {
    ans = 2*width + 2*NR - 4

    for (i=2; i<=(width-1); i++) {
	for (j=1; j<=(NR-2); j++) {
	    ans += isVisible(forest,width,NR,i,j)
	}
    }
    print ans
}
