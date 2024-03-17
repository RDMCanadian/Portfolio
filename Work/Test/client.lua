RegisterCommand('car', function(source, args, rawCommand)
    if args[1] then
        local carModel = args[1]

        RequestModel(carModel)

        while not HasModelLoaded(carModel) do
            Wait(500)
        end

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)
        local vehicle = CreateVehicle(carModel, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPed), true, true)

        SetModelAsNoLongerNeeded(carModel)
    else
        TriggerEvent('chat:addMessage', { args = {'^1Error', 'You need to specify a car model.'} })
    end
end, false)


RegisterCommand('repair' and 'fix', function(source, args, rawCommand)
    SetVehicleFixed(GetPlayersLastVehicle())
    TriggerEvent('chat:addMessage', { args = {'^5Repaired', 'Last vehicle has been repaired.'} })
end, false)


RegisterCommand('wanted', function(source, args, rawCommand)
    if tonumber(args[1]) <= 5 then
        SetPlayerWantedLevel(PlayerId(), tonumber(args[1]), false)
        TriggerEvent('chat:addMessage', { args = {'^5WANTED', 'Set Wanted level to: ' ..args[1] } })
    else 
        TriggerEvent('chat:addMessage', { args = {'^1ERROR', 'Cant set wanted level above 5'} })
    end

end, false)

RegisterCommand('slashtire', function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1) 
    local playerPedloc = GetEntityCoords(playerPed)
    local playerCar = GetClosestVehicle(playerPedloc.x, playerPedloc.y, playerPedloc.z, 20.0, 0, 2)
    local tireIndex = tonumber(args[1]) or 0
    
    if IsVehicleTyreBurst(playerCar, tireIndex, false) then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {'^1ERROR', 'Tire Already Burst...'}
        }) 
    elseif playerCar <= 0 then
        SetVehicleTyreBurst(playerCar, tireIndex, true, 1000)
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {'^1ERROR', 'Please select a correct tire (0 for all).'}
        })
    end
end, false)


RegisterCommand('clone', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)

    local playerCar = GetClosestVehicle(playerPos.x, playerPos.y, playerPos.z, 20.0, 0, 71) -- 71 is the flag for all vehicles
    if not DoesEntityExist(playerCar) then
        TriggerEvent('chat:addMessage', { args = {'^1Error', 'No vehicle found nearby.'} })
        return
    end

    local playerCarModel = GetEntityModel(playerCar)
    RequestModel(playerCarModel)

    while not HasModelLoaded(playerCarModel) do
        Wait(500)
    end

    local vehicle = CreateVehicle(playerCarModel, playerPos.x, playerPos.y, playerPos.z, playerHeading, true, false)

    if DoesEntityExist(vehicle) then
        SetVehicleEngineOn(vehicle, true, true, true) -- Turn on the engine of the cloned vehicle
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        SetModelAsNoLongerNeeded(playerCarModel)
        TriggerEvent('chat:addMessage', { args = {'^2Success', 'Vehicle cloned successfully!'} })
    else
        TriggerEvent('chat:addMessage', { args = {'^1Error', 'Failed to clone vehicle.'} })
    end
end, false)

RegisterCommand('links' and 'dc' and 'discord', function(source, args, rawCommand)
    TriggerEvent('chat:addMessage', { args = {'^1Discord:', 'https://discord.gg/pRFEprUGTf'} })
end, false)