# Advent of Code 2021 day 3 part 2 in awk
## Author: Chris Menard
## IMPORTANT: use GNU compliant awk

function filter(filtArr,defVal,pos) {
    len=length(filtArr)
    if (len==1) {for (i in filtArr) return i}  # Base case for recursion where 1 value remains

    ones_gt_zeros(filtArr,pos) < 0 ? val=1-defVal : val=defVal # Invert default value of more 1s than 0s
    
    for (i in filtArr) {
	if (substr(i,pos,1) != val) delete filtArr[i] # Delete data strings that have the wrong value in this position
    }
    return filter(filtArr,defVal,pos+1) # Recurse
}

function ones_gt_zeros(inputArr,pos) { # Count the 1s versus 0s in the current position
    ones=0;zeros=0
    for (val in inputArr) {
	split(val,input,"")
	input[pos] == 1 ? ones++ : zeros++
    }
    return ones-zeros
}

function bin_to_dec(bin) {
    total=0
    for (i=1; i<=length(bin); i++) {
	total=2*total+substr(bin,i,1)
    }
    return total
}

BEGIN {PROCINFO["sorted_in"]="@ind_num_asc"}

$1 ~ /[01]+/ {
    oxyArr[$1]=""
    co2Arr[$1]=""
}

END {
    oxyRat=filter(oxyArr,1,1) # Pass 1 as default value
    co2Rat=filter(co2Arr,0,1)
    print bin_to_dec(oxyRat)*bin_to_dec(co2Rat)
}
