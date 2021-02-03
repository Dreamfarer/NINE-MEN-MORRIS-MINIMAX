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

%Store input data
h.UserData.b = board;
h.UserData.p = playerType;
h.UserData.ph1 = phase1;
h.UserData.ph2 = phase2;
h.UserData.click = 0;

h.UserData.moveFrom = 0;
h.UserData.moveTo = 0;

%First Click: Choose which to move
%(Show in color which stone was selected)
updateBoard(h);
if abs(playerType)==1
    uiwait(h); 
end

newboard = h.UserData.b;

if phase1 >= 2 
    moveTo = h.UserData.moveTo;
else
    moveTo = h.UserData.moveFrom;
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update board with matrix of Luca
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function updateBoard(h)

    delete(findobj(gca,'Type','rectangle')); %alte Einträge löschen
    
    %Draw background
    drawBoard();

    board = h.UserData.b;
    color = [0 0 0 0.5];
    
    %Draw the actual playstate!
    for i = 1:27
        
        %White
        if isnan(matrixToPosition(i,1)) == false && isnan(matrixToPosition(i,2)) == false && board(i) == 1
            
            color = [1 1 1];
            if h.UserData.ph1 == 1
                rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',i);   
            else
               rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',i,'Tag','clickable','ButtonDownFcn',@clickedCallback);    
            end
            
        %Black
        elseif isnan(matrixToPosition(i,1)) == false && isnan(matrixToPosition(i,2)) == false && board(i) == (-1)
            color = [0 0 0];
            rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',i);   
        end  
    end
    
    %Show possible moves for phase 1 (Phase 2&3 must wait for a first click)
    if h.UserData.ph1 == 1
        possibleMoves(h, 0)
    end
    
    drawnow 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display possible moves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function possibleMoves(h, index)

A = [1 2 3 4 6 7 8 9 10 11 12 13 15 16 17 18 19 20 21 22 24 25 26 27];
B = [NaN];

%Get all valid moves
for i=A
    if (isValidMove(h.UserData.b, index, i, h.UserData.p , h.UserData.ph1, h.UserData.ph2)) == 1
        B(end+1) = i;
    end
end

%Draw all the valid moves
B(1) = [];
for i=B   
    color = [0 1 0 0.5];
    rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',i,'Tag','clickable','ButtonDownFcn',@clickedCallback);   
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matrix Luca to 7x7 Display-Matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function position = matrixToPosition(x,y)

A = [0 6; 0 3; 0 0; 3 6; NaN NaN; 3 0; 6 6; 6 3; 6 0; 1 5; 1 3; 1 1; 3 5; NaN NaN; 3 1; 5 5; 5 3; 5 1; 2 4; 2 3; 2 2; 3 4; NaN NaN; 3 2; 4 4; 4 3; 4 2;];
position = A(x,y)-0.25;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw background, the actual 'Mühle'-board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function drawBoard()
    lineWidth = 5;
    
    rectangle('Position',[0 0 6 6],'LineWidth',lineWidth,'Clipping','off','FaceColor',[1 1 1]) % outside border
    line([0 6],[3 3],'Color','black','Clipping', 'off', 'LineWidth',lineWidth)
    line([3 3],[0 6],'Color','black','Clipping', 'off', 'LineWidth',lineWidth)
    rectangle('Position',[1 1 4 4],'LineWidth',lineWidth,'Clipping','off','FaceColor',[0 0 0 0]) % outside border 
    rectangle('Position',[2 2 2 2],'LineWidth',lineWidth,'Clipping','off','FaceColor',[1 1 1 1]) % outside border

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is called when an object is clicked
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function clickedCallback(obj,evt)
    
    %Get h
    h = findobj('Name','Muehle');
    
    %Transfer index to h
    h.UserData.m = obj.UserData;
    
    %Phase 2&3 need to clicks
    h.UserData.click = h.UserData.click + 1;
    
    if h.UserData.click == 1
        h.UserData.moveFrom = h.UserData.m;
    elseif h.UserData.click == 2
        %Delete old tag
        delete(findobj('Position',[matrixToPosition(h.UserData.moveFrom,1) matrixToPosition(h.UserData.moveFrom,2) 0.5 0.5],'Tag','clickable'));
        h.UserData.b(h.UserData.moveFrom) = 0;
        
        h.UserData.moveTo = h.UserData.m;
        
    end
    
    %Delete old stone
    delete(findobj('Position',[matrixToPosition(h.UserData.m,1) matrixToPosition(h.UserData.m,2) 0.5 0.5],'Tag','clickable'));
    
    %Set new, highlighted, stone
    rectangle('Position',[matrixToPosition(h.UserData.m,1) matrixToPosition(h.UserData.m,2) 0.5 0.5],'FaceColor',[0.5 0.25 1 1],'Clipping','off','UserData',h.UserData.m);
    
    %Show possible moves in phases 2&3
    if h.UserData.ph1 == 2 || h.UserData.ph1 == 3
        possibleMoves(h, h.UserData.m)
    end
    
    if h.UserData.ph1 == 1 || (h.UserData.ph1 == 2 && h.UserData.click == 2)
        uiresume(h);
        h.UserData.b(h.UserData.m) = h.UserData.p;
    end
end
