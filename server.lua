AddEventHandler('onResourceStart', function(resource)
	if GetCurrentResourceName() ~= 'msk_trackphone' then
        print('^1Please rename the Script to^3 msk_trackphone^0!')
        print('^1Server will be shutdown^0!')
        os.exit()
    end
end)

ESX = exports["es_extended"]:getSharedObject()
MSK = exports.msk_core:getCoreObject()

MSK.RegisterCallback('msk_trackphone:getPlayer', function(source, cb, number)
	cb(getPlayer(number, source))
end)

getPlayer = function(number, source)
    number = tostring(number)
    local identifier = 'Identifier not found'

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

        if data[1] and data[1][Config.MySQL.identifier] then
            identifier = data[1][Config.MySQL.identifier]
        end
    end

    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    TriggerClientEvent('msk_trackphone:addBlip', source, xPlayer)

    return xPlayer
end
exports('getPlayer', getPlayer)

logging = function(code, ...)
    if Config.Debug then
        local script = "[^2"..GetCurrentResourceName().."^0]"
        MSK.logging(script, code, ...)
    end
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