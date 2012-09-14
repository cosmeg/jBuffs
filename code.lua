--- Addon Globals
local BUFFS_STYLED = 0
local DEBUFFS_STYLED = 0
local ENCHANTS_STYLED = 0


--- More buffs per row.
BUFFS_PER_ROW = 32


--- Move buff frame to the right of the screen.
BuffFrame:ClearAllPoints()
BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -13)
--XXX these points are probably wrong
--XXX does this frame even exist?
DebuffFrame:ClearAllPoints()
DebuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -113)


--- Make debuffs larger.
--XXX this may need to be set per-icon?
DebuffFrame:SetScale(2.0)


--- Style buffs as they are created.
-- This technique will get new as well as existing buffs.
local MSQ = LibStub("Masque")
local masqueGroup = MSQ:Group("jBuffs", "buffs")

local function UNIT_AURA(self, event, ...)
  if ... ~= PlayerFrame.unit then return end

  while BUFFS_STYLED < BUFF_ACTUAL_DISPLAY do
    BUFFS_STYLED = BUFFS_STYLED + 1
    masqueGroup:AddButton(_G["BuffFrame" .. BUFFS_STYLED])
  end
  while DEBUFFS_STYLED < DEBUFF_ACTUAL_DISPLAY do
    DEBUFFS_STYLED = DEBUFFS_STYLED + 1
    masqueGroup:AddButton(_G["DebuffFrame" .. DEBUFFS_STYLED])
  end
  while ENCHANTS_STYLED < BuffFrame.numEnchants do
    ENCHANTS_STYLED = ENCHANTS_STYLED + 1
    masqueGroup:AddButton(_G["TempEnchant" .. ENCHANTS_STYLED])
    -- XXX what is the stupid white border around these?
  end
end

local frame = CreateFrame("FRAME")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", UNIT_AURA)


-- TODO fonts, text positioning
-- perhaps done above
