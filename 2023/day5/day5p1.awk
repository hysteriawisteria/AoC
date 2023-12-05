# Advent of Code 2023 day 5 part 1 in awk
## Author: Chris Menard

BEGIN {
    FS="[ -]"
}

function remap(array, dest, src, len, prevarray,      idx,     val) {n
    for (idx in prevarray) {

	val = prevarray[idx]
	if (val >= src && val < src+len) {
	    array[idx] = val - (src - dest)
	} else {
	    array[idx] = array[idx] ? array[idx] : val
	}
    }
}

function print_seeds() {
    for (idx in seed) {
	printf "seed %d, soil %d, fertilizer %d, water %d, light %d, temperature %d, humidity %d, location %d\n", seed[idx], soil[idx], fertilizer[idx], water[idx], light[idx], temperature[idx], humidity[idx], location[idx]
}
}

/seeds/ {
    for (i=2; i<=NF; i++) {
	seed[$i] = $i
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
    # print_seeds()
    for (idx in location) {
	if (small == "" || small > location[idx])
	    small = location[idx]
    }

    print small
}
    
    
