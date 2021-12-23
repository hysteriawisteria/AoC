# Advent of Code 2021, day 3 part 1
## Author: Chris Menard

$1 ~ /[01]+/ {
    split($1,input,"");
    for (i=1;i<=length($1);i++) {substr($1,i,1) == 1 ? ones[i]++ : zeros[i]++;}
}

END {
    arr_size=length(ones)
    for (i=1;i<=arr_size;i++p) {
	if (ones[i] > zeros[i]) {
	    gam=2*gam+1;
	    eps=2*eps;
	}
	else {
	    gam=2*gam;
	    eps=2*eps+1
	}
    }
    print gam*eps
}
