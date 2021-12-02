# Advent of Code 2021 day 2 part 2 in awk
## Author: Chris Menard

/forward/ { x=x+$2;depth=depth+$2*aim}
/down/ { aim=aim+$2}
/up/ { aim=aim-$2}

END {print x*depth}
    
    
