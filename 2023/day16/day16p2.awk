# Advent of Code 2023 day 16 part 1 in awk
## Author: Chris Menard

function contEW(dir, val) {
    switch(dir) {

    case "n":
    case "s":
	return val
    case "e":
	return val+1
    case "w":
	return val-1
    }
}
nn
function contNS(dir, val) {
    switch (dir) {

    case "n":
	return val-1
    case "s":
	return val+1
    case "e":
    case "w":
	return val
    }
}

function swapEW(dir, val) {
    switch(dir) {

    case "n":
    case "s":
	return val
    case "e":
	return val-1
    case "w":
	return val+1
    }
}

function swapNS(dir, val) {
    switch (dir) {

    case "n":
	return val+1
    case "s":
	return val-1
    case "e":
    case "w":
	return val
    }
}

function nextX(char, dir, x) {
    switch (char) {
	
    case ".":
    case "-":
    case "|":
	return contEW(dir, x)

    case "\\":
	return contNS(dir, x)
	
    case "/":
	return swapNS(dir, x)
    }
}

function nextY(char, dir ,y) {
    switch (char) {

    case ".":
    case "-":
    case "|":
	return contNS(dir, y)

    case "\\":
	return contEW(dir, y)
	
    case "/":
	return swapEW(dir, y)
    }
}

function nextDir(char, dir) {
    switch (char) {

    case ".":
	return dir

    case "\\":
	switch (dir) {
	    
	case "n":
	    return "w"
	case "s":
	    return "e"
	case "e":
	    return "s"
	case "w":
	    return "n"
	}

    case "/":
	switch (dir) {

	case "n":
	    return "e"
	case "s":
	    return "w"
	case "e":
	    return "n"
	case "w":
	    return "s"
	}
    }
}

# Return 0 if all beams have stopped, else 1
function cont(     beam,     ret) {
    ret = 0

    for (beam in beams) {
	if (beams[beam] != 0) {
	    ret = 1
	    break
	}
    }
    return ret
}
    
/[-|\/.]+/ {
    input[NR] = $1
}

END {
    for (start=1; start<=2*length(input) + 2*length(input[1]); start++) {
	if (start <= length(input[1])) {
	    x = start
	    y = 1
	    dir = "s"
	} else if (start <= length(input[1]) + length(input)) {
	    x = length(input[1])
	    y = start - length(input[1])
	    dir = "w"
	} else if (start <= 2*length(input[1]) + length(input)) {
	    x = start - length(input[1]) - length(input)
	    y = length(input)
	    dir = "n"
	} else {
	    x = 1
	    y = start - 2*length(input[1]) - length(input)
	    dir = "e"
	}

	beam = x "," y "," dir
	delete beams
        beams[beam] = beam
	delete energized
    
        while (cont()) {

	    for (beam in beams) {

		if (beams[beam] == 0) {
		    continue
		}
	    
		split(beam,info,",")
		x = info[1]
		y = info[2]
		dir = info[3]
		char = substr(input[y],x,1)

		# continue while we don't need to change directions or split
		while (char=="." || (char=="|" && (dir=="n" || dir=="s")) || (char=="-" && (dir=="e" || dir=="w"))) {
		
		    energized[x "," y]++
		    x = nextX(char, dir, x)
		    y = nextY(char, dir, y)
		    
		    if (x > 0 && y > 0)
			char = substr(input[y],x,1)
		    else
			break
		}

		# change direction
		if (char ~ /[/\\]/) {
		    beams[beam] = 0
		
		    energized[x "," y]++
		    x = nextX(char, dir, x)
		    y = nextY(char, dir, y)
		    dir = nextDir(char, dir)
		}

		# split beam
		if ((char=="|" && (dir=="e" || dir=="w")) || (char=="-" && (dir=="n" || dir=="s"))) {
		    beams[beam] = 0
		    energized[x "," y]++

		    chars["/"] = ""
		    chars["\\"] = ""
		    for (char in chars) {
			newx = nextX(char, dir, x)
			newy = nextY(char, dir, y)
			newdir = nextDir(char, dir)

			if (newx > 0 && newy > 0 && newx <= length(input[y]) && newy <= length(input)) {
			    beam = newx "," newy "," newdir
			    if (!(beam in beams))
				beams[beam] = beam
			}
		    }
		    continue
		}

		# see if we've gone off the edge
		if (x < 1 || y < 1 || x > length(input[y]) || y > length(input)) {
		    beams[beam] = 0
		    break
		} else {
		    beam = x "," y "," dir
		    if (!(beam in beams))
			beams[beam] = beam
                }
	    }
	}
	max = max > length(energized) ? max : length(energized)
    }

    print max
}
