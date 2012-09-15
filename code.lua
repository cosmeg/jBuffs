--- Addon Globals
-- configurable
local FONT = "Interface\\Addons\\SharedMedia_MyMedia\\fonts\\ABF.ttf"

local BUFFS_STYLED = 0
local DEBUFFS_STYLED = 0
local ENCHANTS_STYLED = 0


--- More buffs per row.
BUFFS_PER_ROW = 32
--- Move the debuff buttons up.
-- Yea, this is a hack. It's possible that this can cause ui overlaps on the
-- right side of the screen.
BUFF_BUTTON_HEIGHT = 0


--- Move buff frame to the right of the screen.
BuffFrame:ClearAllPoints()
BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -13)


--- Style buffs as they are created.
-- This technique will get new as well as existing buffs.
local MSQ = LibStub("Masque")
local masqueGroup = MSQ:Group("jBuffs", "buffs")

local function StyleButton(self)
  masqueGroup:AddButton(self)
  self.duration:SetFont(FONT, 10)
  self.count:SetFont(FONT, 16, "OUTLINE")
  local count = self.count
  count:ClearAllPoints()
  count:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
end

local function UNIT_AURA(self, event, ...)
  if ... ~= PlayerFrame.unit then return end  -- just our buffs

  while BUFFS_STYLED < BUFF_ACTUAL_DISPLAY do
    BUFFS_STYLED = BUFFS_STYLED + 1
    local button = _G["BuffButton" .. BUFFS_STYLED]
    StyleButton(button)
  end
  while DEBUFFS_STYLED < DEBUFF_ACTUAL_DISPLAY do
    DEBUFFS_STYLED = DEBUFFS_STYLED + 1
    local button = _G["DebuffButton" .. DEBUFFS_STYLED]
    StyleButton(button)
    button:SetScale(2.0)
  end
  while ENCHANTS_STYLED < BuffFrame.numEnchants do
    ENCHANTS_STYLED = ENCHANTS_STYLED + 1
    local button = _G["TempEnchant" .. ENCHANTS_STYLED]
    StyleButton(button)
    -- remove annoying white border
    _G["TempEnchant" .. ENCHANTS_STYLED .. "Border"]:Hide()
  end
end

local frame = CreateFrame("FRAME")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", UNIT_AURA)


--- Style consolidated buff frame.
StyleButton(ConsolidatedBuffs)
-- TODO change this. can I somehow use the existing icon?
ConsolidatedBuffsIcon:SetTexture("Interface\\ICONS\\ACHIEVEMENT_GUILDPERK_QUICK AND DEAD")


-- bootstrap
UNIT_AURA(nil, "UNIT_AURA", PlayerFrame.unit)
