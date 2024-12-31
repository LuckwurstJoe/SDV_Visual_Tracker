function updateIslandTracking()
	AUTOTRACKER_ENABLE_STAT_TRACKING = (Tracker:ProviderCountForCode("island_tracking_on") > 0) and
		AUTOTRACKER_ENABLE_ITEM_TRACKING
	if AUTOTRACKER_ENABLE_STAT_TRACKING then
		Tracker:AddLayouts("layouts/tracker_island.json")
	else
		Tracker:AddLayouts("layouts/tracker.json")
	end
	disableWatches()
	enableWatches()
end


if PopVersion > "0.1.0" then
	ScriptHost:AddWatchForCode("updateIslandTracking", "island_tracking", updateIslandTracking)
end
