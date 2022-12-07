# Advent of Code 2022 day 7 part 1 in awk
## Author: Chris Menard

$0 ~ /\$ cd [/a-zA-Z0-9]+/ {
    if (check) {
	visited[path] = 1
	check = 0
    }
    
    path = $3 "^" path
}

$0 ~ /\$ ls/ {
    check = 1
}

$0 ~ /^[0-9]+/ {
    if (visited[path] == 1)
	next
    
    dir = path
    sizes[dir] += $1

    while (dir != "") {
	dir = substr(dir,index(dir,"^")+1)
	sizes[dir] += $1
    }
}

$0 ~ /\.\./ {
    path = substr(path,index(path,"^")+1)
}

END {
    for (i in sizes) {
	
	if (sizes[i] <= 100000)
	    ans += sizes[i]
    }

    print ans
}





