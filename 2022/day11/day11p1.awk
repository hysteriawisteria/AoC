# Advent of Code 2022 day 11 part 1 in awk
## Author: Chris Menard

# monkeys[monkey] = (false monkey),(true monkey),{test operand),(operation operator),(operation operand),(^ delimited item list)

BEGIN {
    monkey = -1
    rounds = 20
}

# Process turn for monkey 'm'
function process(m) {
    split(monkeys[m],data,",")
    split(data[6],items,"^")

    #rebuild monkey array without items
    monkeys[m] = ""
    for (u=1; u<6; u++) {
	monkeys[m] = monkeys[m] data[u] ","
    }
    
    # first item always ""
    for (item=2; item<=length(items); item++) {
        if (item == "") {continue}

	inspected[m]++

	oper = data[5] == "old" ? items[item] : data[5]
        worry = data[4] == "+" ? items[item] + oper : items[item] * oper
        worry = (worry - worry%3)/3

	worry%data[3] == 0 ? monkeys[data[2]] = monkeys[data[2]] "^" worry : monkeys[data[1]] = monkeys[data[1]] "^" worry
    }
}

$0 ~ /Monkey/ {
    monkey++
    FS = ": "
}

$0 ~ /Starting items/ {
    FS = " "
    split($2,items,", ")

    for (i=1; i<=length(items); i++) {
        monkeys[monkey] = monkeys[monkey] "^" items[i]
    }
}

$0 ~ /Operation/ { monkeys[monkey] = $5 "," $6 "," monkeys[monkey] }

$0 ~ /Test/ { monkeys[monkey] = $4 "," monkeys[monkey] }

$0 ~ /true|false/ { monkeys[monkey] = $6 "," monkeys[monkey] }

END {
    for (i=0; i<rounds; i++) {
	for (j=0; j<length(monkeys); j++) {
	    process(j)
	}
    }

    highest = 0

    for (i in inspected) {
	if (inspected[highest] < inspected[i]) {
	    highest = i
	}
    }
    val1 = inspected[highest]
    delete inspected[highest]

    for (i in inspected) {
	if (inspected[highest] < inspected[i]) {
	    highest = i
	}
    }

    print val1*inspected[highest]
}

