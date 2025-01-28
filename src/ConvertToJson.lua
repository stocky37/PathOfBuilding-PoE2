local bit = require "bit"
local json = require "json"
local l_require = require
launch = {}

function require(name)
	-- Hack to stop it looking for lcurl, which we don't really need
	if name == "lcurl.safe" then
		return
	end
	return l_require(name)
end

function LoadModule(fileName, ...)
	if not fileName:match("%.lua") then
		fileName = fileName .. ".lua"
	end
	local func, err = loadfile(fileName)
	if func then
		return func(...)
	else
		error("LoadModule() error loading '"..fileName.."': "..err)
	end
end

function cleanTable(o, stack)
	if type(o) ~= 'table' then return o end
	
	local t = {}
	for k,v in pairs(o) do
		if type(k) ~= 'table' and type(v) ~= 'function' then
			if type(v) == 'table' then
				t[k] = cleanTable(v)
			else
				t[k] = v
			end -- if type(v) == 'table' then
		end -- if type(k) ~= 'table' and type(v) ~= 'function' then
	end -- for k,v in pairs(o) do
	
	return t
end

local function exportJson(filename, o)
	if not filename:match("%.json") then
    filename = filename .. ".json"
  end
	local f = io.open("json/" .. filename, "w")
  f:write(json.encode(cleanTable(o)))
  f:close()
end

LoadModule("GameVersions")
LoadModule("Modules/Common")
LoadModule("Modules/Data")
LoadModule("Data/Global")


-- export all data items
for k,v in pairs(data) do
	if type(v) == "table" then
		exportJson(k, v)
	end
end

-- export other misc data
exportJson("skillTypes.json", SkillType)
exportJson("colorCodes.json", colorCodes)
