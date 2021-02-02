function newboard = GUI(board,playerType, phase1, phase2)

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

updateBoard(h);

%Wait for click
if abs(playerType)==1
    uiwait(h); 
end

newboard = rot90(h.UserData.b);

end

function updateBoard(h)

    delete(findobj(gca,'Type','text')); %alte Einträge löschen
    delete(findobj(gca,'Type','rectangle')); %alte Einträge löschen
    
    %Draw background
    drawBoard();

    board = h.UserData.b; 
    color = [0 0 0 0.5];
    
    %Draw the actual playstate!
    for i = 1:27
        
        %White
        if board(i) == 1
            color = [0 0 0 0.5];
        %Black
        elseif (board(i) == (-1))
            color = [1 1 1 0.5];
        end
        
        if isnan(matrixToPosition(i,1)) == false && isnan(matrixToPosition(i,2)) == false && board(i) ~= 0
            rectangle('Position',[matrixToPosition(i,1) matrixToPosition(i,2) 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',i,'Tag','clickable','ButtonDownFcn',@clickedCallback);   
        end   
    end
    
    drawnow 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matrix Luca to 7x7 Display-Matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function position = matrixToPosition(x,y)

%Get index of Luca's matrix and return the cooresponding 2D position

A = [
    0 6;
    0 3; 
    0 0;
    3 6;
    NaN NaN;
    3 0;
    6 6;
    6 3;
    6 0;
    1 5;
    1 3;
    1 1;
    3 5;
    NaN NaN;
    3 1;
    5 5;
    5 3;
    5 1;
    2 4;
    2 3;
    2 2;
    3 4;
    NaN NaN;
    3 2;
    4 4;
    4 3;
    4 2;
];

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
    h = findobj('Name','Muehle'); 
    h.UserData.m = obj.UserData;
    h.UserData.b(h.UserData.m)=h.UserData.p;
    
    disp(obj.UserData)
    
    showGuiMove(h,h.UserData.m,h.UserData.p); %den neuen Mark anzeigen
    uiresume(h);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Show the next one
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function showGuiMove(h,index,playerType)
%Schreibt marker an eine Stelle im Board und löscht das entsprechende Rechteck
    rectangle('Position',[matrixToPosition(index,1) matrixToPosition(index,2) 0.5 0.5],'FaceColor',[0.5 0.25 1 1],'Clipping','off','UserData',index,'Tag','clickable','ButtonDownFcn',@clickedCallback);
    delete(findobj('Position',[matrixToPosition(index,1) matrixToPosition(index,2) 0.5 0.5],'Tag','clickable'));
end


%Transmission
%1 Receive 3x3x3 Matrix