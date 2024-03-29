# Advent of Code 2022 day 13 part 1 in awk
## Author: Chris Menard

# 'a' keeps track of what pair we're on, 'p' keeps track of whether it's the first or second packet
BEGIN {a = 1}

# assume first character is [ and last is ] and remove them
function strip(list) {
    return substr(list,2,length(list)-2)
}

# return delimiter for first versus last of a list
# offset for special handling between calls from first() and last()
function part(list,offset) {
    lvl = 0
    
    for (i=1; i<=length(list); i++) {
	if (substr(list,i,1) == "[") {
	    lvl++
	} else if (substr(list,i,1) == "]") {
	    lvl--
	} else if (substr(list,i,1) == "," && lvl == 0) {
            return i
        }
    }
    return length(list) + offset
}

# return first part of list
function first(list) {
    if (index(list,",") != 0) {
        d = part(list,1)
        list = substr(list,1,d-1)
    }
    return list
}

# return second part of list
function rest(list) {
    if (index(list,",") == 0) {
        return ""
    } else {
        d = part(list,0)
	list = substr(list,d+1,length(list)-d)
    }
    return list
}

# compare two lists
# returns 0 if the pack1 sorts after pack2, 1 if pack1 sorts before pack2, or 2 if pack1 == pack2
# Assume pack1 and pack2 are either null or correctly formatted list (i.e., bracketed by '[' and ']')
function compare(pack1,pack2,    f1,    f2,    r1,    r2,    val) {

    # Check case where there's a different number of items in a packet
    if (pack1=="" && pack2=="") {
	return 2
    } else if (pack1 == "") {
	return 1
    } else if (pack2 == "") {
	return 0
    }

    # Check case where we're in a list of solely integers
    if (index(pack1,"[") == 0 && index(pack2,"[") == 0) {
	if (+pack1 > +pack2) {
	    return 0
	} else if (+pack2 > +pack1) {
	    return 1
	} else if (+pack1 == +pack2){
	    return 2
	}
    } else if (index(pack1,"[") == 0) {
	pack2 = strip(pack2)
    } else if (index(pack2,"[") == 0) {
	pack1 = strip(pack1)
    } else {
	pack1 = strip(pack1)
	pack2 = strip(pack2)
    }
	    
    # Divide each string into first and rest
    f1 = first(pack1)
    r1 = rest(pack1)

    f2 = first(pack2)
    r2 = rest(pack2)

    # Recursion on first and rest
    val = compare(f1,f2)

    while (val==2 && (r1!="" || r2!="")) {
	f1 = first(r1)
	r1 = rest(r1)

	f2 = first(r2)
	r2 = rest(r2)

	val = compare(f1,f2)
    }
    return val
}

$0 ~ /[[\]]+/ {
    p++
    arr[p] = $0
    if (p == 2 && compare(arr[1],arr[2])) {
	    ans += a
    }
}

$0 ~ /^$/ {
    p = 0
    a++
}

END {print ans}
