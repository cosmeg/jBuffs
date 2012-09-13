BUFFS_PER_ROW = 32;

BuffFrame:ClearAllPoints()
BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -13)

local MSQ = LibStub("Masque")

-- XXX new buffs aren't styled
local masqueBuffGroup = MSQ:Group("jBuffs", "buffs")
for i = 1, BUFF_MAX_DISPLAY do
  masqueBuffGroup:AddButton(_G["BuffButton" .. i])
end

local masqueWeaponBuffGroup = MSQ:Group("jBuffs", "weapon buffs")
masqueWeaponBuffGroup:AddButton(TempEnchant1)
masqueWeaponBuffGroup:AddButton(TempEnchant2)
-- XXX what is the stupid white border around these?

-- XXX does masque do fonts?
