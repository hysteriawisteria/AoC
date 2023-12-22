# Advent of Code 2023 day 8 part 1 in awk
## Author: Chris Menard

BEGIN {
    FS = "[ =,)(]"
}

NR == 1 {
    directions=$1
    gsub(/L/,"1",directions)
    gsub(/R/,"2",directions)
}

/=/ {
    map[$1] = $5 "," $7
}

END {
    step = 1
    node = "AAA"

    while (node != "ZZZ") {
	split(map[node],temp,",")
        node=temp[substr(directions,(step-1)%length(directions)+1,1)]
	step++
    }

    print step-1
}
