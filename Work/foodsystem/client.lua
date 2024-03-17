local Thirst = 100
local Hunger = 100

local function damagePlayer()
    ApplyDamageToPed(PlayerPedId(), 10, false)
end


local function checkLevels()
    if Hunger <= 0 or Thirst <= 0 then
        damagePlayer()
    end
end

local function stateThread()
    local tickCount = 0
    while true do
        Wait(1000)
        tickCount = tickCount + 1

        if tickCount >= 40 then
            tickCount = 0
            local randomThirst = math.random(2, 5)
            local randomHunger = math.random(2, 5)
            Thirst = Thirst - randomThirst
            Hunger = Hunger - randomHunger


            
            if Hunger <= 0 then Hunger = 0 end
            if Thirst <= 0 then Thirst = 0 end
        end

        SendNUIMessage({
            tick = true, 
            hungerLevel = Hunger,
            thirstLevel = Thirst,
        })

        checkLevels()
    end
end

Citizen.CreateThread(stateThread)

RegisterCommand('fillhunger', function(source, args, rawCommand)
    Hunger = 100
end, false)

RegisterCommand('fillthirst', function(source, args, rawCommand)
    Thirst = 100
end, false)

-- Check player in vehicle and fade out
Citizen.CreateThread(function()
    while true do
        Wait(IsPedInAnyVehicle(PlayerPedId()) and 150 or 1000)
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            SendNUIMessage({
                showhud = true,
            })
        else
            SendNUIMessage({hidehud = true})
        end
    end
end)
