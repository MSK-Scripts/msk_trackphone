# MSK TrackPhone
Get the Player by PhoneNumber and add a Blip

**FiveM Forum:** https://forum.cfx.re/t/release-esx-secretblips-make-blips-visible-with-an-item/4795682

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
* ESX 1.2 or above
* oxmysql
* msk_core