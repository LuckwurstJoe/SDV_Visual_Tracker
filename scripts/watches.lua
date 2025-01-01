function updateIslandTracking()
	AUTOTRACKER_ENABLE_ISLAND_TRACKING = (Tracker:ProviderCountForCode("island_tracking_on") > 0)
	if AUTOTRACKER_ENABLE_ISLAND_TRACKING then
		Tracker:AddLayouts("layouts/tracker_island.json")
	else
		Tracker:AddLayouts("layouts/tracker.json")
	end
end


if PopVersion > "0.1.0" then
	ScriptHost:AddWatchForCode("updateIslandTracking", "island_tracking", updateIslandTracking)
end
