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
	pickup=$((0))
    pposchar='.'
    sposchar='.'

	# player collision
	collision $px $py
	if [ $FOUNDBLOCK = 1 ]; then
		pvalid=0
	fi
	if [ $FOUNDITEM = 1 ]; then
        pickup=1
    fi
    pposchar=$GRIDCHAR

	# sword collision
	getswordpos $px $py $pd
	collision $TSX $TSY
	if [ $FOUNDBLOCK = 1 ]; then
		svalid=0
	fi
	sposchar=$GRIDCHAR

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

    # process pickup logic
    if [ $pickup = 1]; then
        handlepickup $pposchar
    fi
	
    # process sword logic
}