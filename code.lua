-- addon globals
local BUFFS_STYLED = 0
local DEBUFFS_STYLED = 0


BUFFS_PER_ROW = 32

-- move buff frame to the right of the screen
BuffFrame:ClearAllPoints()
BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -13)
--XXX these points are probably wrong
--XXX does this frame even exist?
DebuffFrame:ClearAllPoints()
DebuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -113)

--XXX this may need to be set per-icon?
DebuffFrame:SetScale(2.0)

local MSQ = LibStub("Masque")
local masqueGroup = MSQ:Group("jBuffs", "buffs")

local function UnitAura(self, event, ...)
  local unit = ...;
  if unit ~= PlayerFrame.unit then return end

  while BUFFS_STYLED < BUFF_ACTUAL_DISPLAY do
    BUFFS_STYLED = BUFFS_STYLED + 1
    masqueGroup:AddButton(_G["BuffFrame" .. BUFFS_STYLED])
  end
  while DEBUFFS_STYLED < DEBUFF_ACTUAL_DISPLAY do
    DEBUFFS_STYLED = DEBUFFS_STYLED + 1
    masqueGroup:AddButton(_G["DebuffFrame" .. DEBUFFS_STYLED])
  end
end

local frame = CreateFrame("FRAME")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", UnitAura)


-- TODO add weapon buffs to the above, unless disabling the border matters
local masqueWeaponBuffGroup = MSQ:Group("jBuffs", "weapon buffs")
masqueWeaponBuffGroup:AddButton(TempEnchant1)
masqueWeaponBuffGroup:AddButton(TempEnchant2)
-- XXX what is the stupid white border around these?

oldTEB_OL = TempEnchantButton_OnLoad
function JBuffs_TempEnchantButton_OnLoad(self)
  oldTEB_OL(self)
  masqueWeaponBuffBuffGroup:AddButton(self)
end
TempEnchantButton_OnLoad = JBuffs_TempEnchantButton_OnLoad


-- TODO fonts, text positioning
