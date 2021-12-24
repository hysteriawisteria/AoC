# Advent of Code 2021, day 6 part 1 and 2
## Author: Chris Menard

function increment_state(fish_arr) {
    for (i=1; i<=8; i++) {
	tmp_arr[i-1]=fish_arr[i]
    }
    tmp_arr[6]+=fish_arr[0]
    tmp_arr[8]=fish_arr[0]

    for (i in tmp_arr) {
	fish_arr[i]=tmp_arr[i]
    }
}

function print_header() {
    printf "Int Tim:%6s %6s %6s %6s %6s %6s %6s %6s %6s\n", 0,1,2,3,4,5,6,7,8
}

function print_state(fish_arr,day) {
   printf "Day %2s: %6s %6s %6s %6s %6s %6s %6s %6s %6s\n", day, fish_arr[0],fish_arr[1],fish_arr[2],fish_arr[3],fish_arr[4],fish_arr[5],fish_arr[6],fish_arr[7],fish_arr[8]
}

BEGIN {RS="[,\n]"}

{fish_arr[$0]++} # Ensure fields are treated as numbers, not strings

END {
    days=256 # Change to 80 for part 1
    for (day=1; day <=days; day++) {
	increment_state(fish_arr)
    }

    total=0
    for (i in fish_arr) {
	total += fish_arr[i]
    }
    print total
}
	
	
	





