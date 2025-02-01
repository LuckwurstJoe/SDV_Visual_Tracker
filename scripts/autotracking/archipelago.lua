-- this is an example/ default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via thier ids
-- it will also load the AP slot data in the global SLOT_DATA, keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}
ALL_LOCATIONS = {}
CROPSANITY_LOCATIONS = {719301,719302,719303,719304,719305,719306,719307,719308,719309,719310,719311,719312,719313,719314,719315,719316,719317,719318,719319,719320,719321,719322,719323,719324,719325,719326,719327,719328,719329,719330,719331,719332,719333,719334,719335,719336,719337,719338,719339,719340,719341,719342,719343,719344,719345,719346,719347,719348,719349,719350,719351,719352,719353}
FISH_LOCATIONS = {718001,718002,718003,718004,718005,718006,718007,718008,718009,718010,718011,718012,718013,718014,718015,718016,718017,718018,718019,718020,718021,718022,718023,718024,718025,718026,718027,718028,718029,718030,718031,718032,718033,718034,718035,718036,718037,718038,718039,718040,718041,718042,718043,718044,718045,718046,718047,718048,718049,718050,718051,718052,718053,718054,718055,718056,718057,718058,718059,718060,718061,718062,718063,718064,718065,718066,718067,718068,718069,718070,718071}
MINING_LOCATIONS = {718100,718101,718102,718103,718104,718105,718106,718107,718108,718109,718110,718111,718112,718113,718114,718115,718116,718117,718118,718119,718120,718121,718122,718123,718124,718125,718126,718127,718128,718201,718202,718203,718204,718205,718206,718207,718208,718209,718210,718211,718212,718213,718214,718215,718216,718217,718218,718219,718220,718221,718222,718223,718224,718225,718226,718227,718228,718229,718230,718231,718232,718233,718234,718235,718236,718237,718238,718239,718240,718241,718242,718243,718244,718245,718246,718247,718248,718249,718250,718251,718252,718253,718254,718255,718256,718257,718258,718259,718260,718261,718262,718263,718264,718265,718266,718267,718268,718269,718270,718271,718272,718273,718274,718275,718276,718277,718278,718279,718280,718281,718282,718283,718284,718285,718286,718287,718288,718289,718290,718291,718292,718293,718294,718295}
FESTIVAL_LOCATIONS = {719041,719042,719043,719044,719045,719046,719047,719048,719049,719050,719051,719052,719053,719054,719055,719056,719057,719058,719059,719060,719061,719062,719063,719064,719065,719066,719067,719068,719069,719070,719071,719072,719073}


function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}
    -- manually run snes interface functions after onClear in case we are already ingame
	if #ALL_LOCATIONS > 0 then
        ALL_LOCATIONS = {}
    end
	
    --for _, value in pairs(Archipelago.MissingLocations) do
        --table.insert(ALL_LOCATIONS, #ALL_LOCATIONS + 1, value)
    --end
    --for _, value in pairs(Archipelago.CheckedLocations) do
        --table.insert(ALL_LOCATIONS, #ALL_LOCATIONS + 1, value)
    --end
	for _, value in ipairs(Archipelago.MissingLocations) do
        ALL_LOCATIONS[value] = true
    end

    for _, value in ipairs(Archipelago.CheckedLocations) do
        ALL_LOCATIONS[value] = true
    end
	--print(dump_table(ALL_LOCATIONS))
    if SLOT_DATA == nil then
        return
    end

for _, fish_id in ipairs(FISH_LOCATIONS) do
  Tracker:FindObjectForCode(tostring(fish_id)).Active = ALL_LOCATIONS[fish_id] or false
end

for _, mining_id in ipairs(MINING_LOCATIONS) do
  Tracker:FindObjectForCode(tostring(mining_id)).Active = ALL_LOCATIONS[mining_id] or false
end

for _, cropsanity_id in ipairs(CROPSANITY_LOCATIONS) do
  Tracker:FindObjectForCode(tostring(cropsanity_id)).Active = ALL_LOCATIONS[cropsanity_id] or false
end

for _, festival_id in ipairs(FESTIVAL_LOCATIONS) do
  Tracker:FindObjectForCode(tostring(festival_id)).Active = ALL_LOCATIONS[festival_id] or false
end

 -- for _, id in pairs(ALL_LOCATIONS) do
 --     print(id .. " is there")
 -- end
	--print(dump_table(slot_data))
end

-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
    end
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: code: %s, type %s", v[1], v[2]))
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment * (v[3] or 1)
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
    -- track local items via snes interface
    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
        print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
    end
    if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
        -- add snes interface functions here for local item tracking
    end
end

--called when a location gets cleared
function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onLocation: %s, %s", location_id, location_name))
    end
    local v = LOCATION_MAPPING[location_id]
    if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
    end
	if not v then
        return
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[1]:sub(1, 1) == "@" then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
        else
            obj.Active = true
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: could not find object for code %s", v[1]))
    end
end
-- add AP callbacks
-- un-/comment as needed
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
