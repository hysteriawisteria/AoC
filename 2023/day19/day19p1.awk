# Advent of Code 2023 day 19 part 1 in awk
## Author: Chris Menard
BEGIN {
    rules[1] = ""
}

function process(     i,     rule,    op,    val,     cat) {
    status = "in"

    while (status != "A" && status != "R") {
	split(workflows[status],rules,",")

        for (i=1; i<=length(rules)-1; i++) {
	    status = rules[length(rules)]
	    cat = substr(rules[i],1,1)
	    op  = substr(rules[i],2,1)
	    val = substr(rules[i],3,index(rules[i],":")-3)+0

	    if ((op=="<" && vals[cat]<val) || (op==">" && vals[cat]>val)) {
		status = substr(rules[i],index(rules[i],":")+1)
		break
	    }
	}
    }

    if (status == "A") {
	return 1
    } else if (status == "R") {
	return 0
    } else {
	print "ERROR", status
    }
}

/^[a-z]/ {
    workflows[substr($1,1,index($1,"{")-1)] = substr($1,index($1,"{")+1,index($1,"}")-index($1,"{")-1)
}

/^\{/ {
    vals["x"] = substr($1,index($1,"x")+2,index($1,"m")-index($1,"x")-3) + 0
    vals["m"] = substr($1,index($1,"m")+2,index($1,"a")-index($1,"m")-3) + 0
    vals["a"] = substr($1,index($1,"a")+2,index($1,"s")-index($1,"a")-3) + 0
    vals["s"] = substr($1,index($1,"s")+2,index($1,"}")-index($1,"s")-2) + 0

    if(process(x,m,a,s)) {
	tot = tot + vals["x"] + vals["m"] + vals["a"] +vals["s"]
    }
}

END {
    print tot
}
