# Advent of Code 2022 day 1 part 2 in awk
## Author: Chris Menard

function updateHighest(calories) {
    lowest = 0

    for (i=1; i<3; i++) {
        if (highest[lowest] > highest[i])
            lowest = i
    }

    if (calories > highest[lowest])
        highest[lowest] = calories
}

$0 ~ /[0-9]+/ {calories += $1}
$0 ~ /^$/ {
    updateHighest(calories)
    calories = 0
}
END {
    updateHighest(calories)
    for (i=0; i<3; i++)
        total += highest[i]

    print total
}
