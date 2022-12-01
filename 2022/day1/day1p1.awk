# Advent of Code 2022 day 1 part 1 in awk
## Author: Chris Menard

$0 ~ /[0-9]+/ {calories += $1}
$0 ~ /^$/ {if (calories > highest) highest = calories; calories=0 }
END {print highest}
