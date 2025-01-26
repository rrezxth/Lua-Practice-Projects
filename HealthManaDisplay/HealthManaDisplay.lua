-- Using SavedVariables data
MyAddonSettings = MyAddonSettings or {}

-- Create the parent frame
local healthManaFrame = CreateFrame("Frame", "HealthManaDisplay", UIParent)
healthManaFrame:SetSize(MyAddonSettings.width or 100, MyAddonSettings.height or 50)
healthManaFrame:SetPoint(MyAddonSettings.point or "CENTER", UIParent, MyAddonSettings.x or 0, MyAddonSettings.y or 0)

-- Add basic background texture
local bgTexture = healthManaFrame:CreateTexture(nil, "BACKGROUND")
bgTexture:SetAllPoints(healthManaFrame)
bgTexture:SetColorTexture(0, 0, 0, 0.5)

-- Set mouse operations
healthManaFrame:EnableMouse(true)
healthManaFrame:SetMovable(true)

healthManaFrame:RegisterForDrag("LeftButton")

healthManaFrame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
healthManaFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    -- Save position
    local point, _, _, x, y = self:GetPoint()
    MyAddonSettings.point = point
    MyAddonSettings.x = x
    MyAddonSettings.y = y
end)

-- Create font strings for dynamic health and mana
local healthText = healthManaFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
healthText:SetPoint("TOPLEFT", 10, -10)
local manaText = healthManaFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
manaText:SetPoint("TOPLEFT", 10, -30)

-- Listener events for changes in health and mana
healthManaFrame:RegisterEvent("UNIT_HEALTH")
healthManaFrame:RegisterEvent("UNIT_POWER_UPDATE")

-- Initialize correct health/values on login/reload
healthManaFrame:RegisterEvent("PLAYER_ENTERING_WORLD") 

-- Function that updates health/mana values
local function UpdateHealthMana()
    local health = UnitHealth("player")
    local mana = UnitPower("player", Enum.PowerType.Mana)
    healthText:SetText("Health: " .. health)
    manaText:SetText("Mana: " .. mana)
end

-- Set the script that handles the vents
healthManaFrame:SetScript("OnEvent", function(self, event, unit)
    if event == "PLAYER_ENTERING_WORLD" or unit == "player" then 
        UpdateHealthMana()
    end
end)