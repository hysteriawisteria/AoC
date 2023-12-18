# Advent of Code 2023 day 18 part 2 in awk
## Author: Chris Menard

BEGIN {
    x = 1
    y = 1
}

function draw(dir, cnt) {

    switch(dir) {
    case "R":
	break
    case "L":
	break
    case "U":
	break
    case "D":
	break

    }
}

function shiftD(num) {

}

function shiftR(num) {

}

$1 ~ /[RDLU]/ {
    draw($1, $2)
}

