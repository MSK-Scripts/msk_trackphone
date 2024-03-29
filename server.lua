if Config.Framework:match('ESX') then -- ESX Framework
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework:match('QBCore') then -- QBCore Framework
	QBCore = exports['qb-core']:GetCoreObject()
end

getPlayer = function(number, source, track)
    number = tostring(number)
    local identifier = nil

    if Config.MySQL.phonenumber:match('charinfo') then
        local data = MySQL.query.await(('SELECT * from %s'):format(Config.MySQL.table))

        for k, v in pairs(data) do
            local charinfo = json.decode(v.charinfo)

            if tostring(charinfo.phone) == number then 
                identifier = v[Config.MySQL.identifier]
                break
            end
        end
    else
        local data = MySQL.query.await(('SELECT * from %s WHERE %s = @phonenumber'):format(Config.MySQL.table, Config.MySQL.phonenumber), {
            ["@phonenumber"] = number
        })

        if data and data[1] and data[1][Config.MySQL.identifier] then
            identifier = data[1][Config.MySQL.identifier]
        end
    end

    if track then
        MSK.Notification(source, 'Searching for number...')
        Wait(5000)
    end

    if not identifier then return MSK.Notification(source, 'Number is not registered') end
    local xPlayer, canTrack = nil, false

    if Config.Framework:match('ESX') then -- ESX Framework
        xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        local hasItem = xPlayer.getInventoryItem(Config.neededItem.item)
        if Config.neededItem and hasItem and hasItem.count > 0 then canTrack = true end
    elseif Config.Framework:match('QBCore') then -- QBCore Framework
        xPlayer = QBCore.Functions.GetPlayerByCitizenId(identifier)
        local hasItem = xPlayer.Functions.GetItemByName(item)
        if Config.neededItem and hasItem then canTrack = true end
    end

    if track then
        if not canTrack then return MSK.Notification(source, 'Could not locate the Phone. Maybe it\'s disabled.') end
        MSK.Notification(source, 'Found location of the Phone')
        MSK.Notification(xPlayer.source, 'Your position has just been tracked using your phonenumber')
    end
    TriggerClientEvent('msk_trackphone:addBlip', source, xPlayer)

    return xPlayer
end
exports('getPlayer', getPlayer)

MSK.Register('msk_trackphone:getPlayer', function(source, number, track)
	return getPlayer(number, source, track)
end)

logging = function(code, ...)
    if not Config.Debug then return end
    MSK.Logging(code, ...)
end

GithubUpdater = function()
    GetCurrentVersion = function()
	    return GetResourceMetadata( GetCurrentResourceName(), "version" )
    end
    
    local CurrentVersion = GetCurrentVersion()
    local resourceName = "^4["..GetCurrentResourceName().."]^0"

    if Config.VersionChecker then
        PerformHttpRequest('https://raw.githubusercontent.com/MSK-Scripts/msk_trackphone/main/VERSION', function(Error, NewestVersion, Header)
            print("###############################")
            if CurrentVersion == NewestVersion then
                print(resourceName .. '^2 ✓ Resource is Up to Date^0 - ^5Current Version: ^2' .. CurrentVersion .. '^0')
            elseif CurrentVersion ~= NewestVersion then
                print(resourceName .. '^1 ✗ Resource Outdated. Please Update!^0 - ^5Current Version: ^1' .. CurrentVersion .. '^0')
                print('^5Newest Version: ^2' .. NewestVersion .. '^0 - ^6Download here:^9 https://github.com/MSK-Scripts/msk_trackphone/releases/tag/v'.. NewestVersion .. '^0')
            end
            print("###############################")
        end)
    else
        print("###############################")
        print(resourceName .. '^2 ✓ Resource loaded^0')
        print("###############################")
    end
end
GithubUpdater()