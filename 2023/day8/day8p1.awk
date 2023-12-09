# Advent of Code 2023 day 8 part 1 in awk
## Author: Chris Menard

BEGIN {
    FS = "[ =,)(]"
}

NR == 1 {
    directions=$1
    gsub(/L/,"1",directions)
    gsub(/R/,"2",directions)
    print directions
}

/=/ {
    map[$1] = $5 "," $7
}

END {
    step = 0
    node = "AAA"
    i = 1

    while (node != "ZZZ") {
	split(map[node],temp,",")
        node=temp[substr(directions,i,1)]
        i = i>=length(directions) ? 1 : i+1
	step++
    }

    print step
}
