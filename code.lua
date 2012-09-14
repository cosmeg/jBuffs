BUFFS_PER_ROW = 32;

BuffFrame:ClearAllPoints()
BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -13)
--XXX these points will be wrong; does this frame even exist?
DebuffFrame:ClearAllPoints()
DebuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -113)
--XXX
DebuffFrame:SetScale(2.0)

local MSQ = LibStub("Masque")

local masqueBuffGroup = MSQ:Group("jBuffs", "buffs")
-- TODO remove this after the OnLoad code runs early enough (below too)
for i = 1, BUFF_MAX_DISPLAY do
  masqueBuffGroup:AddButton(_G["BuffButton" .. i])
end

-- XXX this does not handle debuffs arg
oldBB_OL = BuffButton_OnLoad
function JBuffs_BuffButton_OnLoad(self)
  oldBB_OL(self)
  masqueBuffGroup:AddButton(self)
end
BuffButton_OnLoad = JBuffs_BuffButton_OnLoad


--[[
-- TODO debuffs - see that this works
-- XXX factor out some of this duplicated code?
local masqueDebuffGroup = MSQ:Group("jBuffs", "debuffs")
for i = 1, DEBUFF_MAX_DISPLAY do
  masqueDebuffGroup:AddButton(_G["DebuffButton" .. i])
end
--]]

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
