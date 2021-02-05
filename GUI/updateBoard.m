%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update board with matrix of Luca
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function updateBoard(muehleFigure)
    
    %Delete old entries
    delete(findobj(gca,'Type','rectangle'));
    delete(findobj(gca,'Type','text'));
    
    %Draw background
    drawBoard();
    
    %Draw the current Nine-Men-Morris board
    for i = 1:27
        
        if isnan(matrixToPosition(i,1)) == false && isnan(matrixToPosition(i,2)) == false && muehleFigure.UserData.board(i) ~= 0
            
            %Decide which color to draw
            if muehleFigure.UserData.board(i) == 1
                color = [1 1 1];
            elseif muehleFigure.UserData.board(i) == -1
                color = [0 0 0];
            end
            
            %Decide if a callback should be added
            if muehleFigure.UserData.phase(1) >= 1 && muehleFigure.UserData.board(i) == 1
                rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',[i muehleFigure.UserData.board(i)],'Tag','clickable','ButtonDownFcn',@clickedCallback);
            else
                rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',[i muehleFigure.UserData.board(i)]);
            end
            
        end  
    end
    
    %Show possible moves for phase 1
    if muehleFigure.UserData.phase(1) == 1 && muehleFigure.UserData.mode == "move"
        text(0.25,-1,"Place a stone",'FontUnits','normalized','FontSize',0.07,'HorizontalAlignment','left');
        possibilities(muehleFigure, 0, "move")
        
    elseif muehleFigure.UserData.phase(1) > 1 && muehleFigure.UserData.mode == "move"
        
        text(0.25,-1,"Chose a stone to move",'FontUnits','normalized','FontSize',0.07,'HorizontalAlignment','left');
        
    %Show possible stones to remove if a 'muehle' has been made    
    elseif muehleFigure.UserData.mode == "remove"
        text(0.25,-1,"Remove a stone",'FontUnits','normalized','FontSize',0.07,'HorizontalAlignment','left');
        possibilities(muehleFigure, muehleFigure.UserData.index, "remove")
    end 
    
    %Update figures and process callbacks
    drawnow 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display AI moves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function showAIMoves()

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw background, the actual Nine-Men-Morris board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function drawBoard()
    lineWidth = 5;
    
    rectangle('Position',[0 0 6 6],'LineWidth',lineWidth,'Clipping','off','FaceColor',[1 1 1])
    line([0 6],[3 3],'Color','black','Clipping', 'off', 'LineWidth',lineWidth)
    line([3 3],[0 6],'Color','black','Clipping', 'off', 'LineWidth',lineWidth)
    rectangle('Position',[1 1 4 4],'LineWidth',lineWidth,'Clipping','off','FaceColor',[0 0 0 0])
    rectangle('Position',[2 2 2 2],'LineWidth',lineWidth,'Clipping','off','FaceColor',[1 1 1 1])
    
    rectangle('Position',[0 -1.5 6 1],'LineWidth',lineWidth,'Clipping','off','FaceColor',[1 1 1 1])

end