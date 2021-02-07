%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display possible moves & removes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function possible = possibilities(muehleFigure, index, mode)

A = [1 2 3 4 6 7 8 9 10 11 12 13 15 16 17 18 19 20 21 22 24 25 26 27];
possible = [NaN];

for i=A
    %Get all valid moves
    if mode == "move"
        if (isValidMove(muehleFigure.UserData.board, index, i, muehleFigure.UserData.playerType , muehleFigure.UserData.phase(1), muehleFigure.UserData.phase(2))) == 1
            possible(end+1) = i;
        end
    %Get all valid removes
    elseif mode == "remove"
        if (validRemove(muehleFigure.UserData.board,muehleFigure.UserData.playerType, i)) == 1
            possible(end+1) = i;
        end    
    end
end

%Draw all the valid moves
possible(1) = [];

if ~isempty(possible)
    
    for i=possible   
        
    if mode == "move"
        color = [0 1 0 0.5];
    else
        color = [1 1 0 0.5];
    end

    %'UserData, i = index, 0: possible moves, -1: black, 1: white
    rectangle('Position',[matrixToPosition(i, 1, "rectangle") matrixToPosition(i, 2, "rectangle") 0.5 0.5],'FaceColor',color,'Clipping','off','UserData', [i 0],'Tag','clickable','ButtonDownFcn',@clickedCallback);   
    
    end
else
    possible = NaN;
end
    
end