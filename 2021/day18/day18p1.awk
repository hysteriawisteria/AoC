# Advent of Code 2021, day 17 part 2
## Author: Chris Menard

# Find the magnitude of a snailfish num
function magnitude(num,   pos,   lvl) {
    
    if (num ~ /^[0-9]$/)
	return num

    # Find the comma between the two sides of the num
    lvl = 0

    for (pos=1; pos<=length(num); pos++) {
	if (substr(num,pos,1) == "[")
	    lvl++
	else if (substr(num,pos,1) == "]")
	    lvl--
	else if (lvl == 1 &&
		 substr(num,pos,1) == ",")
	    break
    }

    return 3*magnitude(substr(num,2,pos-2)) + 2*magnitude(substr(num,pos+1,length(num)-pos-1))
}

function add(num1,num2) {

    if (num1 == "")
	return num2
    
    number = "[" num1 "," num2 "]"

    lvl = 0
    cont = 1

    while (cont == 1) {

	cont = 0
	
	pos = ""
	lnum = ""
	rnum = ""
	
	tosplit = 0
	splitpos=""
	
	len = length(number)
	for (i=1; i<=len; i++) {

	    # Account for two character numbers
	    if (substr(number,i,1) ~ /[0-9]/ &&
		substr(number,i+1,1) ~ /[0-9]/) {
		pos = 10*substr(number,i,1) + substr(number,i+1,1)
		i++
	    }
	    else {
		pos = substr(number,i,1)
	    }
	    
	    if (pos == "[")
		lvl++
	    else if (pos == "]")
		lvl--
	    else if (lvl >= 5 &&
		     pos ~ /[0-9]+/) {

		# Explode
		cont = 1

		# Find right value
		rval = substr(number,i+1+match(substr(number,i+2),/[0-9]+/),RLENGTH)

		# Find the next regular number to the right after the exploding pair
		if (match(substr(number,i+5),/[0-9]+/) != 0) {
		    rnum = substr(number,i+4+RSTART,RLENGTH)
		    rpos = i+4+RSTART
		}

		# Build left side of new number
		if (lnum == "") {
		    p1 = substr(number,1,i-1-length(pos))
		    p2 = ""
		    p3 = ""
		}
		else {
		    p1 = substr(number,1,lpos-1)
		    p2 = lnum + pos
		    p3 = substr(number,lpos+length(lnum),i-length(pos)-lpos-length(lnum))
		}

		# Build right side of new number
		if (rnum == "") {
		    p4 = ""
		    p5 = ""
		    p6 = substr(number,i+3+length(rval))
		}
		else {
		    p4 = substr(number,i+3+length(rval),rpos-i-3-length(rval))
		    p5 = rnum + rval
		    p6 = substr(number,rpos+length(rnum))
		}

		# New number, always with 0 in the middle
		number = p1 p2 p3 "0" p4 p5 p6

		# Will want to continue to further reduce
		cont = 1
		
		# Recalculate length, i, and lvl
		len = length(number)
		i = length(p1) + length(p2) + length(p3) + 1
		lvl--

		# Update split status if needed
		if (p2 > 9 && tosplit == 0) {
		    splitpos = length(p1) + 1
		    tosplit = 1
		}

		# Update [lr]num and [lr]pos so we can continue with future explodes
		lnum = 0
		lpos = i
		rnum = ""
		rpos = ""
		
	    }
	    else if (pos ~ /[0-9]+/) {
		lnum = pos
		lpos = i + 1 - length(pos)

		if (pos > 9 && tosplit == 0) {
		    splitpos = i - 1 # We incremented i an extra time
		    tosplit = 1
		}
	    }
	}

	# Split if needed now that we know there are no explodes
	if (tosplit == 1) {
	    
	    cont = 1
	    
	    pos = substr(number,splitpos,2)
	    number = sprintf("%s[%d,%d]%s",substr(number,1,splitpos-1),int(pos/2),int((pos+1)/2),substr(number,splitpos+2))
	}
    }

    return number
}

BEGIN {
    number = ""
}


/\[[0-9,]+\]/ {
    number = add(number,$1)
}

END {
    print number
    print magnitude(number)
}
