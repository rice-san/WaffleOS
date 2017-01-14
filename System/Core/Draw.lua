-- /System/Draw.lua

os.loadAPI("/rom/apis/colors")

SetFGColor = function(self, color)
	if type(color) == "number" then
		term.setTextColor(color)
	end
end

SetBGColor = function(self, color)
	if type(color) == "number" then
		term.setBackgroundColor(color)
	end
end

Display = {
	width = 51,
	height = 19
}

Display.width, Display.height = term.getSize()

DrawPoint = function(self, x, y, color)
    term.setCursorPos(x, y)
    self:SetBGColor(color)
    term.write(" ")
end

DrawHLine = function(self, x, y, length, color)
	local i
    for i=x,(x+length-1) do
        self:DrawPoint(i, y, color)
    end
end

DrawVLine = function(self, x, y, length, color)
	local i
    for i = y,(y+length-1) do
        self:DrawPoint(x, i, color)
    end
end

DrawRect = function(self, x, y, width, height, color)
	local i
	local j
    for i=1,width do
        self:DrawPoint(i, y, color)
        self:DrawPoint(i, y+height-1, color)
    end
    for j=1,height do
        self:DrawPoint(x, i, color)
        self:DrawPoint(x+width-1, i, color)
    end
end

FillRect = function(self, x, y, width, height, color)
	local i
	local j
    for j=y,(y+height-1) do
        for i=x,(x+width-1) do
            self:DrawPoint(i, j, color)
        end
    end
end

DrawText = function(self, x, y, _text, fg, bg, _wrap)
	local wrapping = _wrap or false
	local text
	if not wrapping then
		text = string.sub(_text, 1, Display.width - x)
	end
	self:SetFGColor(fg)
	self:SetBGColor(bg)
	term.setCursorPos(x, y)
	print(text)
end

DrawCenterText = function(self, y, text, fg, bg)
	self:DrawText(Math.Round(Display.width/2 - string.len(text)/2), y, text, fg, bg)
end
