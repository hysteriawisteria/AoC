BEGIN {l=14} {for (i=1;i<=length($0);i++) {c[i%l]=substr($0,i,1); for (j in c) a[c[j]]++ ; if (length(a)==l) {print i; exit}; delete a}}
