# Advent of Code 2022 day 10 part 1 in awk
## Author: Chris Menard

BEGIN {reg=1}

function check(cycle,reg) {
    if (cycle%40 == 20) {
	ans += cycle*reg
    }
}

$0 ~ /noop/ {
    cycle++
    check(cycle,reg)
}

$0 ~ /addx/ {
    cycle++
    check(cycle,reg)
    cycle++
    check(cycle,reg)
    reg += $2
}

END {
    print ans
}
