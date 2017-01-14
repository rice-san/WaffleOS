--/System/Core/Log.lua

logStarted = false
logFile = nil

local log_class = {
	Write = function(self, line, pname)
		local program = pname or self.logName
		local ok, err = pcall(self.logFile.writeLine("["..program.." "..os.time().."]: "..line))
		if not ok then
			self:RefreshHandle()
		end
		local ok, err = pcall(self.logFile.writeLine("["..program.." "..os.time().."]: "..line))
		if not ok then
			error(err, 0)
		end
		self.logFile.flush()
	end,

	RefreshHandle = function(self)
		self.logFile = fs.open(self.logFileLocation, "a")
	end,

	ClearLog = function(self)
		self.logFile.close()
		self.logFile = nil
		self.logFile = fs.open(self.logFileLocation, "w")
		if self.logFile then
			self.logFile.close()
			self.logFile = fs.open(self.logFileLocation, "a")
			if self.logFile then
				return
			else
				error("Could not recreate log file!")
			end
		else
			error("Could not recreate log file!")
		end

	end,

	Close = function(self)
		self.logFile.close()
		self = nil
	end,

}

local mt = {
	__index = log_class,

	__call = function(t, line, pname)
		t:Write(line, pname)
	end,
}

StartLog = function(self, LogName)
	local t = {}
	if self.logStarted == true then
		return
	end

	fs.makeDir("/System/Data/Logs")
	t.logFileLocation = fs.combine("/System/Data/Logs/"
, LogName)
	t.logFile = fs.open(t.logFileLocation, "a")
	t.logName = LogName

	if type(t.logFile) ~= "table" then
		error("Log file couldn't be created")
	end

	setmetatable(t, mt)

	return t
end
