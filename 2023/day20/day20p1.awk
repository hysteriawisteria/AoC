# Advent of Code 2023 day 20 part 1 in awk
## Author: Chris Menard


# map[module] = destination module 1, [destination module2, ...]
# types[module] = type (% or &)
# states[module] denotes module state
#      - for a flip/flop module this is off/on
#      - for a conjunction module, this is a comma separated
#	  list of input modules and remembered pulses. E.g:
#               "a low,b high,c low"

function button(     idx,     max,     queue,     connections,     i,     entry,    state,     input) {
    low++

    idx = 1
    max = 1
    queue[idx] = "broadcaster low button"

    while (length(queue) > 0) {
	
	# entry[1] = current module, entry[2] = pulse type, entry[3] = input module
	split(queue[idx],entry," ")
	split(map[entry[1]],connections,",")

	delete queue[idx]
	idx++

	# broadcast module
	if (entry[1] == "broadcaster") {
	    pulse = entry[2]
	    
	    # flip-flop module	    
	} else if (types[entry[1]] == "%") {
	    
	    if (entry[2] == "high") {
		continue
	    }

	    state = states[entry[1]]
	    if (state == "off") {
		states[entry[1]] = "on"
		pulse = "high"
	    } else {
		states[entry[1]] = "off"
		pulse = "low"
	    }

	    # conjunction module
	} else if (types[entry[1]] == "&") {

	    split(states[entry[1]],input,",")
            for (i=1; i<=length(input)-1; i++) {
		
                module = substr(input[i],1,index(input[i]," ")-1)
		
                if (module == entry[3]) {
		    input[i] = entry[3] " " entry[2]
		    break
		}
	    }

	    delete states[entry[1]]
	    for (i=1; i<=length(input); i++) {
		states[entry[1]] = input[i] "," states[entry[1]]
	    }

	    pulse = states[entry[1]] ~ "low" ? "high" : "low"

	    # output module
	} else {
	    continue
	}

	# Done process modules, now "send" signals by adding entries to the queue
	for (i=1; i<=length(connections); i++) {
	    max++
	    queue[max] = connections[i] " " pulse " " entry[1]

#	    printf "%s -%s-> %s\n",entry[1],pulse,connections[i]
	}

	if (pulse == "low") {
	    low += length(connections)
	} else {
	    high += length(connections)
	}
    }
}

# set initial states
function populate_states(     idx,     i,     connections) {
    for (idx in map) {
	split(map[idx],connections,",")

	for (i=1; i<=length(connections); i++) {
	    
	    if (types[connections[i]] == "%") {
		states[connections[i]] = "off"
	    } else if (types[connections[i]] == "&") {
		if (states[connections[i]] !~ idx) {
		    states[connections[i]] = idx " low," states[connections[i]]
                }
            }
        }
    }
}
        

/->/ {
    if ($1 == "broadcaster") {
	module = "broadcaster"
    } else {
	module = substr($1,2)
	types[module] = substr($1,1,1)
    }
    for (i=3; i<=NF; i++) {
	map[module] = map[module] $i
    }
}

END {

    populate_states()
    
    low = 0
    high = 0
    for (i=1; i<=1000; i++) {
	button()
    }

    print low*high
}
