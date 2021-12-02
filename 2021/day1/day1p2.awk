# Advent of code 2021, day 1 part 2 in awk
## Author: Chris Menard

$1 ~ /[0-9]+/ { depths[NR]=$1;
    prev=NR-3;
    if (prev in depths) depths[NR] > depths[prev] ? total++ : total=total;
    delete depths[prev] # Clean up potential memory leaks
}

END {print total}
