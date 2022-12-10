# Advent of Code 2022 day 10 part 1 in awk
## Author: Chris Menard

BEGIN {reg=1}

function draw(cycle,reg) {
    col = (cycle - 1) % 40
    row = ((cycle - 1) - col) / 40

    if (col >= reg-1 && col<= reg+1) {
	sym = "#"
    } else {
	sym = "."
    }

    ans[row] = ans[row] sym
}

$0 ~ /noop/ {
    cycle++
    draw(cycle,reg)
}

$0 ~ /addx/ {
    cycle++
    draw(cycle,reg)
    cycle++
    draw(cycle,reg)
    reg += $2
}

END {
    for (i=0; i<6; i++) {
	print ans[i]
    }
}
