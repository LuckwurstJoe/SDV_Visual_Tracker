function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function spring()
    return has("spring")
end

function summer()
    return has("summer")
end

function fall()
    return has("fall")
end

function winter()
    return has("winter")
end

function can_mine_copper()
    return (has("CopperPick") or has("e5"))
end

function can_mine_iron()
    return (has("SteelPick") or has("e40"))
end

function can_mine_gold()
    return (has("GoldPick") or has("e80"))
end

function has_skull_key()
    return has("skullkey")
end

function can_access_desert()
    return (has("desertwarp") or has ("bus"))
end

function can_access_island()
    return has("islandwarp")
end

function can_mine_iridium()
    return (has("IridiumPick") and ((can_access_desert() and has("skullkey")) or can_access_island()))
end

function can_fish()
    return has("rod")
end

function has_crab_pots()
    return (can_mine_iron() and has("fishing",3))
end

function can_chop_stumps()
    return has("CopperAxe")
end

function can_chop_logs()
    return has("SteelAxe")
end

function has_coop()
    return has("chicken")
end

function has_big_coop()
    return has("duck")
end

function has_deluxe_coop()
    return has("rabbit")
end

function has_barn()
    return has("cow")
end

function has_big_barn()
    return has("goat")
end

function has_deluxe_barn()
    return has("pig")
end

function has_bridge()
    return has("bridge")
end

function secret_notes()
    return has("notes")
end

function can_cook()
    return (has("kitchen") or has("foraging",9))
end

function can_brew()
    return has("farming",8)
end

function exoticforagebundle()
    local amt = 0
    local need = 5
    if can_access_desert() then
        amt = amt + 2
    end
    if has("foraging",3) then
        amt = amt + 3
    end
    if can_chop_logs() then
        amt = amt + 1
    end
    if has("e40") then
        amt = amt + 2
    end
    if has("e80") then
        amt = amt + 1
    end
    return (amt >= need)
end

function animalbundle()
    local amt = 0
    local need = 5
    if has_barn() then
        amt = amt + 1
    end
    if has_big_barn() then
        amt = amt + 1
    end
    if has_coop() then
        amt = amt + 2
    end
    if has_big_coop() then
        amt = amt + 1
    end
    if (has_deluxe_coop() or has_deluxe_barn()) then
        amt = amt + 1
    end
    return (amt >= need)
end

function artisanbundle()
    local amt = 2
    local need = 6
    if (has_deluxe_barn() and has("farming",8)) then
        amt = amt + 1
    end
    if ((has_deluxe_barn() or has_deluxe_coop()) and has("farming",7)) then
        amt = amt + 1
    end
    if (has_big_barn() and has("farming",6)) then
        amt = amt + 1
    end
    if (has_barn() and has("farming",6)) then
        amt = amt + 1
    end
    if has("farming",3) then
        amt = amt + 1
    end
    if has("farming",4) then
        amt = amt + 1
    end
    if summer() then
        amt = amt + 2
    end
    if fall() then
        amt = amt + 2
    end
    return (amt >= need)
end


function chefbundle()
    return (can_chop_logs() and has_deluxe_barn() and can_cook() and summer())
end

function dyebundle()
    return (has("e40") and has_big_coop() and (has("e80") or can_chop_logs()) and summer())
end

function fieldresearchbundle()
    return (has("e40") and can_fish() and winter())
end

function enchantbundle()
    return (has_deluxe_coop() and can_brew() and has("foraging",3) and fall())
end

function farming1()
    return has("farming",1)
end

function tmmon()
    return has("monday")
end

function tmtues()
    return has("tuesday")
end

function tmwed()
    return has("wednesday")
end

function tmthurs()
    return has("thursday")
end

function tmfri()
    return has("friday")
end

function tmsat()
    return has("saturday")
end

function tmsun()
    return has("sunday")
end

function quests2()
    return has("quests",2)
end
function quests3()
    return has("quests",3)
end
function quests4()
    return has("quests",4)
end
function quests5()
    return has("quests",5)
end
function quests6()
    return has("quests",6)
end
function quests7()
    return has("quests",7)
end
function quests8()
    return has("quests",8)
end
function quests9()
    return has("quests",9)
end
function quests10()
    return has("quests",10)
end
function quests11()
    return has("quests",11)
end
function quests12()
    return has("quests",12)
end
function quests13()
    return has("quests",13)
end
function quests14()
    return has("quests",14)
end
function quests15()
    return has("quests",15)
end
function quests16()
    return has("quests",16)
end
function quests17()
    return has("quests",17)
end
function quests18()
    return has("quests",18)
end
function quests19()
    return has("quests",19)
end
function quests20()
    return has("quests",20)
end
function quests21()
    return has("quests",21)
end
function quests22()
    return has("quests",22)
end
function quests23()
    return has("quests",23)
end
function quests24()
    return has("quests",24)
end
function quests25()
    return has("quests",25)
end
function quests26()
    return has("quests",26)
end
function quests27()
    return has("quests",27)
end
function quests28()
    return has("quests",28)
end
function quests29()
    return has("quests",29)
end
function quests30()
    return has("quests",30)
end
function quests31()
    return has("quests",31)
end
function quests32()
    return has("quests",32)
end
function quests33()
    return has("quests",33)
end
function quests34()
    return has("quests",34)
end
function quests35()
    return has("quests",35)
end
function quests36()
    return has("quests",36)
end
function quests37()
    return has("quests",37)
end
function quests38()
    return has("quests",38)
end
function quests39()
    return has("quests",39)
end
function quests40()
    return has("quests",40)
end
function quests41()
    return has("quests",41)
end
function quests42()
    return has("quests",42)
end
function quests43()
    return has("quests",43)
end
function quests44()
    return has("quests",44)
end
function quests45()
    return has("quests",45)
end
function quests46()
    return has("quests",46)
end
function quests47()
    return has("quests",47)
end
function quests48()
    return has("quests",48)
end
function quests49()
    return has("quests",49)
end
function quests50()
    return has("quests",50)
end
function quests51()
    return has("quests",51)
end
function quests52()
    return has("quests",52)
end
function quests53()
    return has("quests",53)
end
function quests54()
    return has("quests",54)
end
function quests55()
    return has("quests",55)
end
function quests56()
    return has("quests",56)
end