# Advent of Code 2023 day 8 part 2 in awk
## Author: Chris Menard

function iter(arr,i,     idx,     newarr,     ret,     node) {
    ret = 0
    for (idx in arr) {
	split(map[idx],temp,",")
        node = temp[substr(direction,i,1)]
        ret = substr(node,3,1) != "Z" ? 1 : ret
        newarr[node] = 1
    }
    delete arr

    for (idx in newarr) {
	arr[idx] = 1
    }
    delete newarr
    return ret
}

BEGIN {
    FS = "[ =,)(]"
}

NR == 1 {
    directions=$1
    gsub(/L/,"1",directions)
    gsub(/R/,"2",directions)
}

/=/ {
    map[$1] = $5 "," $7
}

END {
    for (i in map) {
	if (substr(i,3,1) == "A") {
	    nodes[i] = 1
	}
    }
        
    i = 1
    step = 0

    while (iter(nodes,i)) {
        i = i>=length(directions) ? 1 : i+1
	step++
    }
    
    print step
}
