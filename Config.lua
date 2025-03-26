SLASH_AUTOTHANKS1 = "/at"
SLASH_AUTOTHANKS2 = "/autothanks"

SlashCmdList["AUTOTHANKS"] = function(msg)
    msg = msg:lower()
    if msg == "debug on" then
        AutoThanks.debug = true
        print("AutoThanks: Debug mode ON")
    elseif msg == "debug off" then
        AutoThanks.debug = false
        print("AutoThanks: Debug mode OFF")
    else
        InterfaceOptionsFrame_OpenToCategory(AutoThanksPanel)
        InterfaceOptionsFrame_OpenToCategory(AutoThanksPanel) -- Called twice to workaround UI bug
    end
end

-- Create the settings panel frame
local panel = CreateFrame("Frame", "AutoThanksPanel", UIParent)
panel.name = "AutoThanks"

-- This function will run when the config panel is shown
panel:SetScript("OnShow", function()
    -- Add content here in the future (like tabs/buttons)
    if not panel.initialized then
        local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", 16, -16)
        title:SetText("AutoThanks Configuration")

        panel.initialized = true
    end
end)

-- Register it with the Classic Interface Options
INTERFACEOPTIONS_ADDONCATEGORIES = INTERFACEOPTIONS_ADDONCATEGORIES or {}
table.insert(INTERFACEOPTIONS_ADDONCATEGORIES, panel)