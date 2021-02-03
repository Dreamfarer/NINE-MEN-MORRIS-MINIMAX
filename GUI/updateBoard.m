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
                rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData', [i 1]);   
            else
               rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',[i 1],'Tag','clickable','ButtonDownFcn',@clickedCallback);    
            end
            
        %Black
        elseif isnan(matrixToPosition(i,1)) == false && isnan(matrixToPosition(i,2)) == false && board(i) == (-1)
            color = [0 0 0];
            rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',[i -1]);   
        end  
    end
    
    %Show possible moves for phase 1 (Phase 2&3 must wait for a first click)
    if h.UserData.ph1 == 1
        possibilities(h, 0, "move")
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