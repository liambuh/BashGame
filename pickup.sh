# handlepickup pickup_char
# ret: N/A
handlepickup() {
    if [ $1 = 'j' ]; then
        # jump function
        handlejump
    fi
}

# handlejump
# ret: N/A
handlejump() {
    # plan: move player 4 tiles in their given direction.
    #       if the move is invalid, then go an extra space.
    #       make sure to remove the powerup BEFORE processing to avoid infinite loops
    setchar $PLAYER_X $PLAYER_Y '.'
    x=0
    y=0
    if [ $PLAYER_DIR = "up" ]; then
        y=-1
    elif [ $PLAYER_DIR = "right" ]; then
        x=1
    elif [ $PLAYER_DIR = "left" ]; then
        x=-1
    elif [ $PLAYER_DIR = "down" ]; then
        y=1
    fi

    jdist=3

    vjump=0
    i=0
    while [ $vjump=0 ]; do
        i=$(($i+1))
        jx=$(($x*$jdist*i)+$PLAYER_X)
        jy=$(($y*$jdist*i)+$PLAYER_Y)

        collision jx jy
        if [ $FOUNDBLOCK = 0 ]; then
            if [ $FOUNDHIT = 0 ]; then
                vjump=1
            fi
        fi

        if [ $vjump=1 ]; then
            getswordpos $jx $jy $PLAYER_DIR
            collision $tsx $tsy
            if [ $FOUNDBLOCK = 1 ]; then
                vjump=0
            fi
        fi
    done

    if [ $vjump=1 ]; then
        PLAYER_X=$jx
        PLAYER_Y=$jy
        updateswordpos
    fi
}