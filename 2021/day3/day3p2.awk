BEGIN {PROCINFO["sorted_in"]="@ind_num_asc"}

function filter(filtArr,arr1,arr2,pos) {
        len=length(filtArr)
        if (len==1) {for (i in filtArr) return i}

        if (arr1[pos] > arr2[pos]) val=0
        else val=1
        for (i in filtArr) {
                if (substr(i,pos,1) != val) {delete filtArr[i]; printf "Deleted: %s ",i}
                printf "val: %s entry: %s\n",val,i
        }
        filter(filtArr,arr1,arr2,pos+1)
}

$1 ~ /[01]+/ {
        split($1,input,"");
        for (i in input) {input[i] == 1 ? ones[i]++ : zeros[i]++}
        oxyArr[$1]=""
        co2Arr[$1]=""
}

END {
        oxyRat=filter(oxyArr,zeros,ones,1)
#       co2Rat=filter(co2Arr,ones,zeros,1)
        print oxyRat
        print co2Rat
        print oxyRat*co2Rat
}
