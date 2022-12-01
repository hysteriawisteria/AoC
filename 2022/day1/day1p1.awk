# Advent of Code 2022 day 1 part 1 in awk
## Author: Chris Menard

$0 ~ /[0-9]+/ {calories[elf] += $1}
$0 ~ /^$/ {if (calories[elf] > highest) highest = calories[elf]; elf++}
END {print highest}
