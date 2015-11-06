-- System/Draw.lua

Display = {}

Display.width, Display.height = term.getSize()

DrawPoint = function(x, y, color)
    term.setCursorPos(x, y)
    term.write(" ")
end

DrawHLine = function(x, y, length, color)
    for local i=x,(x+length-1) do
        DrawPoint(i, y, color)
    end
end

DrawVLine = function(x, y, length, color)
    for local i=y,(y+length-1) do
        DrawPoint(x, i, color)
    end
end

DrawRect = function(x, y, width, height, color)
    for local i=1,width do
        DrawPoint(i, y, color)
        DrawPoint(i, y+height-1, color)
    end
    for local i=1,height do
        DrawPoint(x, i, color)
        DrawPoint(x+width-1, i, color)
    end
end

FillRect = function(x, y, width, height, color)
    for local i=y,(y+height-1) do
        for local j=x,(x+width-1) do
            DrawPoint(x, y, color)
        end
    end
end