# Advent of Code 2021 day 2 part 1 in awk
## Author: Chris Menard

/forward/ { x=x+$2}
/down/ { y=y+$2}
/up/ { y=y-$2}

END {print x*y}
    
    
