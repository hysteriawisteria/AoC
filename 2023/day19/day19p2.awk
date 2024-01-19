# Advent of Code 2023 day 19 part 1 in awk
## Author: Chris Menard
BEGIN {
    rules[1] = ""
    max = 1
}

function filter(workflow,xmin,xmax,mmin,mmax,amin,amax,smin,smax,     rules,     i,     cat,     val,     status,     tot) {

    if (workflow == "A") {
	return (xmax-xmin+1)*(mmax-mmin+1)*(amax-amin+1)*(smax-smin+1)
    } else if (workflow == "R") {
	return 0
    }
    
    split(workflows[workflow],rules,",")

    for (i=1; i<=length(rules)-1; i++) {
	cat = substr(rules[i],1,1)
	op = substr(rules[i],2,1)
	val = substr(rules[i],3,index(rules[i],":")-3)+0
	status = substr(rules[i],index(rules[i],":")+1)

	switch (cat) {
	case "x":
	    if ((op == "<" && xmax < val) || (op == ">" && xmin > val)) {
		return filter(status,xmin,xmax,mmin,mmax,amin,amax,smin,smax)
	    } else if (op == "<" && xmin < val) {
		tot += filter(status,xmin,val-1,mmin,mmax,amin,amax,smin,smax)
		xmin = val
	    } else if (op == ">" && xmax > val) {
		tot += filter(status,val+1,xmax,mmin,mmax,amin,amax,smin,smax)
		xmax = val
	    }
	    break
	case "m":
	    if ((op == "<" && mmax < val) || (op == ">" && mmin > val)) {
		return filter(status,xmin,xmax,mmin,mmax,amin,amax,smin,smax)
	    } else if (op == "<" && mmin < val) {
		tot += filter(status,xmin,xmax,mmin,val-1,amin,amax,smin,smax)
		mmin = val
	    } else if (op == ">" && mmax > val) {
		tot += filter(status,xmin,xmax,val+1,mmax,amin,amax,smin,smax)
		mmax = val
	    }
	    break
	case "a":
	    if ((op == "<" && amax < val) || (op == ">" && amin > val)) {
		return filter(status,xmin,xmax,mmin,mmax,amin,amax,smin,smax)
	    } else if (op == "<" && amin < val) {
		tot += filter(status,xmin,xmax,mmin,mmax,amin,val-1,smin,smax)
		amin = val
	    } else if (op == ">" && amax > val) {
		tot += filter(status,xmin,xmax,mmin,mmax,val+1,amax,smin,smax)
		amax = val
	    }
	    break
	case "s":
	    if ((op == "<" && smax < val) || (op == ">" && smin > val)) {
		return filter(status,xmin,xmax,mmin,mmax,amin,amax,smin,smax)
	    } else if (op == "<" && smin < val) {
		tot += filter(status,xmin,xmax,mmin,mmax,amin,amax,smin,val-1)
		smin = val
	    } else if (op == ">" && smax > val) {
		tot += filter(status,xmin,xmax,mmin,mmax,amin,amax,val+1,smax)
		smax = val
	    }
	    break
	}
    }
    status = rules[length(rules)]
    if (status == "A") {
	tot += (xmax-xmin+1)*(mmax-mmin+1)*(amax-amin+1)*(smax-smin+1)
    } else if (status != "R") {
	tot += filter(status,xmin,xmax,mmin,mmax,amin,amax,smin,smax)
    }

    return tot
}

/^[a-z]/ {
    beg = index($1,"{")
    end = index($1,"}")
    workflows[substr($1,1,beg-1)] = substr($1,beg+1,end-beg-1)
}

END {
    tot = filter("in",1,4000,1,4000,1,4000,1,4000)
    print tot
}
