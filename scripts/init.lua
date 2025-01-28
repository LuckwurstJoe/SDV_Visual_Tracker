Tracker:AddItems("items/items.json")
Tracker:AddItems("items/Seeds.json")
Tracker:AddItems("items/settings.json")
Tracker:AddItems("items/fishsanity_items.json")


ScriptHost:LoadScript("scripts/logic.lua")

Tracker:AddLocations("locations/CommunityCenter.json")
Tracker:AddLocations("locations/World.json")
Tracker:AddLocations("locations/Quests.json")
Tracker:AddLocations("locations/Shipsanity.json")
Tracker:AddLocations("locations/Fishsanity.json")
Tracker:AddLocations("locations/Museum_Donations.json")
Tracker:AddLocations("locations/Museum_Milestones.json")
Tracker:AddLocations("locations/Boards.json")

Tracker:AddLayouts("layouts/item_grids.json")
Tracker:AddLayouts("layouts/tool_grid.json")
Tracker:AddLayouts("layouts/island_grid.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/layouts.json")

Tracker:AddMaps("maps/maps.json")

--Tracker:AddLayouts("layouts/tracker_island.json")
--Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/seeds.json")
Tracker:AddLayouts("layouts/broadcast.json")

ScriptHost:LoadScript("scripts/watches.lua")

updateIslandTracking()

if PopVersion and PopVersion >= "0.18.0" then
  ScriptHost:LoadScript("scripts/autotracking.lua")
end