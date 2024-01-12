# Advent of Code 2023 day 18 part 2 in awk
## Author: Chris Menard

# Using the trapezoid formula with an initial value of half the perimeter
BEGIN {
    x = 1
    y = 1
    tot = 1
    idx = 1
    ind = "123456789abcdef"
}

$1 ~ /[RDLU]/ {
    dir = substr($3,8,1)
    str = substr($3,3,5)

    val = 0
    for (i=1; i<=length(str); i++) {
	val = val*16 + index(ind,substr(str,i,1))
    }
    
    switch (dir) {
    case "0":
	x += val
	tot += val
	break
    case "1":
	y += val
	tot += val
	break
    case "2":
	x -= val
	break
    case "3":
	y -= val
	break
    }
    list[idx] = x "," y
    idx++
}

END {
    len = length(list)
    list[idx] = list[1]

    # Trapezoid formula
    for (i=1; i<=len; i++) {
	delim1 = index(list[i],",")
	x1 = substr(list[i],1,delim1-1)
	y1 = substr(list[i],delim1+1)

	delim2 = index(list[i+1],",")
	x2 = substr(list[i+1],1,delim2-1)
	y2 = substr(list[i+1],delim2+1)

	tot += (y1 + y2) * (x1 - x2) / 2
    }
    print tot
}

