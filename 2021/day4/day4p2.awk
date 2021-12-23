# Advent of Code 2021, day 4 part 1
## Author: Chris Menard

# I'm representing the data for each bingo board as a comma delimited string of 2-width padded
# numbers. As a result, the position for each string element 'k' is 3*k-2. When a position is "marked" on
# the board, we replace the number with the string '..'

function print_boards(boards,   i) { #Function to print bingo boards
    for (bnum=1; bnum<=length(boards); bnum++) {
	for (i=1; i<=25; i++) {
	    printf "%2s", substr(boards[bnum],3*i-2,2)
	    if (i % 5 == 0 )
		printf "\n"
	    else
		printf " "
	}
	printf "\n"
    }
}

function isWinning(boards) {

    for (bnum=1; bnum<=length(boards); bnum++) {
	if (isWinningCol(boards[bnum]) || isWinningRow(boards[bnum]))
	    return bnum
    }
    return 0
}

function isWinningCol(board,   i) {
    for (i=1; i<=5; i++) {
	if (substr(board,3*i-2,2) == ".."  &&
	    substr(board,3*i+13,2) == ".."  &&
	    substr(board,3*i+28,2) == ".."  &&
	    substr(board,3*i+43,2) == ".."  &&
	    substr(board,3*i+58,2) == "..")
	    return 1
    }
    return 0
}

function isWinningRow(board,   i) {
    for (i=1; i<=5; i++) {
	if (substr(board,15*i-14,2) == ".." &&
	    substr(board,15*i-11,2) == ".." &&
	    substr(board,15*i-8,2) == ".." &&
	    substr(board,15*i-5,2) == ".." &&
	    substr(board,15*i-2,2) == "..")
	    return 1
    }
    return 0
}

function markBoards(boards,num,   i) {
    if (num < 10) num = " "num
    num=num","  # Append trailing comma to ensure exact match
    for (bnum=1; bnum<=length(boards); bnum++) {
	sub(num,"..,",boards[bnum])
    }
}

function sumBoard(board,   i) {
    total=0
    for (i=1; i<=25; i++) {
	nVal=substr(board,3*i-2,2)
	if (nVal != "..") total=total+nVal
    }
    return total
}


BEGIN {
    getline
    len=split($0,inputs,",")
}

/^$/ {bnum++;next} # Move to next board

# Read in bingo board as a comma delimited, 25 number string
{boards[bnum]=boards[bnum] sprintf("%2s,%2s,%2s,%2s,%2s,", $1, $2, $3, $4, $5)}

END {
    for (i=1; i<=len; i++) {
	val=inputs[i]
	markBoards(boards,val)

	winningBoard=isWinning(boards)
	while (winningBoard != 0) { # While loop to ensure we erase multiple winning boards if needed
	    lastWin=boards[winningBoard]
	    delete boards[winningBoard]
	    lastVal=val

	    winningBoard=isWinning(boards)
	}
    }
    print sumBoard(lastWin)*lastVal
}



