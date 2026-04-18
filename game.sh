#!/bin/bash

# game
# ret: N/A
game() {
	count=0
	init
	
	while true; do
		clear

		draw

		getchar $PLAYER_X $PLAYER_Y
		echo $GRIDCHAR
		echo [ $PLAYER_X , $PLAYER_Y ] $PLAYER_DIR
		echo [ $SX , $SY ] $SWORD_DIR
		echo p = $pvalid s = $svalid v = $valid
		read -rsn1 input

		process $input
		
		if [ $EXIT_FLAG = 1 ]; then
			break
		fi
		
	done
	
	echo "game over"

}

# init
# ret: N/A
init() {
	#put dots in grid
	y=0
	for y in $(seq 0 $(($GRID_H-1))); do
		line=""
		x=0
		for x in $(seq 0 $(($GRID_W-1))); do
			line+="."
		done
		GRID[y]=$line
	done
	
	setchar 2 2 '#'
}

# draw
# ret: N/A
draw() {
	
	y=0
	for y in $(seq 0 $(($GRID_H-1))); do
	
		line=${GRID[y]}
		
		if [ $PLAYER_Y = $y ]; then
			# replace line's x'th char with @
			line=${line:0:${PLAYER_X}}@${line:$((PLAYER_X+1))}
		fi
		
		if [ $SY = $y ]; then
			# replace line's xth char with arrow
			line=${line:0:${SX}}${SCHAR}${line:$((SX+1))}
		fi
		
		echo -e $line
	
	done
}
