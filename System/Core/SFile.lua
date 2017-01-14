--/System/Core/SFile.lua

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

UpdateFileHash = function(self, __path)
    local _path = __path
    local hashpath = fs.combine("/System/Data/FileHashes/", _path..".hash")
    local hashdir = fs.combine("/System/Data/FileHashes/", fs.getDir(_path..".hash"))

    local file = fs.open(_path, "r")
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

CheckFileHash = function(self, __path)
    local _path = __path
    local hashpath = fs.combine("/System/Data/FileHashes/", _path..".hash")

    local file = fs.open(_path, "r")
    local hashfile = fs.open(hashpath, "r")

    if file and hashfile then
    	local text = file.readAll()
    	local hashtext = hashfile.readLine()
    	--SystemLog("Text when hashed: "..hash(text))
    	--SystemLog("Text in hashfile: "..hashtext)
        if hash(text) == hashtext then
        	--SystemLog("They are the same")
            file.close()
            hashfile.close()
            return true
        else
        	--SystemLog("They are different")
            file.close()
            hashfile.close()
            return false
        end
    end
end

OpenFileSecure = function(self, _path, mode)
    if self:CheckFileHash(_path) then
        return fs.open(_path, mode)
    end
end

RunFileSecure = function(self, _path)
    if self:CheckFileHash(_path) then
        return os.run({},_path)
    end
end
