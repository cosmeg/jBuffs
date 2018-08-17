--- Addon Globals
-- configurable
local FONT = "Interface\\Addons\\SharedMedia_MyMedia\\fonts\\HelveticaNeueBold.ttf"

local BUFFS_STYLED = 0
local DEBUFFS_STYLED = 0
local ENCHANTS_STYLED = 0


--- More buffs per row.
--BUFFS_PER_ROW = 32
--XXX this taints too
--- Move the debuff buttons up.
-- Yea, this is a hack. It's possible that this can cause ui overlaps on the
-- right side of the screen.
--BUFF_BUTTON_HEIGHT = 0
-- XXX setting globals like this causes taint
-- /dump issecurevariable("BUFFS_PER_ROW")
-- is there a better way?
--TODO *moving* the debuffs shouldn't cause taint
-- hook: BuffFrame_UpdateAllBuffAnchors DebuffButton_UpdateAnchors
local function PositionDebuffs(...)
  local button = DebuffButton1
  if button then
    --print(DebuffButton1:GetPoint(1))
    local point, relativeTo, relativePoint, xOffset, yOffset = button:GetPoint(1)
    button:ClearAllPoints()
    --print(yOffset)
    button:SetPoint(point, relativeTo, relativePoint, xOffset, -30)
  end
end
hooksecurefunc("DebuffButton_UpdateAnchors", PositionDebuffs)


--- Move buff frame to the right of the screen.
local function PositionBuffFrame(...)
  --print("PositionBuffFrame")
  BuffFrame:ClearAllPoints()
  BuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -13, -13)
  -- /dump BuffFrame:GetPoint(1)
end
--hooksecurefunc("BuffFrame_OnUpdate", PositionBuffFrame)
-- not sure what keeps moving this
hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", PositionBuffFrame)


--- Style buffs as they are created.
-- This technique will get new as well as existing buffs.
local MSQ = LibStub("Masque")
local masqueGroup = MSQ:Group("jBuffs", "buffs")

local function StyleButton(button)
  masqueGroup:AddButton(button)
  button.duration:SetFont(FONT, 10)
  button.count:SetFont(FONT, 16, "OUTLINE")
  local count = button.count
  count:ClearAllPoints()
  count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
end

local function UNIT_AURA(self, event, unitID)
  if unitID ~= PlayerFrame.unit then return end  -- just our buffs

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
    _G["DebuffButton" .. DEBUFFS_STYLED .. "Border"]:Hide()
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


-- bootstrap
UNIT_AURA(nil, "UNIT_AURA", PlayerFrame.unit)
PositionBuffFrame()


-- https://us.battle.net/forums/en/wow/topic/20742625126#post-2
-- adds caster of buffs/debuffs to their tooltips
hooksecurefunc(GameTooltip,"SetUnitAura",function(self,unit,index,filter)
  local caster = select(7,UnitAura(unit,index,filter))
  if caster and UnitExists(caster) then
    GameTooltip:AddLine("Cast by: "..UnitName(caster),.65,.85,1,1)
    GameTooltip:Show()
  end
end)
