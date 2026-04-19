FOUNDBLOCK=0
FOUNDHIT=0
FOUNDPLAYER=0
FOUNDEMPTY=0

# collision x y
# ret: FOUNDBLOCK, FOUNDHIT, FOUNDPLAYER, FOUNDEMPTY
collision() {
    resetcolvars

    getchar "$1" "$2"

    if [ "$GRIDCHAR" = "#" ]; then
        FOUNDBLOCK=1
    elif [ "$GRIDCHAR" = "@" ]; then
        FOUNDPLAYER=1
    elif [ "$GRIDCHAR" = "." ]; then
        FOUNDEMPTY=1
    fi
}

resetcolvars() {
    FOUNDBLOCK=0
    FOUNDHIT=0
    FOUNDPLAYER=0
    FOUNDEMPTY=0
}