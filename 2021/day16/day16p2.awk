# Advent of Code 2021, day 16 part 1
## Author: Chris Menard

function h2b(string,   char,   bin,   num) {
    bin = ""
    
    for (char=1; char<=length(string); char++) {
	bin = bin sprintf("%04d",d2b(index("123456789abcdef",tolower(substr(string,char,1)))))
    }

    return bin
}

function d2b(dec,   bin) {

    bin = ""
    while (dec > 0) {

	bin = dec%2 bin
	dec -= dec%2
	dec /= 2
    }
	
    return bin
}

function b2d(bin,   char,   dec) {

    dec = 0
    for (char=1; char<=length(bin); char++) {
	dec = 2*dec + substr(bin,char,1)
    }

    return dec
}

# parse a numbered packet into comma delimited list
function parse_packet(input,parent,   num,   len,   count,   orig_length) {
    len = 0
    packets[0]++
    num = length(packets)

    if (parent)
	packets[parent] = packets[parent] "," num

    # version num is the first 3 bits
    version = b2d(substr(input,1,3))


    # packet type is the next 3 bits
    type = b2d(substr(input,4,3))

    packets[num] = version "," type
    
    # Type 4 is s a literal value type
    if (type == 4) {

	iter = 1

	cont = substr(input,2+5*iter,1)
	val = substr(input,3+5*iter,4)

	while (cont == 1) {
	    iter++
	    cont = substr(input,2+5*iter,1)
	    val = val substr(input,3+5*iter,4)
	}

	packets[num] = packets[num] "," b2d(val)

	# Find packet length
	len = 6+5*iter

	# Trim input and return
	return substr(input,len+1)
    }
    else { # Packet type is anything else

	# Find lenth type
	ltype = substr(input,7,1)

	if (ltype == 1) {
	     
	    len = b2d(substr(input,8,11))

	    # Trim input of first 18 characters
	    input = substr(input,19)
	    for (count=1; count<=len; count++) {
		input = parse_packet(input,num)

	    }
	    return input
	}
	else { # Length type 0

	    len = b2d(substr(input,8,15))

	    #Trim input of first 22 characters
	    input = (substr(input,23))

	    orig_length = length(input)
	    while (orig_length - length(input) < len) {
		input = parse_packet(input,num)
	    }
	    
	    return input
	}
    }
}

function evaluate_packet(packet,   contents,   result,   tmpr,   i) {
    split(packets[packet],contents,",")

    # Return literal values
    if (contents[2] == 4) {
	return contents[3]
    }
    else if (contents[2] == 0) { # Sum packet

	result = 0
	for (i=3; i<=length(contents); i++)
	    result += evaluate_packet(contents[i])

	return result
    }
    else if (contents[2] == 1) { # Product packet

	result = 1
	for (i=3; i<=length(contents); i++)
	    result *= evaluate_packet(contents[i])

	return result
    }
    else if (contents[2] == 2) { # Minimum packet

	result = evaluate_packet(contents[3])
	for (i=4; i<=length(contents); i++) {

	    tmpr = evaluate_packet(contents[i])
	    if (tmpr < result)
		result = tmpr
	}

	return result
    }
    else if (contents[2] == 3) { # Maximum packet
	
	result = evaluate_packet(contents[3])
	for (i=4; i<=length(contents); i++) {

	    tmpr = evaluate_packet(contents[i])
	    if (tmpr > result)
		result = tmpr
	}

	return result
    }
    else if (contents[2] == 5) { # Greater than packet
	
	if (evaluate_packet(contents[3]) > evaluate_packet(contents[4]))
	    return 1
	else
	    return 0
    }
    else if (contents[2] == 6) { # Less than packet
	if (evaluate_packet(contents[3]) < evaluate_packet(contents[4]))
	    return 1
	else
	    return 0
    }
    else if (contents[2] == 7) { # Equal to packet
	if (evaluate_packet(contents[3]) == evaluate_packet(contents[4]))
	    return 1
	else
	    return 0
    }
}

/[[:xdigit:]]+/ {input = h2b($1)}

END {
    parse_packet(input)

    print evaluate_packet(1)
}

	     
	     
