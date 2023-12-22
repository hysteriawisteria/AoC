# Advent of Code 2023 day 8 part 2 in awk
## Author: Chris Menard

# Convince awk that seq is an array
BEGIN {
    seq[""] = ""
    delete seq
}

# Euclid's algorithm for gcd
function gcd(num1, num2,     mod) {
    mod = num1 % num2
    num1 = num2
    num2 = mod

    while (mod != 0) {
	mod = num1 % num2
	num1 = num2
	num2 = mod
    }

    return num1
}
    
function iter(arr,step,     idx,     newarr,     ret,     node) {
    ret = 0
    
    for (idx=1; idx<=length(arr); idx++) {
	split(map[nodes[idx]],temp,",")
        node = temp[substr(directions,(step-1)%length(directions)+1,1)]

	if (substr(node,3,1) != "Z") {
	    ret = 1
	} else {
	    if (seq[idx] == "") {
		seq[idx] = seq[idx] step
	    }
        }
	
        arr[idx] = node
    }
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
    count = 1
    for (i in map) {
	if (substr(i,3,1) == "A") {
	    nodes[count] = i
	    count ++
	}
    }
        
    step = 1
    
    while (iter(nodes,step)) {
	step++

	if (length(seq) == length(nodes)) {
	    tot = seq[1]
	    for (i=2; i<=length(seq); i++) {
		tot *= seq[i]/gcd(tot,seq[i])
	    }
	    break
	}
    }
    print tot
}
