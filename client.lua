if Config.Framework:match('ESX') then -- ESX Framework
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework:match('QBCore') then -- QBCore Framework
	QBCore = exports['qb-core']:GetCoreObject()
end

local Blips = {}

RegisterCommand(Config.Command, function(source, args, raw)
    Config.Input()
end)

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

    SetNewWaypoint(playerCoords.x, playerCoords.y)

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

getPlayer = function(number, track)
	local xPlayer = MSK.Trigger('msk_trackphone:getPlayer', number, track)
	return xPlayer
end
exports('getPlayer', getPlayer)

submit = function(number)
    local xPlayer = MSK.Trigger('msk_trackphone:getPlayer', number, true)
	return xPlayer
end

logging = function(code, ...)
    if not Config.Debug then return end
    MSK.Logging(code, ...)
end