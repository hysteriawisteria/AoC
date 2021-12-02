# Advent of Code 2021 day 1 part 1 in awk
## Author: Chris Menard

$0 ~ /[0-9]+/ {if (prev>0 && $1>prev) total=++} # Don't increment on the first line, only process lines with numbers
{prev=$1}
END {print total}
