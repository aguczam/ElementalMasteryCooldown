




local feedBackLevel = 3
local elementalMasteryCooldown = 0 
local frameFeedbackBonus = CreateFrame("Frame")
frameFeedbackBonus:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frameFeedbackBonus:SetScript("OnEvent", function(self, event,who,what)
      
      if (who=="player" and what=="Lightning Bolt") or (who=="player" and what=="Chain Lightning") then elementalMasteryCooldown = elementalMasteryCooldown - feedBackLevel end
      
end)

local frameelementalMasteryCooldown = CreateFrame("Frame")
frameelementalMasteryCooldown:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frameelementalMasteryCooldown:SetScript("OnEvent", function(self, event, _,eventName,_,unitGuid,_,_,_,_,_,_,_,spellID)
      if eventName == "SPELL_AURA_REMOVED" and unitGuid==UnitGUID("player") and spellID == 64701  then 
         elementalMasteryCooldown=GetTime()
      end
end)

local getCoolDown = function()
   timerDiff=GetTime()-elementalMasteryCooldown
   if timerDiff<180 and timerDiff>feedBackLevel then return 1 else return 0 end
end

local checkElementalMastery = function()
   buff=0
   for i=1,40 do
      local name = UnitBuff("player",i)
      if name == "Elemental Mastery" then buff=1 end
   end
   return buff
end

local getPercent = function()
   timerDiff=GetTime()-elementalMasteryCooldown
   if timerDiff<180 then return math.ceil(180-timerDiff).." s" end
   if checkElementalMastery()==1 then return "Enabled" end
   return "Ready"
end

local frame = CreateFrame("Frame", "DragFrame2", UIParent)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:SetUserPlaced(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetPoint("CENTER"); frame:SetWidth(36); frame:SetHeight(36);
local tex = frame:CreateTexture("ARTWORK");
tex:SetAllPoints();
tex:SetTexture("Interface\\Icons\\Spell_Nature_WispHeal"); 
local text = frame:CreateFontString()
text:SetDrawLayer("OVERLAY")
text:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE, MONOCHROME")
text:SetPoint("CENTER")

local constantelementalMasteryCooldown = CreateFrame("Frame")
constantelementalMasteryCooldown:SetScript("OnUpdate", function(self, event, ...)
      text:SetText(getPercent())
      if (getCoolDown()==1 or checkElementalMastery()==1) then tex:SetVertexColor(1, 0, 0, 1) else tex:SetVertexColor(1, 1, 1, 1) end
end)

print("Elemental Cooldown loaded feedback "..feedBackLevel)



