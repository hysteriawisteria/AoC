# Advent of Code 2023 day 7 part 1 in awk
## Author: Chris Menard

BEGIN {
    vals = "J23456789TQKA"
}

# Return type of hand
#     return values:
#     1 - high card
#     2 - one pair
#     3 - two pair
#     4 - 3 of a kind
#     5 - full house
#     6 - 4 of a kind
#     7 - 5 of a kind
function categorize(hand,     i,     idx,     cards) {
    cards["J"] = 0
    for (i=1; i<=length(hand); i++) {
	
	cards[substr(hand,i,1)]++
    }

    # Check for 5 of a kind, one pair, and high card
    if (length(cards) == 1 || length(cards) == 2) {
	return 7
    } else if (length(cards) == 5) {
	return 2
    } else if (length(cards) == 6) {
	return 1
    }
    # Check for full house versus 4 of a kind
    else if (length(cards) == 3) {
	if (cards["J"] == 4) {
	    return 6
	}
	for (idx in cards) {
	    if (cards[idx]+cards["J"]== 4) {
		return 6
	    }
	}
	return 5
    }
    # Check for two pair versus 3 of a kind
    else if (length(cards) == 4) {
	if (cards["J"] == 3) {
	    return 4
	}
	for (idx in cards) {
	    if (cards[idx]+cards["J"] == 3) {
		return 4
	    }
	}
	return 3
    } else {
	print "ERROR: impossible hand"
    }
}

# compare two hands
# returns 0 if first sorts after second, 1 if first sorts before second, 2 if they are equal
function compare(first, second,     val1,     val2,     i,     type1,     type2) {
    val1 = substr(first,1,5)
    val2 = substr(second,1,5)

    type1 = categorize(val1)
    type2 = categorize(val2)

    if (type1 > type2) {
	return 0
    } else if (type2 > type1) {
	return 1
    } else {
	for (i=1; i<=length(val1); i++) {
	    if (index(vals,substr(val1,i,1)) > index(vals,substr(val2,i,1))) {
		return 0
	    } else if (index(vals,substr(val2,i,1)) > index(vals,substr(val1,i,1))){
		return 1
	    }
	}
    }
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
    arr[NR] = $1 $2
}

END {
    # Sort cards
    qsort(1,length(arr))

    for (i=1; i<=length(arr); i++) {
	tot += i*substr(arr[i],6)
    }

    print tot
}
