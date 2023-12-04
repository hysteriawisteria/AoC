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
    card = cards[NR] ? cards[NR] : 1


    
    for (i in temp) {
	winning[temp[i]] = i
    }

    for (num in nums) {
	if (nums[num] in winning)
	    count++
	
    }
    printf "%d: %d\n", card, count
    for (i=1; i<= count; i++) {
	cards[NR+i] += card
    }
    
    tot += card
}

END {
    print tot
}
