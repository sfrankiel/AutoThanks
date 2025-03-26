AutoThanks = {}
AutoThanks.debug = false
AutoThanks.messages = {
    "Thanks for the buff!",
    "Much appreciated!",
    "You’re awesome, thanks!",
    "Grateful for the buff, cheers!",
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", function(self, event, unit)
    if unit ~= "player" then return end
    AutoThanks:CheckBuffs()
end)

local previousBuffs = {}

function AutoThanks:CheckBuffs()
    for i = 1, 40 do
        local name, _, _, _, _, _, _, sourceUnit = UnitAura("player", i)
        if not name then break end

        if sourceUnit and UnitIsPlayer(sourceUnit) and sourceUnit ~= "player" then
            if not previousBuffs[name] then
                AutoThanks:SendThanks(sourceUnit)
            end
            previousBuffs[name] = true
        end
    end
end

function AutoThanks:SendThanks(target)
    local msg = AutoThanks.messages[math.random(#AutoThanks.messages)]
    if AutoThanks.debug then
        print("[AutoThanks] Sending message to " .. target .. ": " .. msg)
    end
    local method = AutoThanks.sendMethod or "SAY"
    if method == "WHISPER" then
        SendChatMessage(msg, "WHISPER", nil, target)
    elseif method == "EMOTE" then
        DoEmote(msg, target)
    else
        SendChatMessage(msg, "SAY")
    end
end