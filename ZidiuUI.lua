local PastebinURL = "https://pastebin.com/raw/e3bYUdLj" 

local success, result = pcall(function()
    return game:HttpGet(PastebinURL)
end)

if success then
    local func = loadstring(result)
    if func then
        func()
    else
        warn("Error: Loadstring failed - The pastebin does not contain valid Lua code")
    end
else
    warn("Error loading Pastebin: ", result)
end
