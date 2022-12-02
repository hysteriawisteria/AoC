# Advent of Code 2022 day 2 part 2 in awk
## Author: Chris Menard

BEGIN {
    array["A X"] = 3
    array["A Y"] = 4
    array["A Z"] = 8
    array["B X"] = 1
    array["B Y"] = 5
    array["B Z"] = 9
    array["C X"] = 2
    array["C Y"] = 6
    array["C Z"] = 7
}
$0 ~ /[ABCYXZ[:space:]]{3}/ {
    score += array[$0]
}
END {
    print score
}

	
	
	    
	    
	
	
