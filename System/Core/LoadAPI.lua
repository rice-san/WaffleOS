--LoadAPI.lua
--Run this file with shell.run()

WaffleOS.LoadAPI = function(_path)
	local name = fs.getName(_path)
	local length = string.len(name)
	local scan = length - 4
	if string.sub(name, scan+1, -1) == ".lua" then
		local prevName = name
		local newName = string.sub(name, 1, scan)
		os.loadAPI(_path)
		_G[newName] = _G[prevName]
		_G[prevName] = nil
	else
		os.loadAPI(_path)
	end
end

