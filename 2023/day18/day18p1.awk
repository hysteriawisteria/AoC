# Advent of Code 2023 day 18 part 2 in awk
## Author: Chris Menard

BEGIN {
    x = 1
    y = 1

}

function print_terrain(     i) {
    for (i=1; i<=length(terrain); i++) {
	print terrain[i]
    }
}
    

function draw(dir, cnt,     i) {

    switch(dir) {
    case "R":
	if (x+cnt > length(terrain[y])) {
	    shiftL(x+cnt-length(terrain[y]))
	}

	for (i=1; i<=cnt; i++) {
	    terrain[y] = substr(terrain[y],1,x+i-1) "=" substr(terrain[y],x+i+1)
	}
	x += cnt
	break
	
    case "L":
	if (x-cnt < 1) {
	    shiftR(1+cnt-x)
	}

	for (i=1; i<=cnt; i++) {
	    terrain[y] = substr(terrain[y],1,x-i-1) "=" substr(terrain[y],x-i+1)
	}
	x -= cnt
	break
	
    case "U":
	if (y-cnt < 1) {
	    shiftD(1+cnt-y)
	}

	terrain[y] = substr(terrain[y],1,x-1) "+" substr(terrain[y],x+1)
	for (i=1; i<=cnt-1; i++) {
	    terrain[y-i] = substr(terrain[y-i],1,x-1) "+" substr(terrain[y-i],x+1)
	}
	terrain[y-i] = substr(terrain[y-i],1,x-1) "=" substr(terrain[y-i],x+1)
	y -= cnt
	break
	
    case "D":
	if (y+cnt > length(terrain)) {
	    shiftU(y+cnt-length(terrain))
	}
	
	for (i=1; i<=cnt; i++) {
	    terrain[y+i] = substr(terrain[y+i],1,x-1) "+" substr(terrain[y+i],x+1)
	}
	y += cnt
	break
    }
}

function shiftD(num,     i) {
    y += num
    
    for (i=length(terrain)+num; i > num; i--) {
	terrain[i] = terrain[i-num]
    }
    for (i=1; i<=num; i++) {
	terrain[i] = sprintf("%*s",length(terrain[y]),"")
	gsub(/ /,".",terrain[i])
    }
}

function shiftR(num,     i,     j) {
    x += num

    for (i=1; i<=length(terrain); i++) {
	for (j=1; j<=num; j++) {
	    terrain[i] = "." terrain[i]
	}
    }
}

function shiftU(num,     i,     len) {
    len = length(terrain)
    for (i=len+1; i<=len+num; i++) {
	terrain[i] = sprintf("%*s",length(terrain[1]),"")
	gsub(/ /,".",terrain[i])
    }
}

function shiftL(num,     i,     j) {
    for (i=1; i<=length(terrain); i++) {
	for (j=1; j<=num; j++) {
	    terrain[i] = terrain[i] "."
	}
    }
}
	     

$1 ~ /[RDLU]/ {
   draw($1, $2)
}

END {
    for (i=1; i<=length(terrain); i++) {

	split(terrain[i],segs,"+")
	for (j=2; j<=length(segs); j+=2) {
	    tot += length(segs[j]) - gsub("=","=",segs[j])
	}

	tot = tot + gsub("+","+",terrain[i]) + gsub("=","=",terrain[i])
    }

    print tot
}

