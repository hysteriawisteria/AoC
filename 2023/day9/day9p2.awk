# Advent of Code 2023 day 9 part 2 in awk
## Author: Chris Menard

function append(values,     i,     diffs,     allzero) {
    allzero = 0
    for (i=1; i< length(values); i++) {
	diffs[i] = values[i+1] - values[i]
	allzero = diffs[i]!=0 ? 1 : allzero
    }

    if (allzero) {
	append(diffs)
	values[0] = values[1] - diffs[0]
    } else {
	values[0] = values[1]
    }
    return
}

/[0-9]+/ {
    split($0,nums)

    append(nums)

    tot += nums[0]
}

END {
    print tot
}

