PLAYER_X=10
PLAYER_Y=10
PLAYER_DIR="up"
SWORD_DIR="up"

SX=0
SY=0
SCHAR=""

TSX=0
TSY=0
TSD=""

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
	SCHAR=$3
}