return {
  currency = "£", -- Change to whatever you like
  realistic = false, -- Set to true if you want to disable the bank and crypto commands (Rememeber IRL you can't check your bank without going to an ATM or mobile banking)
  -- Notification Information --
  notificationInfo = {
    type = "ox",  -- qb or ox (Choose which one you prefer - implement your own notify logic if you want) 
    position = "top", -- Notify position (Only for ox_lib notify)
    title = ""
  }, 
  -- Command Information -- 
  cash = {
    commandName = "cash",
  },
  bank = {
    commandName = "bank",
  },
  crypto = {
    commandName = "crypto",
  },
}