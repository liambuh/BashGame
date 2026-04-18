#!/bin/bash

# DEFINING ALL GLOBALS

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

source ./game.sh
source ./utils.sh
source ./collision.sh
source ./grid.sh
source ./player.sh
source ./process.sh

# run game:

game