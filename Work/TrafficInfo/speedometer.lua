function text(content, r, g, b, a)
    SetTextFont(2)
    SetTextProportional(0)
    SetTextScale(0.9, 0.9)
    SetTextColour(r, g, b, a)
    SetTextEntry("STRING")
    AddTextComponentString(content)
    DrawText(0.5, 0.9)
end
speed = 0 -- Default Speed
CreateThread(function()
    while true do
        Wait(IsPedInAnyVehicle(PlayerPedId()) and 150 or 1000)
        local speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) *2.2369 -- For KPH *3.6 For Mph *2.2369
        local speedlimit = exports['TrafficInfo']:GetSpeedLimit()
        if IsPedInAnyVehicle(PlayerPedId(), false) then

            if speed >= speedlimit then
                speed = math.floor(speed), 247, 223, 88, 255 -- Change color if speed is over 100 kph
            else
                speed = math.floor(speed), 255, 255, 255, 255 -- Default color if speed is 100 kph or less
            end
            SendNUIMessage({
                showhud = true,
                speedlimit = speedlimit,
                speed = speed,
            })
        else
            SendNUIMessage({hidehud = true})
        end
    end
end)