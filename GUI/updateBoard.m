%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update board with matrix of Luca
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function updateBoard(muehleFigure)
    
    %Delete old entries
    delete(findobj(gca,'Type','rectangle'));
    
    %Draw background
    drawBoard();
    
    %Draw the actual playstate!
    for i = 1:27
        
        %White
        if isnan(matrixToPosition(i,1)) == false && isnan(matrixToPosition(i,2)) == false && muehleFigure.UserData.board(i) == 1
            color = [1 1 1];
            if muehleFigure.UserData.phase(1) == 1 || muehleFigure.UserData.mode == "remove"
                rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData', [i 1]);   
            else
               rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',[i 1],'Tag','clickable','ButtonDownFcn',@clickedCallback);    
            end
            
        %Black
        elseif isnan(matrixToPosition(i,1)) == false && isnan(matrixToPosition(i,2)) == false && muehleFigure.UserData.board(i) == (-1)
            color = [0 0 0];
            rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',[i -1]);   
        end  
    end
    
    %Show possible moves for phase 1 (Phase 2&3 must wait for a first click)
    if muehleFigure.UserData.phase(1) == 1 && muehleFigure.UserData.mode == "move"
        possibilities(muehleFigure, 0, "move")
    elseif muehleFigure.UserData.mode == "remove"
        possibilities(muehleFigure, muehleFigure.UserData.index, "remove")
    end 
    
    drawnow 
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