Config = {}
----------------------------------------------------------------
Config.VersionChecker = true
Config.Debug = true
----------------------------------------------------------------
Config.MySQL = {
    table = 'phones', -- In which table is the phonenumber located // default: 'users'
    phonenumber = 'phone_number', -- Column for phonenumber // default: 'phone_number'
    identifier = 'identifier' -- identifier for table // default: 'identifier'
}
----------------------------------------------------------------
Config.Time = 5 -- in minutes // After what time does the blip gets removed