# Advent of Code 2021, day 11 part 2
## Author: Chris Menard

# We'll store the data from the width x height input as a single string, numbered from
# 1 -> width x height

function charge(input,pos,width) {
    val = substr(input,pos,1)

    if (val == "c") {
	return input
    }

    if (val < 9) {
	val++
	input =	substr(input,1,pos-1) val substr(input,pos+1)
    }
    else if (val == 9) {
	input =	substr(input,1,pos-1) "c" substr(input,pos+1)

	if (pos%width != 1) {
	   input=charge(input,pos-1,width)
	}

	if (pos%width !=0) {
	    input=charge(input,pos+1,width)
	}

	if (pos > width) {
	    input=charge(input,pos-width,width)

	    if (pos%width != 1) {
		input=charge(input,pos-width-1,width)
	    }
	    if (pos%width !=0) {
		input=charge(input,pos-width+1,width)
	    }
	}

	if (pos <= length(input)-width) {
	    input=charge(input,pos+width,width)

	    if (pos%width != 1) {
		input=charge(input,pos+width-1,width)
	    }
	    if (pos%width !=0) {
		input=charge(input,pos+width+1,width)
	    }
	}
    }

    return input
}

function print_board(input,width,height) {
    for (y=0; y<height; y++) {
	printf "%s\n",substr(input,y*width+1,width)
    }
    printf "\n"
}

/[0-9]+/ {
    input = input $1
    width = length($1)
}


END {
    height = NR

    flashes = 0
    step = 0
    while (flashes != length(input)) {

	step++
	
	for (pos=1; pos<=length(input); pos++) {
	    input = charge(input,pos,width)
	}

	flashes=gsub("c",0,input)
    }

    print step
}
