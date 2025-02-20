-- this is an example/ default implementation for AP autotracking
-- it will use the mappings defined in item_mapping.lua and location_mapping.lua to track items and locations via thier ids
-- it will also load the AP slot data in the global SLOT_DATA, keep track of the current index of on_item messages in CUR_INDEX
-- addition it will keep track of what items are local items and which one are remote using the globals LOCAL_ITEMS and GLOBAL_ITEMS
-- this is useful since remote items will not reset but local items might
ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = {}
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}
ALL_LOCATIONS = {}
QUESTS_LOCATIONS = {717501,717502,717503,717504,717505,717506,717507,717508,717509,717510,717511,717512,717513,717514,717515,717516,717517,717518,717519,717520,717521,717522,717523,717524,717525,717526,717527,717528,717529,717530,717531,717532,717533,717534,717535,717536,717537,717538,717539,717540,717541,717542,717543,717544,717801,717802,717803,717804,717805,717806,717807,717808,717811,717812,717813,717814,717815,717816,717817,717818,717821,717822,717823,717824,717825,717826,717827,717828,717841,717842,717843,717844,717845,717846,717847,717848,717849,717850,717851,717852,717853,717854,717855,717856,717857,717858,717859,717860,717861,717862,717863,717864,717865,717866,717867,717868,717869,717870,717871,717872,719101,719102,719103,719104,719105,719106,719107,719108,719109,719110,719111,719112,719113,719114,719115,719116,719117,719118,719151,719152,719153,719154,719155,719156,719157,719158,719159,719160}
CROPSANITY_LOCATIONS = {719301,719302,719303,719304,719305,719306,719307,719308,719309,719310,719311,719312,719313,719314,719315,719316,719317,719318,719319,719320,719321,719322,719323,719324,719325,719326,719327,719328,719329,719330,719331,719332,719333,719334,719335,719336,719337,719338,719339,719340,719341,719342,719343,719344,719345,719346,719347,719348,719349,719350,719351,719352,719353}
FISH_LOCATIONS = {718001,718002,718003,718004,718005,718006,718007,718008,718009,718010,718011,718012,718013,718014,718015,718016,718017,718018,718019,718020,718021,718022,718023,718024,718025,718026,718027,718028,718029,718030,718031,718032,718033,718034,718035,718036,718037,718038,718039,718040,718041,718042,718043,718044,718045,718046,718047,718048,718049,718050,718051,718052,718053,718054,718055,718056,718057,718058,718059,718060,718061,718062,718063,718064,718065,718066,718067,718068,718069,718070,718071}
MINING_LOCATIONS = {718100,718101,718102,718103,718104,718105,718106,718107,718108,718109,718110,718111,718112,718113,718114,718115,718116,718117,718118,718119,718120,718121,718122,718123,718124,718125,718126,718127,718128,718201,718202,718203,718204,718205,718206,718207,718208,718209,718210,718211,718212,718213,718214,718215,718216,718217,718218,718219,718220,718221,718222,718223,718224,718225,718226,718227,718228,718229,718230,718231,718232,718233,718234,718235,718236,718237,718238,718239,718240,718241,718242,718243,718244,718245,718246,718247,718248,718249,718250,718251,718252,718253,718254,718255,718256,718257,718258,718259,718260,718261,718262,718263,718264,718265,718266,718267,718268,718269,718270,718271,718272,718273,718274,718275,718276,718277,718278,718279,718280,718281,718282,718283,718284,718285,718286,718287,718288,718289,718290,718291,718292,718293,718294,718295}
FESTIVAL_LOCATIONS = {719001,719002,719003,719004,719005,719006,719007,719008,719009,719010,719011,719012,719013,719014,719015,719016,719017,719018,719019,719020,719021,719022,719023,719024,719025,719026,719027,719028,719029,719030,719031,719032,719033,719034,719035,719036,719041,719042,719043,719044,719045,719046,719047,719048,719049,719050,719051,719052,719053,719054,719055,719056,719057,719058,719059,719060,719061,719062,719063,719064,719065,719066,719067,719068,719069,719070,719071,719072,719073,719074,719075,719076,719077,719078,719079,719080,719081,719082,719083,719084,719085,719086,719087,719088,719089,719090,719091}
ARCADE_LOCATIONS = {717601,717602,717603,717604,717605,717606,717607,717608,717609,717610,717611,717612,717613,717614,717615,717616,717617,717618,717619,717620,717621}
SHIPSANITY_LOCATIONS = {719416,719417,719418,719419,719420,719421,719423,719424,719425,719426,719427,719428,719429,719430,719431,719432,719433,719434,719435,719436,719437,719438,719439,719440,719441,719442,719443,719444,719445,719446,719447,719612,719613,719614,719615,719616,719617,719618,719619,719620,719621,719622,719623,719624,719625,719626,719627,719628,719629,719630,719631,719632,719633,719634,719635,719636,719637,719638,719639,719640,719641,719642,719643,719644,719645,719646,719647,719648,719649,719650,719651,719652,719653,719654,719655,719656,719657,719658,719659,719660,719661,719662,719663,719664,719665,719666,719667,719668,719669,719670,719671,719672,719673,719674,719675,719676,719677,719678,719679,719680,719681,719682,719683,719684,719685,719686,719687,719688,719689,719690,719691,719692,719693,719694,719695,719696,719697,719698,719699,719700,719701,719702,719703,719704,719705,719706,719707,719708,719709,719710,719711,719712,719713,719714,719715,719716,719717,719718,719719,719720,719721,719722,719723,719724,719725,719726,719727,719728,719729,719730,719731,719732,719733,719734,719735,719736,719737,719738,719739,719740,719741,719742,719743,719744,719745,719764,719765,719766,719767,719768,719769,719770,719771,719772,719773,719776,719777,719778,719779,719780,719781,719782,719783,719784,719786,719787,719789,719790,719791,719792,719796,719797,719798,719799,719800,719801,719802,719803,719805,719806,719807,719808,719809,719810,719811,719812,719814,719815,719816,719817,719818,719819,719820,719821,719822,719823,719824,719825,719826,719827,719828,719829,719830,719831,719832,719833,719834,719835,719836,719871,719942,719943,719944,719945,719946,719947,719948,719949,719950,719951,719952,719953,719954,719955,719956,720801,720825,720827,720829,720831}
COOKSANITY_LOCATIONS = {720201,720202,720203,720204,720205,720206,720207,720208,720209,720210,720211,720212,720213,720214,720215,720216,720217,720218,720219,720220,720221,720222,720223,720224,720225,720226,720227,720228,720229,720230,720231,720232,720233,720234,720235,720236,720237,720238,720239,720240,720241,720242,720243,720244,720245,720246,720247,720248,720249,720250,720251,720252,720253,720254,720255,720256,720257,720258,720259,720260,720261,720262,720263,720264,720265,720266,720267,720268,720269,720270,720271,720272,720273,720274,720275,720276,720277,720278,720279,720280,720281,719472,719473,719474,719475,719931,719476,719477,719478,719479,719480,719481,719482,719483,719484,719485,719486,719487,719488,719489,719490,719491,719492,719493,719494,719495,719496,719497,719498,719499,719500,719501,719502,719503,719932,719504,719505,719506,719507,719508,719509,719933,719510,719511,719512,719513,719514,719515,719516,719517,719518,719519,719935,719520,719521,719522,719523,719524,719525,719526,719527,719528,719529,719530,719531,719532,719533,719534,719535,719536,719537,719538,719539,719540,719541,719542,719543,719544,719936,719545,719546,720865,720301,720302,720303,720304,720305,720306,720307,720308,720309,720310,720311,720312,720313,720314,720315,720316,720317,720318,720319,720320,720321,720322,720323,720324,720325,720326,720327,720328,720329,720330,720331,720332,720333,720334,720335,720336,720337,720338,720339,720340,720341,720342,720343,720344,720345,720346,720347,720348,720349,720350,720351,720352,720353,720354,720355,720356,720357,720358,720359,720360,720361,720362,720363,720364,720365,720366,720367,720368,720369,720370,720371,720372,720373,720374,720375,720376,720377,720378,720379,720380,720381}
SKILLS_LOCATIONS = {717301,717302,717303,717304,717305,717306,717307,717308,717309,717310,717311,717312,717313,717314,717315,717316,717317,717318,717319,717320,717321,717322,717323,717324,717325,717326,717327,717328,717329,717330,717331,717332,717333,717334,717335,717336,717337,717338,717339,717340,717341,717342,717343,717344,717345,717346,717347,717348,717349,717350}

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
	--if #ALL_LOCATIONS > 0 then
        ALL_LOCATIONS = {}
    --end
	
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

for _, quests_id in ipairs(QUESTS_LOCATIONS) do
   Tracker:FindObjectForCode(tostring(quests_id)).Active = ALL_LOCATIONS[quests_id] or false
end

for _, arcade_id in ipairs(ARCADE_LOCATIONS) do
   Tracker:FindObjectForCode(tostring(arcade_id)).Active = ALL_LOCATIONS[arcade_id] or false
end

for _, shipsanity_id in ipairs(SHIPSANITY_LOCATIONS) do
   Tracker:FindObjectForCode(tostring(shipsanity_id)).Active = ALL_LOCATIONS[shipsanity_id] or false
end

for _, cooking_id in ipairs(COOKSANITY_LOCATIONS) do
   Tracker:FindObjectForCode(tostring(cooking_id)).Active = ALL_LOCATIONS[cooking_id] or false
end

for _, skill_id in ipairs(SKILLS_LOCATIONS) do
    Tracker:FindObjectForCode(tostring(skill_id)).Active = ALL_LOCATIONS[skill_id] or false
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
