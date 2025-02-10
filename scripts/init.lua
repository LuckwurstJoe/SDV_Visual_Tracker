Tracker:AddItems("items/items.json")
Tracker:AddItems("items/Seeds.json")
Tracker:AddItems("items/settings.json")
Tracker:AddItems("items/fishsanity_items.json")
Tracker:AddItems("items/museumsanity_items.json")
Tracker:AddItems("items/cropsanity_items.json")
Tracker:AddItems("items/festival_items.json")
Tracker:AddItems("items/quests_items.json")
Tracker:AddItems("items/arcade_items.json")
Tracker:AddItems("items/shipsanity_items.json")
Tracker:AddItems("items/cooksanity_items.json")
Tracker:AddItems("items/recipes.json")

ScriptHost:LoadScript("scripts/logic.lua")

Tracker:AddLocations("locations/CommunityCenter.json")
Tracker:AddLocations("locations/World.json")
Tracker:AddLocations("locations/Quests.json")
Tracker:AddLocations("locations/Cropsanity.json")
Tracker:AddLocations("locations/Fishsanity.json")
Tracker:AddLocations("locations/Museum_Donations.json")
Tracker:AddLocations("locations/Museum_Milestones.json")
Tracker:AddLocations("locations/Boards.json")
Tracker:AddLocations("locations/Desert_Festival.json")
Tracker:AddLocations("locations/Night_Market.json")
Tracker:AddLocations("locations/Fishing_Festivals.json")
Tracker:AddLocations("locations/Town_Festivals.json")
Tracker:AddLocations("locations/Arcades.json")
Tracker:AddLocations("locations/Cooksanity.json")

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