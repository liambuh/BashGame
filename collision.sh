FOUNDBLOCK=0
FOUNDHIT=0

# collision x y
# ret: FOUNDBLOCK, FOUNDHIT
collision() {
    FOUNDBLOCK=0
    FOUNDHIT=0

    getchar "$1" "$2"

    if [ "$GRIDCHAR" = "#" ]; then
        FOUNDBLOCK=1
    fi
}