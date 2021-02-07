%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is called when an object is clicked
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function clickedCallback(obj,evt)

    %Get muehleFigure
    muehleFigure = findobj('Name','Muehle');
    
    %Phase 2&3 need two clicks
    muehleFigure.UserData.click = muehleFigure.UserData.click + 1;
    
    continueAllowed = 0;
    
    if muehleFigure.UserData.phase(1) == 1 && muehleFigure.UserData.mode == "move"
        muehleFigure.UserData.moveTo = obj.UserData(1);
        continueAllowed = 1;
        
    elseif muehleFigure.UserData.mode == "remove"
        
        %Transfer index to muehleFigure
        muehleFigure.UserData.index = obj.UserData(1);
        muehleFigure.UserData.board(muehleFigure.UserData.index) = 0;
        uiresume(muehleFigure);
        
    elseif muehleFigure.UserData.phase(1) >= 2
        if muehleFigure.UserData.click == 1 && obj.UserData(2) == 1
            muehleFigure.UserData.moveFrom = obj.UserData(1);
            continueAllowed = 1;
        elseif muehleFigure.UserData.click == 2 && obj.UserData(2) == 0
            %Delete old tag
            delete(findobj('Position',[matrixToPosition(muehleFigure.UserData.moveFrom, 1, "rectangle") matrixToPosition(muehleFigure.UserData.moveFrom, 2, "rectangle") 0.5 0.5],'Tag','clickable'));
            muehleFigure.UserData.board(muehleFigure.UserData.moveFrom) = 0;
            muehleFigure.UserData.moveTo = obj.UserData(1); 
            continueAllowed = 1;
        end
    end
    
    if continueAllowed == 1
        %Transfer index to muehleFigure
        muehleFigure.UserData.index = obj.UserData(1);

        %Delete old stone
        delete(findobj('Position',[matrixToPosition(muehleFigure.UserData.index, 1, "rectangle") matrixToPosition(muehleFigure.UserData.index, 2, "rectangle") 0.5 0.5],'Tag','clickable'));

        %Set new, highlighted, stone
        rectangle('Position',[matrixToPosition(muehleFigure.UserData.index, 1, "rectangle") matrixToPosition(muehleFigure.UserData.index, 2, "rectangle") 0.5 0.5],'FaceColor',[0.5 0.25 1 1],'Clipping','off','UserData',muehleFigure.UserData.index);

        %Show possible moves in phases 2&3
        if muehleFigure.UserData.phase(1) == 2 || muehleFigure.UserData.phase(1) == 3

            displayText("Chose where to put it", [0 0 0], 0.07);
            
            possibilities(muehleFigure, muehleFigure.UserData.index, "move")
        end

        if muehleFigure.UserData.phase(1) == 1 || (muehleFigure.UserData.phase(1) > 1 && muehleFigure.UserData.click == 2)
            
            uiresume(muehleFigure);
            muehleFigure.UserData.board(muehleFigure.UserData.index) = muehleFigure.UserData.playerType;
        end
    else
        muehleFigure.UserData.click = muehleFigure.UserData.click - 1;
    end
end
