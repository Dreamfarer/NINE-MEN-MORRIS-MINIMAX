%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display text beneath Nine-Men-Morris board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-Input-
%message:       The actual message that gets displayed
%fontColor:     Font color
%fontsize:      Font Size
function displayText(message, fontColor, fontSize)

delete(findobj(gca,'Type','text','HorizontalAlignment','left'));
outputText = text(0.25, -1, message,'FontUnits','normalized','FontSize',fontSize,'HorizontalAlignment','left');
outputText(1).Color = fontColor;

end