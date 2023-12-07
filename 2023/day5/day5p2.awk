# Advent of Code 2023 day 5 part 1 in awk
## Author: Chris Menard

# TODO - fix sloppy code

BEGIN {
    FS="[ -]"
}

function flush(a1, a2,    idx) {
    for (idx in a2) {
	a1[idx] = a2[idx]
    }
    delete a2
}

function remap(array, dest, src, len, prevarray,      idx,     range) {
    for (idx in prevarray) {

	range = prevarray[idx]
	idx += 0

	if (idx < src && idx+range > src+len) {
	    prevarray[idx] = src-idx
	    array[dest] = len
	    prevarray[src+len] = range-len-(src-idx)
	    
	} else if (idx >= src && idx < src+len && idx+range > src+len) {
	    array[idx-(src-dest)] = src+len-idx
	    prevarray[src+len] = range-(src+len-idx)
	    delete prevarray[idx]
	    
	} else if (idx < src && idx+range > src && idx+range <= src+len) {
	    prevarray[idx] = src-idx
	    array[dest] = range-(src-idx)
	    
	} else if (idx >= src && idx+range <= src+len) {
	    array[idx-(src-dest)] = range
	    delete prevarray[idx]
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
	flush(soil, seed)
	remap(fertilizer, $1, $2, $3, soil)
	break

    case "water":
	flush(fertilizer, soil)
	remap(water, $1, $2, $3, fertilizer)
	break

    case "light":
	flush(water, fertilizer)
	remap(light, $1, $2, $3, water)
	break

    case "temperature":
	flush(light, water)
	remap(temperature, $1, $2, $3, light)
	break

    case "humidity":
	flush(temperature, light)
	remap(humidity, $1, $2, $3, temperature)
	break

    case "location":
	flush(humidity, temperature)
	remap(location, $1, $2, $3, humidity)
	break

    default:
	print "ERROR"
	break
    }

}

END {
    flush(location, humidity)
    
    for (idx in location) {
	if (small == "" || small > idx)
	    small = idx
    }

    print small
}
