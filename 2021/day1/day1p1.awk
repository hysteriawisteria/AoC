NR>1 && $1>prev {total=total+1} # Don't increment on the first line
{prev=$1}
END {print total}
