function [newboard, moveTo] = GUI(board,playerType, phase1, phase2)

%Find existing figure
h = findobj('Name','Muehle');

%If not defined yet, define a new figure
if isempty(h)
    h = figure('Name','Muehle');
    axis off; axis square,  
    xlim([0 6]); 
    ylim([0 6]);    
end

%Initialize UserData for later use
h.UserData.b = board;
h.UserData.p = playerType;
h.UserData.ph1 = phase1;
h.UserData.ph2 = phase2;
h.UserData.click = 0;
h.UserData.moveFrom = 0;
h.UserData.moveTo = 0;

%Draw board and handle input
updateBoard(h);

%Wait for 'uiresume' to be called, to continue
if abs(playerType)==1
    uiwait(h); 
end

%Return Values
newboard = h.UserData.b;
moveTo = h.UserData.moveTo;

end