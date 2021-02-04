%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display possible moves & removes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function possibilities(muehleFigure, index, mode)

A = [1 2 3 4 6 7 8 9 10 11 12 13 15 16 17 18 19 20 21 22 24 25 26 27];
B = [NaN];

for i=A
    %Get all valid moves
    if mode == "move"
        if (isValidMove(muehleFigure.UserData.board, index, i, muehleFigure.UserData.playerType , muehleFigure.UserData.phase(1), muehleFigure.UserData.phase(2))) == 1
            B(end+1) = i;
        end
    %Get all valid removes
    elseif mode == "remove"
        if (validRemove(muehleFigure.UserData.board,muehleFigure.UserData.playerType, i)) == 1
            B(end+1) = i;
        end    
    end
end

%Draw all the valid moves
B(1) = [];

if ~isempty(B)
    
    for i=B   
        
    if mode == "move"
        color = [0 1 0 0.5];
    else
        color = [1 1 1 0.5];
    end

    %'UserData, i = index, 0: possible moves, -1: black, 1: white
    rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData', [i 0],'Tag','clickable','ButtonDownFcn',@clickedCallback);   

    end
end
end