# Advent of Code 2022 day 10 part 1 in awk
## Author: Chris Menard

BEGIN {reg=1}

function draw(cycle,reg) {
    col = (cycle - 1) % 40

    ans = sprintf("%s%c",ans,(col >= reg-1 && col<= reg+1) ? "#" : ".")

    if (cycle%40 == 0) {
	ans = ans "\n"
    }
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
    printf "%s\n", ans
}
