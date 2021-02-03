%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is called when an object is clicked
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function clickedCallback(obj,evt)

    %Get h
    h = findobj('Name','Muehle');
    
    %Phase 2&3 need two clicks
    h.UserData.click = h.UserData.click + 1;
    
    continueAllowed = 0;
    
    if h.UserData.ph1 == 1
        h.UserData.moveTo = obj.UserData(1);
        continueAllowed = 1;
    elseif h.UserData.ph1 >= 2
        if h.UserData.click == 1 && obj.UserData(2) == 1
            h.UserData.moveFrom = obj.UserData(1);
            continueAllowed = 1;
        elseif h.UserData.click == 2 && obj.UserData(2) == 0
            %Delete old tag
            delete(findobj('Position',[matrixToPosition(h.UserData.moveFrom,1) matrixToPosition(h.UserData.moveFrom,2) 0.5 0.5],'Tag','clickable'));
            h.UserData.b(h.UserData.moveFrom) = 0;
            h.UserData.moveTo = obj.UserData(1); 
            continueAllowed = 1;
        end
    end
    
    if continueAllowed == 1
        %Transfer index to h
        h.UserData.m = obj.UserData(1);

        %Delete old stone
        delete(findobj('Position',[matrixToPosition(h.UserData.m,1) matrixToPosition(h.UserData.m,2) 0.5 0.5],'Tag','clickable'));

        %Set new, highlighted, stone
        rectangle('Position',[matrixToPosition(h.UserData.m,1) matrixToPosition(h.UserData.m,2) 0.5 0.5],'FaceColor',[0.5 0.25 1 1],'Clipping','off','UserData',h.UserData.m);

        %Show possible moves in phases 2&3
        if h.UserData.ph1 == 2 || h.UserData.ph1 == 3
            possibilities(h, h.UserData.m, "move")
        end

        if h.UserData.ph1 == 1 || (h.UserData.ph1 == 2 && h.UserData.click == 2)
            uiresume(h);
            h.UserData.b(h.UserData.m) = h.UserData.p;
        end
    else
        h.UserData.click = h.UserData.click - 1;
    end
end
