if Config.Framework:match('ESX') then -- ESX Framework
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework:match('QBCore') then -- QBCore Framework
	QBCore = exports['qb-core']:GetCoreObject()
end

local Blips = {}

RegisterNetEvent('msk_trackphone:addBlip') 
AddEventHandler('msk_trackphone:addBlip', function(xPlayer)
    addBlip(xPlayer)
end)

addBlip = function(xPlayer)
    local playerSource = 0
    local playerName = 'Unknown Unknown'
    local playerCoords = nil

    if Config.Framework:match('ESX') then -- ESX Framework
        playerSource = xPlayer.source
        playerName = xPlayer.name
        playerCoords = xPlayer.coords
    elseif Config.Framework:match('QBCore') then -- QBCore Framework
        playerSource = xPlayer.PlayerData.source
        playerName = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
        playerCoords = xPlayer.PlayerData.position
    end

    local blip = AddBlipForCoord(playerCoords.x, playerCoords.y, playerCoords.z) 

    SetBlipSprite(blip, Config.Blip.id)
    SetBlipScale(blip, Config.Blip.scale)
    SetBlipColour(blip, Config.Blip.color)
    BeginTextCommandSetBlipName('STRING') 
    AddTextComponentString(playerName)
    EndTextCommandSetBlipName(blip)

    table.insert(Blips, blip)
    startTimer()
end

startTimer = function()
    logging('debug', 'Timer started')

    local timeout = MSK.AddTimeout(Config.Time * 60000, function()
        logging('debug', 'Timer stopped. Remove Player Blip...')

        for k, v in pairs(Blips) do
            RemoveBlip(v)
        end
        Blips = {}
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