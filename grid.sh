# getchar x y
# ret: GRIDCHAR
getchar() {
	gcline=${GRID[$2]}
	GRIDCHAR=${gcline:$1:1}
}

# setchar x y string (NOTE: only use 1 char)
# ret: N/A
setchar() {
	scline=${GRID[$2]}
	scline=${scline:0:${1}}$3${scline:$(($1+1))}
	GRID[$2]=$scline
}