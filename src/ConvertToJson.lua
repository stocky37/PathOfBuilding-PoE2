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

function exportData(item)
	local file = io.open("json/" .. item .. ".json", "w")
  file:write(json.encode(data[item]))
  file:close()
end

LoadModule("GameVersions")
LoadModule("Modules/Common")
LoadModule("Modules/Data")

data.gems = LoadModule("Data/Gems")

-- exportData("powerStatList")
exportData("itemMods")
exportData("skillColorMap")
exportData("cursePriority")
exportData("keystones")
exportData("ailmentTypeList")
exportData("elementalAilmentTypeList")
exportData("nonDamagingAilmentTypeList")
exportData("nonElementalAilmentTypeList")
exportData("nonDamagingAilment")
exportData("modScalability")
exportData("highPrecisionMods")
exportData("weaponTypeInfo")
exportData("unarmedWeaponData")
exportData("itemMods")
exportData("itemTagSpecial")
exportData("itemTagSpecialExclusionPattern")
exportData("bosses")
exportData("bossSkills")
exportData("bossStats")
exportData("enemyIsBossTooltip")

exportData("skillStatMap")
exportData("gems")
exportData("minions")
exportData("itemBases")
exportData("itemBaseTypeList")
exportData("uniques")
exportData("questRewards")

-- exportData("skills")
-- exportData("mapMods")

