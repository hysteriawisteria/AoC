# Advent of Code 2021, day 25 part 1
## Author: Chris Menard

# Goal: to store the entire board of dimensions width x height as a string
# A 1-indexed position x1,y1 would then be: (y1-1) * width + x1
# More useful is to 0-index by height and 1-index by width for: y1 * width + x1
### This is because awk substrings start at index 1

function print_board(state,width,height) {
    for (line=0; line<height; line++) {
	printf "%s\n",substr(state,line*width+1,width)
    }
    printf "\n"
}

function step(state,width,height) {
    
    tmp_board = step_east(state,width,height)
    return step_down(tmp_board,width,height)
}

function step_east(state,width,height) {
    return perform_step(state,width,height,">",".")
}

function step_down(state,width,height) {
    return transpose(perform_step(transpose(state,width,height),height,width,"v","."),height,width)
}

# Step char1 into char2 ona board. No stepping into other characters
function perform_step(state,width,height,char1,char2) {
    pat1 = char1 "\\" char2
    pat2 = char2 char1

    new_state = ""

    for (line=0; line<height; line++) {

	# Easy case
	row=substr(state,line*width+1,width)
	gsub(pat1,pat2,row)
	new_state = substr(new_state,1,line*width) row substr(new_state,line*width+width+1)

	# Literal edge cases
	if (substr(state,line*width+1,1) == char2 &&
	    substr(state,line*width+width,1) == char1)
	    new_state = substr(new_state,1,line*width) char1 substr(new_state,line*width+2,width-2)\
		char2 substr(new_state,line*width+width+1)
    }

    return new_state
}

# Swap rows and columns. NOTE: height and width swap for transposed boards
function transpose(state,width,height) {

    new_state = ""
    for (x=1; x<=width; x++) {
	for (y=0; y<height; y++) {
	    new_state = new_state substr(state,y*width+x,1)
	}
    }
    return new_state
}

/[v>.]+/ {
    board = board $1
    width = length($1)
}

END {
    height = NR
    count = 1

    next_board = step(board,width,height)

    while (next_board != board) {

	board = next_board
	next_board = step(board,width,height)
	count++
    }

    print count
}
