# Advent of Code 2023 day 1 part 2 in awk
## Author: Chris Menard

BEGIN {
    arr["one"]=1
    arr["two"]=2
    arr["three"]=3
    arr["four"]=4
    arr["five"]=5
    arr["six"]=6
    arr["seven"]=7
    arr["eight"]=8
    arr["nine"]=9
}
					

function reverse(string,     i,     newstring) {
    for (i=0; i<length(string); i++) {
	newstring = newstring substr(string,length(string)-i,1)
    }
    return newstring
}

$0 ~ /[[:alnum:]]/ {

    for (i=1; i<=length($0); i++) {
	str = substr($0,1,i)
	for (num in arr) {
	    if (gsub(num,arr[num],str)) {
		$0 = str substr($0,i)
		break
	    }
	}
	rev = substr($0,length($0)-i)
	for (num in arr) {
	    if (gsub(num,arr[num],rev)) {
		$0 = substr($0,1,length($0)-i) rev
		break
	    }
	}
    }
	
    mirror=reverse($0)
    print $0
    char1=substr($0,match($0,/[0-9]/),1)
    char2=substr(mirror,match(mirror,/[0-9]/),1)
    num = char1 char2
    tot += num
}

END {
    print tot
}
