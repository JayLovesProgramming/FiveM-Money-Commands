local config = require "config"

-- Functions -- 
local function moneyNotify(source, data)
    if config.notificationInfo.type == "ox" then
        lib.notify(source, {
            title = data[1],
            description = data[2],
            type = data[3],
            duration = 3000,
            position = config.notificationInfo.position
        }) 
    elseif config.notificationInfo.type == "qb" then
        exports.qbx_core:Notify(source, data[2], data[3], 3500)
    end
end

local function getPlayerValuables(source, type)
    local src = source
    local moneyTypeMap = {
        cash = "cash",
        bank = "bank",
        crypto = "crypto",
    }
    if moneyTypeMap[type] then
        local amount = exports.qbx_core:GetPlayer(src).PlayerData.money[moneyTypeMap[type]]
        if amount > 0 then
            local formattedAmountWithCommas = string.format("%s", string.format("%d", tonumber(amount)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))
            moneyNotify(src, {config.notificationInfo.title, "Your current " .. type .. " amount: " .. config.currency .. formattedAmountWithCommas, "success"})
        else
            moneyNotify(src, {config.notificationInfo.title, "Your "..type.." is currently empty..", "error"})
        end
    end
end

-- Commands --
lib.addCommand(config.cash.commandName, {
    help = 'Check how much cash is in your pockets',
}, function(source)
    local src = source
    getPlayerValuables(src, "cash")
end)

if not config.realistic then
lib.addCommand(config.bank.commandName, {
    help = 'Check your current bank amount',
}, function(source)
    local src = source
    getPlayerValuables(src, "bank")
end)

lib.addCommand(config.crypto.commandName, {
    help = 'Check how much crypto you have currently',
}, function(source)
    local src = source
    getPlayerValuables(src, "crypto")
end)
end
