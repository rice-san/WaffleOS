--LoadAPI.lua
--Run this file with shell.run()

WaffleOS.LoadAPI = function(path)
	local length = string.len(path)
	local scan = length - 4
	if string.sub(path, scan+1, -1) == ".lua" then
		local name = string.sub(path, 1, scan)
		local searchIndex = 1
		local matchIndex = 0
		while matchIndex do
			print("1")
			searchIndex = matchIndex + 1
			matchIndex = string.find(path, "/", searchIndex)
		end
		matchIndex = searchIndex - 1
		prevName = string.sub(path, matchIndex+1, -1)
		newName = string.sub(path, matchIndex+1, scan)
		print(prevName)
		print(newName)
		os.loadAPI(path)
		_G[newName] = _G[prevName]
		_G[prevName] = nil
	else
		os.loadAPI(path)
	end
end
