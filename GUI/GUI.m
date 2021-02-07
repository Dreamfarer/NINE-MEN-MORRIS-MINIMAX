function [newboard, moveTo] = GUI(board, playerType, phase, mode, moves)

%Input Arguments:
%board: Current Nine-Men-Morris board
%playerType: The player that currently playing
%phase [Phase of Player 1, Phase of Player 2]

%Find existing figure
muehleFigure = findobj('Name','Muehle');

%If not defined yet, define a new figure
if isempty(muehleFigure)
    muehleFigure = figure('Name','Muehle');
    axis off; axis square,  
    xlim([0 6]); 
    ylim([0 6]);
    set(gcf, 'Position',  [100, 100, 700, 800])
    set(gca, 'ylim', get(gca, 'ylim')-0.5)
end

%Initialize UserData for later use
muehleFigure.UserData.board = board;
muehleFigure.UserData.playerType = playerType;
muehleFigure.UserData.phase = phase; % [Phase of Player 1, Phase of Player 2]
muehleFigure.UserData.click = 0;
muehleFigure.UserData.moveFrom = 0;
muehleFigure.UserData.moveTo = 0;
muehleFigure.UserData.mode = mode;
muehleFigure.UserData.index = 0;
muehleFigure.UserData.AI = [moves(1) moves(2) moves(3)];

%Draw board and handle input
updateBoard(muehleFigure);

if mode ~= "GameOver" && mode ~= "waitForAI"
    
    %Wait for 'uiresume' to be called, to continue
    if abs(playerType)==1
        uiwait(muehleFigure); 
    end    
end

%Return Values
newboard = muehleFigure.UserData.board;
moveTo = muehleFigure.UserData.moveTo;

end