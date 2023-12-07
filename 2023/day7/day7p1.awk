# Advent of Code 2023 day 7 part 1 in awk
## Author: Chris Menard

BEGIN {
    vals = "23456789JQKA"
}

# compare numeric values of val1 and val2
# returns 0 if val1>val2, 1 if val1<val2, 2 if val1==val2
function highest(val1, val2,     i) {
    

# compare two hands
# returns 0 if first sorts after second, 1 if first sorts before second, 2 if they are equal
function compare(first, second,     val1,     val2,     i) {
    val1 = substr(first,1,5)
    val2 = substr(second,1,5)

    Loop through hand types
    

}

# Do a quick sort on arr[] from 2022 day13p2
function qsort(low,high,    p) {
    if (low < high) {
	p = partition(low,high)
	qsort(low,p-1)
	qsort(p+1,high)
    }
}

function partition(low,high,    pivot,    i,    j) {
    pivot = arr[low]
    i = low

    for (j=low+1; j<=high; j++) {
	if (compare(arr[j],pivot)) {
	    i++
	    tmp = arr[i]
	    arr[i] = arr[j]
	    arr[j] = tmp
	}
    }
    tmp = arr[low]
    arr[low] = arr[i]
    arr[i] = tmp
    return i
}

/[0-9]+/ {
    hand[NR] = $1 $2
}

END {
    sort list by $1

}
