function displayText(message, color, fontSize)

delete(findobj(gca,'Type','text'));
test = text(0.25, -1, message,'FontUnits','normalized','FontSize',fontSize,'HorizontalAlignment','left');

test(1).Color = color;

end