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

board = rot90(board,3); %Display-Koordinaten wie Lesefluss (nicht wie Matrix)
h.UserData.b = board;   %TRICK: Wichtige Werte in UserData speichern, damit sie in den Callback-Funktionen zugänglich sind
h.UserData.p = playerType;
updateBoard(h); %aktuelles board auf die figure zeichnen, leere Felder clickable machen
if abs(playerType)==1
    uiwait(h); %auf click warten
end
newboard = rot90(h.UserData.b); %board mit neuem Eintrag zurückgeben 

end


%% Hilfsfunktionen und Callbacks%%%%%%%%%%%%%%%%

function updateBoard(h)
%Zeichnet das aktuelle Board (gespeichert in UserData) auf die figure

    delete(findobj(gca,'Type','text')); %alte Einträge löschen
    delete(findobj(gca,'Type','rectangle')); %alte Einträge löschen
    
    %Background
    
    maxWidth = 6;
    maxHeight = 6;
    
    lineWidth = 5;
    
    rectangle('Position',[0 0 7 7],'LineWidth',lineWidth,'Clipping','off','FaceColor',[1 1 1]) % outside border
    
    line([0 7],[3.5 3.5],'Color','black','Clipping', 'off', 'LineWidth',lineWidth)
    line([3.5 3.5],[0 7],'Color','black','Clipping', 'off', 'LineWidth',lineWidth)
    
    rectangle('Position',[1 1 5 5],'LineWidth',lineWidth,'Clipping','off','FaceColor',[0 0 0 0]) % outside border
    
    rectangle('Position',[2 2 3 3],'LineWidth',lineWidth,'Clipping','off','FaceColor',[1 1 1 1]) % outside border
    
    %rectangle('Position',[1.5 0.5 1 3],'LineWidth',1) % inside border
    %rectangle('Position',[0.5 1.5 3 1],'LineWidth',1) % inside border

    board = h.UserData.b;
    % Fill in the marks
    
%     for i=1:3
%         for j=1:3
%             if board(i,j)==1           
%                 text(i,j,'X','FontUnits','normalized','FontSize',0.3,'HorizontalAlignment','center');
%             elseif board(i,j)==-1
%                 text(i,j,'O','FontUnits','normalized','FontSize',0.3,'HorizontalAlignment','center');
%             elseif h.UserData.p ~= 0 %anklickbare Rechtecke auf leere Felder legen, Index als UserData
%                 linindex = sub2ind(size(board),i,j);              
%                 rectangle('Position',[i-0.90 j-0.90 0.9 0.9],'FaceColor',[1 0 0],'UserData',linindex,'Tag','clickable','ButtonDownFcn',@clickedCallback);
%                 %TRICK: Das Objekt merkt sich seinen Index in UsewrData,
%                 %damit man in der Callbackfunktion einfach herausfinden
%                 %kann, auf welches Objekt geklickt wurde
%             end
%         end
%     end
    drawnow 
end

function clickedCallback(obj,evt)
%Verarbeitet Klicks auf die Rechtecke im TicTacToe-Board
    h = findobj('Name','TicTacToe'); %TRICK: Wir müssen die figure (mit den Daten drin) nicht übergeben, sondern können sie einfach wieder suchen (findobj) 
    h.UserData.m = obj.UserData; %TRICK: So findet man den lineare Index des angeklickten Rechtecks
    h.UserData.b(h.UserData.m)=h.UserData.p; %entsprechenden Wert (1/-1) dort ins board schreiben
    %updateBoard(h); %geht, aber dann wird alles neu gezeichnet -> langsam
    showGuiMove(h,h.UserData.m,h.UserData.p); %den neuen Mark anzeigen
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