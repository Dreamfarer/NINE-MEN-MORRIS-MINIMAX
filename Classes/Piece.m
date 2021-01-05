classdef Piece
   % Variables
   properties
      color = NaN; %1: white, 0: black
      position = [NaN NaN NaN];
      index = NaN;
   end
   
   % Functions
   methods
      function r = roundOff(obj)
         r = round([obj.color],2);
      end
   end
end