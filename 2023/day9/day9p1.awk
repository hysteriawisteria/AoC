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
	values[length(values)+1] = values[length(values)] + diffs[length(diffs)]
    } else {
	values[length(values)+1] = values[1]
    }
    return
}

/[0-9]+/ {
    split($0,nums)

    append(nums)

    tot += nums[length(nums)]
}

END {
    print tot
}

