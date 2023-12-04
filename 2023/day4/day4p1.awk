# Advent of Code 2023 day 4 part 1 in awk
## Author: Chris Menard

BEGIN {
    FS = "[:|]"
}

/[0-9]+/ {
    count = 0
    split($2, temp," ")
    split($3, nums," ")
    delete winning
    
    for (i in temp) {
	winning[temp[i]] = i
    }

    for (num in nums) {
	if (nums[num] in winning)
	    count++
	
    }
    if (count > 0)
	tot += 2**(count-1)
}

END {
    print tot
}
