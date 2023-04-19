Config = {}
----------------------------------------------------------------
Config.VersionChecker = true
Config.Debug = true
----------------------------------------------------------------
Config.Framework = 'ESX' -- Set to 'ESX' or 'QBCore'
----------------------------------------------------------------
Config.MySQL = {
    table = 'phones', -- In which table is the phonenumber located // Default ESX: 'users' // Default QB: 'players'
    phonenumber = 'phone_number', -- Column for phonenumber // Default ESX: 'phone_number' // Default QB: 'charinfo'
    identifier = 'identifier' -- identifier for table // Default ESX: 'identifier' // Default QB: 'citizenid'
}
----------------------------------------------------------------
Config.Time = 5 -- in minutes // After this time the blip gets removed