BEGIN {lim=14} {for (i=1;i<=length($0);i++) {if (i>=lim) {q=1; for (j=1+i-lim;j<i;j++) {for (k=j+1;k<=i;k++) {if (substr($0,j,1)==substr($0,k,1)) q=0}}} if (q) {print i;exit}}}
