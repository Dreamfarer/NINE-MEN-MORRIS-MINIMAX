%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-Input-
%board:             Current Nine-Men-Morris board
%playerType:        The player that currently playing
%phase(1):          Phase of Player 1 
%phase(2):          Phase of Player 2
%mode("move"):      If GUI is used to move/place stones
%mode("remove"):    If GUI is used to remove stones
%mode("GameOver"):    If GUI is used to end the game
%mode("waitForAI"):   If GUI is used to display activities of AI
%AImoves(1):        AI move FROM where
%AImoves(2):        AI move TO where
%AImoves(3):        Recently removed stone by AI
%
%-Output-
%newboard:          With user input updated board
%moveTo:            Where user has moved

function [newboard, moveTo] = GUI(board, playerType, phase, mode, AImoves)

    %Find existing figure
    muehleFigure = findobj('Name','Muehle');

    %If not defined yet, define a new figure
    if isempty(muehleFigure)
        muehleFigure = figure('Name','Muehle');
        axis off; axis square,  
        xlim([0 6]); 
        ylim([0 6]);
        set(gcf, 'Position',  [100, 100, 700, 800]) %Window size
        set(gca, 'ylim', get(gca, 'ylim')-0.5) %Content alignement within window
    end

    %Initialize and fill in 'UserData' for later use
    muehleFigure.UserData.board = board;
    muehleFigure.UserData.playerType = playerType;
    muehleFigure.UserData.phase = phase;
    muehleFigure.UserData.click = 0;
    muehleFigure.UserData.moveFrom = 0;
    muehleFigure.UserData.moveTo = 0;
    muehleFigure.UserData.mode = mode;
    muehleFigure.UserData.index = 0;
    muehleFigure.UserData.AI = [AImoves(1) AImoves(2) AImoves(3)];

    %Draw board and handle input
    if updateBoard(muehleFigure) == true
        uiwait(muehleFigure);
    end

    %Return Values
    newboard = muehleFigure.UserData.board;
    moveTo = muehleFigure.UserData.moveTo;

end