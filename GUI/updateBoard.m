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
        
        if isnan(matrixToPosition(i, 1, "rectangle")) == false && isnan(matrixToPosition(i, 2, "rectangle")) == false && muehleFigure.UserData.board(i) ~= 0
            
            %Decide which color to draw the rectangles on the board
            if muehleFigure.UserData.board(i) == 1
                color = [1 1 1]; %White
            elseif muehleFigure.UserData.board(i) == -1
                color = [0 0 0]; %Black
            end
            
            %Decide if a callback should be added
            if muehleFigure.UserData.phase(1) >= 1 && muehleFigure.UserData.board(i) == 1 && muehleFigure.UserData.mode == "move"
                rectangle('Position',[matrixToPosition(i, 1, "rectangle") matrixToPosition(i, 2, "rectangle") 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',[i muehleFigure.UserData.board(i)],'Tag','clickable','ButtonDownFcn',@clickedCallback);
            else
                rectangle('Position',[matrixToPosition(i, 1, "rectangle") matrixToPosition(i, 2, "rectangle") 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',[i muehleFigure.UserData.board(i)]);
            end
            
        end  
    end
    
    %Show possible moves for phase 1
    if muehleFigure.UserData.phase(1) == 1 && muehleFigure.UserData.mode == "move"
        displayText("Place a stone", [0 0 0], 0.07);
        possibilities(muehleFigure, 0, "move")
        
    elseif muehleFigure.UserData.phase(1) > 1 && muehleFigure.UserData.mode == "move"
        displayText("Chose a stone to move", [0 0 0], 0.07);
        
    %Show possible stones to remove if a 'muehle' has been made    
    elseif muehleFigure.UserData.mode == "remove" 
        displayText("Remove a stone", [0 0 0], 0.07);
        possibilities(muehleFigure, muehleFigure.UserData.index, "remove")
    end 
    
    %Show which move the AI has made
    if muehleFigure.UserData.mode ~= "remove" && muehleFigure.UserData.mode ~= "GameOver" && muehleFigure.UserData.mode ~= "waitForAI"
        showAIMoves(muehleFigure);
    end
    
    %Display the winner
    if muehleFigure.UserData.mode == "GameOver"
        
        if muehleFigure.UserData.playerType == 1
            message = "You have won! Congratulations";
        else
            message = "GOFAI has won. Shame on you!";
        end
        
        displayText(message, [0 0 0], 0.07);
    end
    
    if muehleFigure.UserData.mode == "waitForAI"
        displayText("AI is doing its magic ...", [1 0 0], 0.07);
    end
    
    %Update figures and process callbacks
    drawnow 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display AI moves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function showAIMoves(muehleFigure)
    
if muehleFigure.UserData.phase(1) > 1 && ~isnan(muehleFigure.UserData.AI(1)) && ~isnan(muehleFigure.UserData.AI(2))
    
    point1 = [matrixToPosition(muehleFigure.UserData.AI(1), 1, "line") matrixToPosition(muehleFigure.UserData.AI(2), 1, "line")];
    point2 = [matrixToPosition(muehleFigure.UserData.AI(1), 2, "line") matrixToPosition(muehleFigure.UserData.AI(2), 2, "line")];
    
    line(point1,point2,'Color','red','Clipping', 'off', 'LineWidth', 5)

    %annotation('arrow',[0.5 0] , [0 0.5], 'Position',[1 1 1 1], 'Color','red', 'LineWidth', 5);
end

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