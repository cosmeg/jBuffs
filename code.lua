BUFFS_PER_ROW = 32;

BuffFrame:ClearAllPoints()
BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -13)

local MSQ = LibStub("Masque")
local masqueGroup = MSQ:Group("jBuffs", "buffs")
for i = 1, BUFF_MAX_DISPLAY do
  masqueGroup:AddButton(_G["BuffButton" .. i])
end
