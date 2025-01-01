Tracker:AddItems("items/items.json")
Tracker:AddItems("items/friendsanity.json")
Tracker:AddItems("items/Seeds.json")
Tracker:AddItems("items/settings.json")

ScriptHost:LoadScript("scripts/logic.lua")

Tracker:AddMaps("maps/maps.json")
Tracker:AddLocations("locations/CommunityCenter.json")
Tracker:AddLocations("locations/World.json")
Tracker:AddLocations("locations/Quests.json")
--Tracker:AddLocations("locations/Friendsanity.json")

Tracker:AddLayouts("layouts/item_grids.json")
Tracker:AddLayouts("layouts/tool_grid.json")
Tracker:AddLayouts("layouts/island_grid.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/layouts.json")



--Tracker:AddLayouts("layouts/tracker_island.json")
--Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/friends.json")
Tracker:AddLayouts("layouts/seeds.json")
Tracker:AddLayouts("layouts/broadcast.json")

ScriptHost:LoadScript("scripts/watches.lua")

if PopVersion and PopVersion >= "0.18.0" then
  ScriptHost:LoadScript("scripts/autotracking.lua")
end