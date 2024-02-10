local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterNetEvent("vorp:SelectedCharacter") --starts after user selected Char in vorp_character
AddEventHandler("vorp:SelectedCharacter", function(charid)
-- createTeleports()
end)

local hasjob = nil
local hasitems = nil

Citizen.CreateThread(function () --creating teleporters
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local playerPed = PlayerPedId()
        for i,v in ipairs(Config.Teleporter) do
            if Vdist(playerCoords, v.entrance) <= Config.dist then --checking distance to load teleporters
                if v.drawEntrance then
                    local x, y, z = table.unpack(v.entrance)
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, x, y, z, 0, 0, 0, 0, 0, 0, 1.3, 1.3, 0.4, 105, 105, 105, 180, 0, 0, 0, 0) --draw marker
                    if v.blip ~= 0 then
                        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, x, y, z)
                        SetBlipSprite(blip, v.blip, true)
                        Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.name)
                    end
                end
                if v.drawExit then
                    local x, y, z = table.unpack(v.exit)
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, x, y, z, 0, 0, 0, 0, 0, 0, 1.3, 1.3, 0.4, 105, 105, 105, 180, 0, 0, 0, 0)   --draw marker
                end 
            end

            if Vdist(playerCoords, v.entrance) <= 1.2 then --entrance function
                DrawTxt(Config.Language.enterPrompt, 0.45, 0.85, 0.5, 0.5, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, Config.keys.Enter) then --when key is pressed
                    if v.items ~= false then --if player needs items
                        TriggerServerEvent("juSa_teleport:itemcheck", v.items) --check if player has items
                    else
                        hasitems = true
                    end
                    if v.jobs ~= false then --if player needs a job
                        TriggerServerEvent("juSa_teleport:jobcheck", v.jobs) -- and check if player has job
                    else
                        hasjob = true
                    end
                    Wait(200) --wait for serverevent results
                    if hasjob and hasitems then --if player has items and job teleport player
                        local x, y, z = table.unpack(v.exit)
                        SetEntityCoords(playerPed, x, y, z)
                        if v.items ~= false then 
                            for i,v in ipairs(v.items) do
                                if v.removeitem then
                                    TriggerServerEvent("juSa_teleport:takeitems", v.dbname, v.label, v.amount) --take items
                                end
                            end
                        end
                    else
                        VorpCore.NotifyRightTip(Config.Language.notallowed,4000)
                    end
                    --reset
                    hasjob = nil
                    hasitems = nil
                    Citizen.Wait(1000)
                end
            elseif Vdist(playerCoords, v.exit) <= 1.2 then --exit function
                if v.disableExitPrompt then
                    -- VorpCore.NotifyRightTip("Door locked!",4000)
                else
                    DrawTxt(Config.Language.exitPrompt, 0.45, 0.85, 0.5, 0.5, true, 255, 255, 255, 150, false)
                    if IsControlJustPressed(0, Config.keys.Enter) then
                        local x, y, z = table.unpack(v.entrance)
                        SetEntityCoords(playerPed, x, y, z)
                    end
                end
            end
        end
        Citizen.Wait(1)
    end 
end)

RegisterNetEvent("juSa_teleport:jobchecked")
AddEventHandler("juSa_teleport:jobchecked", function(result)
    hasjob = result
end)

RegisterNetEvent("juSa_teleport:itemchecked")
AddEventHandler("juSa_teleport:itemchecked", function(result)
    hasitems = result
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextFontForCurrentCommand(15) 
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end