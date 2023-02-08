# MSK TrackPhone
Get the Player by PhoneNumber and add a Blip

**Discord Support:** https://discord.gg/5hHSBRHvJE

## Description
* Get the Player by Phonenumber
* Adds a Blip for the Player
* Set Time until Blip gets removed

## Export
You can use it clientside and serverside
```lua
exports.msk_trackphone:getPlayer(number)
```
**Example:**
```lua
local xPlayer = exports.msk_trackphone:getPlayer(094123456)
```

## Requirements
* [ESX 1.2 and above](https://github.com/esx-framework/esx_core)
* [oxmysql](https://github.com/overextended/oxmysql)
* [msk_core](https://github.com/MSK-Scripts/msk_core)