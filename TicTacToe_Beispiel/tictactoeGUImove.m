function newboard = tictactoeGUImove(board,playerType)
% draws the current state on a figure, optionally waits for a user to put
% his mark (click on the board)
% input:
%   board specifies the current state of the game (3x3, 0=empty; 1=mark pl1(X); -1=mark pl2(O))
%   playerType (1/-1) specifies whose turn it is - for other values the GUI
%   does not accept any user-inputs (clicks)

h = findobj('Name','Muehle'); %existierende figure finden

if isempty(h)
    h = figure('Name','Muehle'); %oder neu erschaffen
    axis off; axis square,  % prepare to draw 
    xlim([0 6]); ylim([0 6]);    
end

%board = rot90(board,3); %Display-Koordinaten wie Lesefluss (nicht wie Matrix)
h.UserData.b = board;   %TRICK: Wichtige Werte in UserData speichern, damit sie in den Callback-Funktionen zugänglich sind
h.UserData.p = playerType;
updateBoard(h); %aktuelles board auf die figure zeichnen, leere Felder clickable machen
if abs(playerType)==1
    uiwait(h); %auf click warten
end
newboard = rot90(h.UserData.b); %board mit neuem Eintrag zurückgeben 

end

function updateBoard(h)

    delete(findobj(gca,'Type','text')); %alte Einträge löschen
    delete(findobj(gca,'Type','rectangle')); %alte Einträge löschen
    
    drawBoard()

    board = h.UserData.b;
    
    for i=1:7
        for j=1:7
            if h.UserData.p ~= 0 %anklickbare Rechtecke auf leere Felder legen, Index als UserData
                
                %Get Linear Index
                linindex = sub2ind([7 7],i,j);
                
                checkMat = [
                3 NaN NaN 3 NaN NaN 3; 
                NaN 3 NaN 3 NaN 1 NaN; 
                NaN NaN 1 1 1 NaN NaN; 
                1 1 1 NaN 1 1 1; 
                NaN NaN 1 1 1 NaN NaN; 
                NaN 1 NaN 1 NaN 1 NaN; 
                1 NaN NaN 1 NaN NaN 1
                ];
            
                if (~isnan(checkMat(linindex)))
                    
                    color = [0 0 0];
                    
                    %Black (1)
                    if (checkMat(linindex) == 1)
                        color = [0 0 0];
                    end
                    
                    %White (0)
                    if (checkMat(linindex) == 0)
                        color = [1 1 1];
                    end
                    
                    %empty (3)
                    
                    %The corresponding rectangle stores it's index in Userdata
                    rectangle('Position',[i-1.25 j-1.25 0.5 0.5],'FaceColor',color,'Clipping','off','UserData',linindex,'Tag','clickable','ButtonDownFcn',@clickedCallback);
                
                end   
            end
        end
    end
    drawnow 
end

function drawBoard()

    %Background
    lineWidth = 5;
    
    rectangle('Position',[0 0 6 6],'LineWidth',lineWidth,'Clipping','off','FaceColor',[1 1 1]) % outside border
    line([0 6],[3 3],'Color','black','Clipping', 'off', 'LineWidth',lineWidth)
    line([3 3],[0 6],'Color','black','Clipping', 'off', 'LineWidth',lineWidth)
    rectangle('Position',[1 1 4 4],'LineWidth',lineWidth,'Clipping','off','FaceColor',[0 0 0 0]) % outside border 
    rectangle('Position',[2 2 2 2],'LineWidth',lineWidth,'Clipping','off','FaceColor',[1 1 1 1]) % outside border

end

function clickedCallback(obj,evt)
%Verarbeitet Klicks auf die Rechtecke im TicTacToe-Board
    h = findobj('Name','Muehle'); %TRICK: Wir müssen die figure (mit den Daten drin) nicht übergeben, sondern können sie einfach wieder suchen (findobj) 
    h.UserData.m = obj.UserData %TRICK: So findet man den lineare Index des angeklickten Rechtecks
    h.UserData.b(h.UserData.m)=h.UserData.p; %entsprechenden Wert (1/-1) dort ins board schreiben
    %updateBoard(h); %geht, aber dann wird alles neu gezeichnet -> langsam
    %showGuiMove(h,h.UserData.m,h.UserData.p); %den neuen Mark anzeigen
    uiresume(h);
end

function showGuiMove(h,linIndex,playerType)
%Schreibt marker an eine Stelle im Board und löscht das entsprechende Rechteck
    if playerType == 1
        marker = 'X';
    else
        marker = 'O';
    end
    [i,j]=ind2sub(size(h.UserData.b),linIndex);
    text(i,j,marker,'FontUnits','normalized','FontSize',0.3,'HorizontalAlignment','center');
    delete(findobj(gca,'Tag','clickable'));
end