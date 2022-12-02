# Advent of Code 2022 day 2 part 1 in awk
## Author: Chris Menard

BEGIN {
    array["A X"] = 4
    array["A Y"] = 8
    array["A Z"] = 3
    array["B X"] = 1
    array["B Y"] = 5
    array["B Z"] = 9
    array["C X"] = 7
    array["C Y"] = 2
    array["C Z"] = 6
}
$0 ~ /[ABCYXZ[:space:]]{3}/ {
    score += array[$0]
}
END {
    print score
}

	
	
	    
	    
	
	
