ESX = exports["es_extended"]:getSharedObject()
MSK = exports.msk_core:getCoreObject()

local msk_trackphone_timer = false
local Blips = {}

RegisterNetEvent('msk_trackphone:addBlip') 
AddEventHandler('msk_trackphone:addBlip', function(xPlayer)
    addBlip(xPlayer)
end)

addBlip = function(xPlayer)
    local player = GetPlayerFromServerId(xPlayer.source)
    local ped = GetPlayerPed(player)

    if not ped then return logging('debug', 'PlayerPed from ' .. xPlayer.source .. ' not found!') end
    local blip = AddBlipForEntity(ped)

    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName('STRING') 
    AddTextComponentString(('%s (%s)'):format(xPlayer.name, number))
    EndTextCommandSetBlipName(blip)

    table.insert(Blips, blip)
    startTimer()
end

startTimer = function()
    logging('debug', 'Timer started')

    craftingTimerTask = MSK.AddTimeout(Config.Time * 6000, function()
        logging('debug', 'Timer stopped')

        for k, v in pairs(Blips) do
            RemoveBlip(v)
            Blips = {}
        end
	end)
end

getPlayer = function(number)
	local xPlayer = MSK.TriggerCallback('msk_trackphone:getPlayer', number)
	return xPlayer
end
exports('getPlayer', getPlayer)

logging = function(code, ...)
    if Config.Debug then
        local script = "[^2"..GetCurrentResourceName().."^0]"
        MSK.logging(script, code, ...)
    end
end