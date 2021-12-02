$0 ~ /[0-9]+/ {if (prev>0 && $1>prev) total=total+1} # Don't increment on the first line, only process lines with numbers
{prev=$1}
END {print total}
