-- /System/Core/Error.lua

ErrorHandler = function(stuff)
	
end


FatalErrorHandler = function(errorText)
	Draw.FillRect(1, 1, Draw.Display.width, Draw.Display.height, colors.white)
	local drawLine = Math.Round(Draw.Display.height * (4/5))
	Draw.DrawCenterText(drawLine, errorText, colors.red, colors.white)
end