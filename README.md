# NineMenMorris-MiniMax

Welcome to our school project! Play Nine-Men-Morris against our GOFAI.

## How To Start

### Play From Scratch

**1** You will need MATLAB 2020 to run the .m file.

**3** Open the file "muehleController5.m" under "Controllers" and run it inside MATLAB 2020.

### Play Userdefined Board

**4** "muehleController5" can be run via the commandline in MATLAB with the following arguments:
```
muehleController5(board, startingPlayer, phase, stonesBeginningPhase)
```

* board:                    Nine-Men-Morris board (3x3x3 matrix) with numbers 1: player, -1: AI and 0: empty
* startingPlayer:           Player to start the game
* phase(1):                 Phase of Player 1
* phase(2):                 Phase of Player 2
* stonesBeginningPhase:     How many stones there are in total left *TO LAY DOWN* in the beginning (only phase 1)

## Credits

Made with <3 by Luca and Gianluca (BE3dARt)