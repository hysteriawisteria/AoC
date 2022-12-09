# Advent of Code 2022 day 9 part 1 in awk
## Author: Chris Menard

# Knots stored in array knot, numbered 0 - 9

BEGIN {
    for (i=0; i<=9; i++)
	knot[i]="0,0"
}

# update location of knot based on the previous knot
function moveknot(k) {
    split(knot[k-1],h,",")
    split(knot[k],t,",")
    
    if (h[1] == t[1] && h[2] == t[2]+2)
	t[2]++
    else if (h[1] == t[1] && h[2] == t[2]-2)
	t[2]--
    else if (h[2] == t[2] && h[1] == t[1]+2)
	t[1]++
    else if (h[2] == t[2] && h[1] == t[1]-2)
	t[1]--
    else if (h[2] == t[2]+2 && h[1] > t[1]) {
	t[2]++
	t[1]++
    }
    else if (h[2] == t[2]+2 && h[1] < t[1]) {
        t[2]++
        t[1]--
    }
    else if (h[2] == t[2]-2 && h[1] > t[1]) {
	t[2]--
	t[1]++
    }
    else if (h[2] == t[2]-2 && h[1] < t[1]) {
        t[2]--
        t[1]--
    }
    else if (h[1] == t[1]+2 && h[2] > t[2]) {
	t[1]++
	t[2]++
    }
    else if (h[1] == t[1]+2 && h[2] < t[2]) {
	t[1]++
	t[2]--
    }
    else if (h[1] == t[1]-2 && h[2] > t[2]) {
	t[1]--
	t[2]++
    }
    else if (h[1] == t[1]-2 && h[2] < t[2]) {
	t[1]--
	t[2]--
    }

    knot[k] = t[1]","t[2]

    if (k == 9)
	visited[knot[k]]++
}

function move() {
    for (j=1; j<=9; j++)
        moveknot(j)
}

$0 ~ /[RULD]/ {
    for (i=0; i<$2; i++) {
        split(knot[0],h,",")

        if ($1 == "R")
	    h[1]++
	else if ($1 == "L")
	    h[1]--
	else if ($1 == "U")
	    h[2]++
	else if ($1 == "D")
	    h[2]--

	knot[0] = h[1]","h[2]
        move()
    }
}

END {
    print length(visited)
}

	
    
