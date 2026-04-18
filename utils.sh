MODRES=0

# modval val base
# ret: MODRES
modval() {
	val=$(($1 % $2))
	if [ $val -lt 0 ]; then
		val=$(($2 + $val))
	fi
	MODRES=$val
}