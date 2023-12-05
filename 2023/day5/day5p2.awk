# Advent of Code 2023 day 5 part 1 in awk
## Author: Chris Menard

BEGIN {
    FS="[ -]"
}

function remap(array, dest, src, len, prevarray,      idx,     range) {n
    for (idx in prevarray) {

	range = prevarray[idx]
	# check if beginning of a group of seeds is within a range to be remapped
	if (idx >= src && idx < src+len) {
	    
	    # check if group of seeds overlaps end of remap range
	    if (idx+range > src+len) {
		# new range shifted and truncated
		array[idx-(src-dest)] = src+len-idx
		
		# additional range created by truncation
		array[src+len] = range - (src+len-idx)

		delete array[idx]
	    } else {
		# if the group of seeds doesn't overlap the end of the remap range we can just shift the entire range
		array[idx-(src-dest)] = range
		delete array[idx]
	    }
	} else if (idx+range >=src && idx+range < src+len) {
	    # beginning of group is not within the remap range, but check full group range

		# new range not shifted but truncated
		array[idx] = src-idx

		# additional range created by truncation
		array[dest] = range - (src-idx)
		delete array[idx]
	} else if (idx < src && idx+range >= src+len) {
	    # seed group range completely overlaps remap range

	    # new range not shifted but truncated
	    array[idx] = src-idx

	    # additional range shifted and truncated
	    array[dest] = len

	    #additional range not shifted but truncated
	    array[src+len] = idx+range-(src+len)
	    delete array[idx]
	} else {
	    array[idx] = array[idx] ? array[idx] : range
	}
    }
}

# Index in seed is the start of the range, value is the length of the range
/seeds/ {
    for (i=2; i<=NF; i+=2) {
	seed[$i] = $(i+1)
    }
}

/[a-z]+-to-[a-z]/ {
    prev = $1
    arr = $3
}

/^[0-9]+ [0-9]+ [0-9]+/ {
    switch (arr) {
    case "soil":
	remap(soil, $1, $2, $3, seed)
	break
	
    case "fertilizer":
	remap(fertilizer, $1, $2, $3, soil)
	break

    case "water":
	remap(water, $1, $2, $3, fertilizer)
	break

    case "light":
	remap(light, $1, $2, $3, water)
	break

    case "temperature":
	remap(temperature, $1, $2, $3, light)
	break

    case "humidity":
	remap(humidity, $1, $2, $3, temperature)
	break

    case "location":
	remap(location, $1, $2, $3, humidity)
	break

    default:
	print "ERROR"
	break
    }

}

END {
    
    for (idx in location) {
	if (small == "" || small > location[idx])
	    small = location[idx]
    }

    print small
}
    
    
