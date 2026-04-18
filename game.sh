#!/bin/bash

GRID=("" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "")
GRID_W=20
GRID_H=20

PLAYER_X=10
PLAYER_Y=10
PLAYER_DIR="up"
SWORD_DIR="up"

SX=0
SY=0
SCHAR=""

EXIT_FLAG=0
MODRES=0
GRIDCHAR=' '
FOUNDBLOCK=0
FOUNDHIT=0

TSX=0
TSY=0
TSD=""

pvalid=0
svalid=0
valid=0

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

# process input
# ret: N/A
process() {
	# echo "read $1"
	px=$PLAYER_X
	py=$PLAYER_Y
	pd=$PLAYER_DIR
	sc=$SCHAR
	
	start_px=$px
	start_py=$py
	start_pd=$pd
	start_sc=$sc
	
	if [ $1 = "q" ]; then
		EXIT_FLAG=1
	elif [ $1 = "h" ]; then
		px=$(($px-1))
		pd="left"
		sc="<"
	elif [ $1 = "l" ]; then
		px=$(($px+1))
		pd="right"
		sc=">"
	elif [ $1 = "j" ]; then
		py=$(($py+1))
		pd="down"
		sc="V"
	elif [ $1 = "k" ]; then
		py=$(($py-1))
		pd="up"
		sc="^"
	fi
	
	modval $py $GRID_H
	py=$MODRES
	modval $px $GRID_W
	px=$MODRES
	
	pvalid=$((1))
	svalid=$((1))
	valid=$((1))
	
	# player collision
	collision $px $py
	if [ $FOUNDBLOCK = 1 ]; then
		pvalid=0
	fi
	
	# sword collision
	getswordpos $px $py $pd
	collision $TSX $TSY
	if [ $FOUNDBLOCK = 1 ]; then
		svalid=0
	fi
	
	# combine valids
	if [ $pvalid = 0 ]; then
		valid=0
	fi
	if [ $svalid = 0 ]; then
		valid=0
	fi
	
	if [ $valid = 1 ]; then
		PLAYER_X=$px
		PLAYER_Y=$py
		PLAYER_DIR=$pd
		SWORD_DIR=$PLAYER_DIR
		updateswordpos $TSX $TSY $sc
	else
		PLAYER_X=$start_px
		PLAYER_Y=$start_py
		PLAYER_DIR=$start_pd
	fi
	
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

# collision x y
# ret: FOUNDBLOCK, FOUNDHIT
collision() {
	FOUDBLOCK=0
	FOUNDHIT=0
	getchar $1 $2
	if [ $GRIDCHAR = '#' ]; then
		FOUNDBLOCK=1
	fi
}

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

# getswordpos px py pd
# ret: TSX TSY TSD
getswordpos() {
	tsx=$1
	tsy=$2
	tsd=$3
	
	if [ $tsd = "up" ]; then
		tsy=$(($tsy-1))
	elif [ $tsd = "down" ]; then
		tsy=$(($tsy+1))
	elif [ $tsd = "left" ]; then
		tsx=$(($tsx-1))
	elif [ $tsd = "right" ]; then
		tsx=$(($tsx+1))
	fi
	
	# mod sword coords
	modval $tsy $GRID_H
	tsy=$MODRES
	modval $tsx $GRID_W
	tsx=$MODRES
	
	TSX=$tsx
	TSY=$tsy
	TSD=$tsd
}

# updateswordpos sx sy sc
# ret: SX, SY, SCHAR
updateswordpos() {
	SX=$1
	SY=$2
	SCHAR=$sc
}

# modval val base
# ret: MODRES
modval() {
	val=$(($1 % $2))
	if [ $val -lt 0 ]; then
		val=$(($2 + $val))
	fi
	MODRES=$val
}

game
