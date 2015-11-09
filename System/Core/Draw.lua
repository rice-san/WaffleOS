-- /System/Draw.lua

Display = {
	width = 51,
	height = 19
}

Display.width, Display.height = term.getSize()

DrawPoint = function(x, y, color)
    term.setCursorPos(x, y)
    term.write(" ")
end

DrawHLine = function(x, y, length, color)
	local i
    for i=x,(x+length-1) do
        DrawPoint(i, y, color)
    end
end

DrawVLine = function(x, y, length, color)
	local i
    for i = y,(y+length-1) do
        DrawPoint(x, i, color)
    end
end

DrawRect = function(x, y, width, height, color)
	local i
	local j
    for i=1,width do
        DrawPoint(i, y, color)
        DrawPoint(i, y+height-1, color)
    end
    for j=1,height do
        DrawPoint(x, i, color)
        DrawPoint(x+width-1, i, color)
    end
end

FillRect = function(x, y, width, height, color)
	local i
	local j
    for j=y,(y+height-1) do
        for i=x,(x+width-1) do
            DrawPoint(i, j, color)
        end
    end
end

DrawText = function(x, y, text, _wrap)
	local wrapping = _wrap or false
	if not wrapping then
		text = string.sub(text, 1, Display.width - x)
	end
end

DrawCenterText = function(y, text)
	return Math.round(Display.width/2 - string.length(text)/2)
end