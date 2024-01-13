local config = require "config"

-- Functions -- 
local function moneyNotify(source, title, description, typeOfNotification)
    if config.notificationInfo.type == "ox" then
        lib.notify(source, {
            title = config.notificationInfo.title,
            description = description,
            type = typeOfNotification,
            position = config.notificationInfo.position
        })
    elseif config.notificationInfo.type == "qb" then
        exports.qbx_core:Notify(source, description, typeOfNotification)
    end
end

local function getPlayerValuables(source, type)
    local moneyTypeMap = {
        cash = "cash",
        bank = "bank",
        crypto = "crypto",
    }
    if moneyTypeMap[type] then
        local amount = exports.qbx_core:GetPlayer(source).PlayerData.money[moneyTypeMap[type]]
        if amount > 0 then
            local formattedAmountWithCommas = string.format("%s", string.format("%d", tonumber(amount)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))
            moneyNotify(source, config.notificationInfo.title, "Your current " .. type .. " amount: " .. config.currency .. formattedAmountWithCommas, "success")
        else
            moneyNotify(source, config.notificationInfo.title, "Your "..type.." is currently empty..", "error")
        end
    end
end

-- Commands --
lib.addCommand(config.cash.commandName, {
    help = 'Check how much cash is in your pockets',
}, function(source)
    getPlayerValuables(source, "cash")
end)

if not config.realistic then
lib.addCommand(config.bank.commandName, {
    help = 'Check your current bank amount',
}, function(source)
    getPlayerValuables(source, "bank")
end)

lib.addCommand(config.crypto.commandName, {
    help = 'Check how much crypto you have currently',
}, function(source)
    getPlayerValuables(source, "crypto")
end)
end