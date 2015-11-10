--/System/Core/SFile/Lua

--Some basic functions taken from another place

--[[
    Author: gnush
    A simple string encoder / hasher.
    This is NOT SAFE, so don't user your real world passwords with this.
]]--

local function hash(str)
    local s = 0
    local p = ""
    
    for c in str:gmatch(".") do
        s = s + string.byte(c)
    end

    s = bit.bxor(65432895, s)

    while s > 0 do
        p = p .. string.char(s % 94 + 33)
        s = bit.brshift(s, 1)
    end
    
    return string.sub(p, 1, p:len() - 1)
end

UpdateFileHash = function(_path)
    local path = _path
    local hashpath = fs.combine("/System/Data/FileHashes/", path)
    local hashdir = fs.combine("/System/Data/FileHashes/", fs.getDir(path))
    
    local file = fs.open(path, "r")
    fs.makeDir(hashdir)
    local hashfile = fs.open(hashpath, "w")
    
    if file and hashfile then
        local text = file.readAll()
        local hashedText = hash(text)
        hashfile.writeLine(hash(text))
        file.close()
        hashfile.close()
    end
end

CheckFileHash = function(_path)
    local path = _path
    local hashpath = fs.combine("/System/Data/FileHashes/", path)
    
    local file = fs.open(path, "r")
    local hashfile = fs.open(hashpath, "r")
    
    if file and hashfile then
    	local text = file.readAll()
    	local hashtext = hashfile.readLine()
    	print("Text when hashed: "..hash(text))
    	print("Text in hashfile: "..hashtext)
        if hash(text) == hashtext then
        	print("They are the same")
            file.close()
            hashfile.close()
            return true
        else
        	print("They are different")
            file.close()
            hashfile.close()
            return false
        end
    end
end

OpenFileSecure = function(path, mode)
    if CheckFileHash(path) then
        return fs.open(path, mode)
    end
end

RunFileSecure = function(path)
    if CheckFileHash(path) then
        return shell.run(path)
    end
end