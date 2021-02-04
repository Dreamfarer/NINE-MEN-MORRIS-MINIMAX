function [newboard, moveTo] = GUI(board, playerType, phase, mode)

%Find existing figure
muehleFigure = findobj('Name','Muehle');

%If not defined yet, define a new figure
if isempty(muehleFigure)
    muehleFigure = figure('Name','Muehle');
    axis off; axis square,  
    xlim([0 6]); 
    ylim([0 6]);    
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

%Draw board and handle input
updateBoard(muehleFigure);

%Wait for 'uiresume' to be called, to continue
if abs(playerType)==1
    uiwait(muehleFigure); 
end

%Return Values
newboard = muehleFigure.UserData.board;
moveTo = muehleFigure.UserData.moveTo;

end