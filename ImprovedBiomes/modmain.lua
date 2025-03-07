local require = GLOBAL.require

require "constants"

print("hello world")

PrefabFiles = {
    "locust_mob",
    "fern_plant",
    "fern2_plant"
}

local STRINGS = GLOBAL.STRINGS
local NAMES = STRINGS.NAMES
local CHARACTER_NAMES = {"GENERIC","WILLOW","WOLFGANG","WENDY","WX78"
,"WICKERBOTTOM","WOODIE","WAXWELL","WATHGRITHR","WEBBER","WINONA","WARLY","WORTOX","WORMWOOD","WURT","WALTER","WANDA"}
function BulkAddDescription(key,desc)
    for _, charName in ipairs(CHARACTER_NAMES) do
        local charDet = STRINGS.CHARACTERS[charName]
        if charDet == nil then
            print("INVALID CHARACTER NAME", charName)
        else
            charDet.DESCRIBE[key] = desc
        end
    end
end
NAMES.LOCUST_MOB = "Locust"
BulkAddDescription("LOCUST_MOB","... An insolent, buzzy thing")