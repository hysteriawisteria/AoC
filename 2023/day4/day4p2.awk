# Advent of Code 2023 day 4 part 2 in awk
## Author: Chris Menard

BEGIN {
    FS = "[:|]"
}

/[0-9]+/ {
    count = 0
    split($2, temp," ")
    split($3, nums," ")
    delete winning

    # default one copy of the current card
    cards[NR] = cards[NR] ? cards[NR] : 1


    
    for (i in temp) {
	winning[temp[i]] = i
    }

    for (num in nums) {
	if (nums[num] in winning)
	    count++
	
    }

    for (i=1; i<= count; i++) {
	cards[NR+i] = ( cards[NR+i] ? cards[NR+i] : 1 ) + cards[NR] 
    }
    
    tot += cards[NR]
}

END {
    print tot
}
