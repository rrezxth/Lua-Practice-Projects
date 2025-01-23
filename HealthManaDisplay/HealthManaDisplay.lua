-- Create parent frame
local healthManaFrame = CreateFrame("Frame", "HealthManaDisplay", UIParent)
healthManaFrame:SetSize(200, 50)
healthManaFrame:SetPoint("CENTER", UIParent, "CENTER")
healthManaFrame:EnableMouse(false)

-- Create font strings
local healthText = healthManaFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
healthText:SetPoint("TOPLEFT", 10, -10)
local manaText = healthManaFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
manaText:SetPoint("TOPLEFT", 10, -30)

-- Listener events for changes in health and mana
healthManaFrame:RegisterEvent("UNIT_HEALTH")
healthManaFrame:RegisterEvent("UNIT_POWER_UPDATE")

-- Function that updates health/mana values
local function UpdateHealthMana()
    local health = UnitHealth("player")
    local mana = UnitPower("player", Enum.PowerType.Mana)
    healthText:SetText("Health: " .. health)
    manaText:SetText("Mana: " .. mana)
end

-- Initialize correct health/values at the beginning
UpdateHealthMana()

-- Set the script that handles the vents
healthManaFrame:SetScript("OnEvent", function(self, event, unit)
    if unit == "player" then
        UpdateHealthMana()
    end
end)