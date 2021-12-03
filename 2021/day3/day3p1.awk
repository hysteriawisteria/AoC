# Advent of Code 2021, day 3 part 1
## Author: Chris Menard
## IMPORTANT: run with a GNU compliant awk

BEGIN {PROCINFO["sorted_in"]="@ind_num_asc"}

$1 ~ /[01]+/ {
        split($1,input,"");
        for (i in input) {input[i] == 1 ? ones[i]++ : zeros[i]++;}
}

END {
        for (i in ones) {
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
