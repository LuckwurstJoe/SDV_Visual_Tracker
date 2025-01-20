-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true and ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP = true and AUTOTRACKER_ENABLE_DEBUG_LOGGING
AUTOTRACKER_ENABLE_DEBUG_LOGGING_SNES = true and AUTOTRACKER_ENABLE_DEBUG_LOGGING
-------------------------------------------------------
print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
print("Enable Island Tracking:        ", AUTOTRACKER_ENABLE_ISLAND_TRACKING)
print("Enable Museum Switch:        ", AUTOTRACKER_SWITCH_MUSEUM)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING)
    print("Enable AP Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP)
    print("Enable SNES Debug Logging:        ", AUTOTRACKER_ENABLE_DEBUG_LOGGING_SNES)
end
print("---------------------------------------------------------------------")
print("")

-- loads the AP autotracking code
ScriptHost:LoadScript("scripts/autotracking/archipelago.lua")