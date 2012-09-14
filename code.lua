--- Addon Globals
local BUFFS_STYLED = 0
local DEBUFFS_STYLED = 0
local ENCHANTS_STYLED = 0


--- More buffs per row.
BUFFS_PER_ROW = 32


--- Move buff frame to the right of the screen.
BuffFrame:ClearAllPoints()
BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -13)


--- Style buffs as they are created.
-- This technique will get new as well as existing buffs.
local MSQ = LibStub("Masque")
local masqueGroup = MSQ:Group("jBuffs", "buffs")

local function StyleButton(self)
  --print(self)
  masqueGroup:AddButton(self)
  -- TODO fonts, text positioning
end

local function UNIT_AURA(self, event, ...)
  if ... ~= PlayerFrame.unit then return end  -- just our buffs

  --print("UNIT_AURA")
  --print("BUFFS_STYLED: " .. BUFFS_STYLED)

  while BUFFS_STYLED < BUFF_ACTUAL_DISPLAY do
    BUFFS_STYLED = BUFFS_STYLED + 1
    print("BuffFrame" .. BUFFS_STYLED)
    local button = _G["BuffButton" .. BUFFS_STYLED]
    if button then
      StyleButton(button)
    else
      print("XXX no button?")
    end
  end
  while DEBUFFS_STYLED < DEBUFF_ACTUAL_DISPLAY do
    DEBUFFS_STYLED = DEBUFFS_STYLED + 1
    local button = _G["DebuffButton" .. DEBUFFS_STYLED]
    StyleButton(button)
    button:SetScale(2.0)
  end
  while ENCHANTS_STYLED < BuffFrame.numEnchants do
    ENCHANTS_STYLED = ENCHANTS_STYLED + 1
    StyleButton(_G["TempEnchant" .. ENCHANTS_STYLED])
    _G["TempEnchant" .. ENCHANTS_STYLED .. "Border"]:Hide()
  end
end

local frame = CreateFrame("FRAME")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", UNIT_AURA)

-- bootstrap
UNIT_AURA(nil, "UNIT_AURA", PlayerFrame.unit)
