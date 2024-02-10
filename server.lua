VorpCore = {}
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("juSa_teleport:itemcheck")
AddEventHandler("juSa_teleport:itemcheck", function(items)
    local _source = source
    local hasItem = true 
    for i,v in ipairs(items) do
        local count = VorpInv.getItemCount(_source, v.dbname)
        if count < v.amount then -- if not enough items
            hasItem = false 
            TriggerClientEvent("vorp:TipRight", _source, Config.Language.noitem..v.label, 5000)
            break
        end
    end
    if hasItem then -- if player has all items
        local result = true
        TriggerClientEvent("juSa_teleport:itemchecked", _source, result)
    else
        local result = false
        TriggerClientEvent("juSa_teleport:itemchecked", _source, result)
    end
end)

RegisterServerEvent("juSa_teleport:jobcheck")
AddEventHandler("juSa_teleport:jobcheck", function(jobs)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local hasJob = false
    local hasRequiredGrade = false
    local result = nil
    for i, v in ipairs(jobs) do --check list of jobs
        if v.name == Character.job then --checks for job
            hasJob = true
            if v.grade <= Character.jobGrade then
                hasRequiredGrade = true
                break  --stops when player has a correct job and grade 
            end
        end
    end
    if hasJob and hasRequiredGrade then
        result = true
        TriggerClientEvent("juSa_teleport:jobchecked", _source, result)
    elseif hasJob and not hasRequiredGrade then
        result = false
        TriggerClientEvent("vorp:TipRight", _source, Config.Language.lowgrade, 5000)
        TriggerClientEvent("juSa_teleport:jobchecked", _source, result)
    else
        result = false
        TriggerClientEvent("vorp:TipRight", _source, Config.Language.wrongjob, 5000)
        TriggerClientEvent("juSa_teleport:jobchecked", _source, result)
    end
end)

RegisterServerEvent("juSa_teleport:takeitems")
AddEventHandler("juSa_teleport:takeitems", function(dbname, label, amount)
    local _source = source
    for i = 1, amount do
        exports.vorp_inventory:subItem(_source, dbname, amount)
    end
    TriggerClientEvent("vorp:TipRight", _source, Config.Language.removeditem..amount.." x "..label, 5000)
end)