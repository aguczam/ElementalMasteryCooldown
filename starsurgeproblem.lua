if magicSquare==nil then magicSquare=CreateFrame("Frame","MovableTextureFrame",UIParent)
   magicSquare:SetMovable(true)
   magicSquare:EnableMouse(true)
   magicSquare:SetUserPlaced(true)
   magicSquare:RegisterForDrag("LeftButton")
   magicSquare:SetScript("OnDragStart", frame.StartMoving)
   magicSquare:SetScript("OnDragStop", frame.StopMovingOrSizing)
   magicSquare:SetSize(64,64)
   magicSquare:SetPoint("CENTER")
   magicSquare.texture = magicSquare:CreateTexture(nil,"ARTWORK")
   magicSquare.texture:SetAllPoints(true)
   magicSquare.texture:SetTexture(128/255,0,0,1) 
end

function getSpellTexture(spellName)
   _,_, icon = GetSpellInfo(spellName)
   
   return icon
end


if constantSpam==nil then 
   constantSpam = CreateFrame("Frame")
   constantSpam:SetScript("OnUpdate", function(self, event, ...)
         Rotation()
   end)
end

function checkDebuff(debuffName)
   debuff = 0
   for i=1,40 do
      local name = UnitDebuff("target",i)
      if name==debuffName then debuff = 1 end
   end
   return debuff
end

function checkBuff(buffName)
   debuff = 0
   for i=1,40 do
      local name = UnitBuff("player",i)
      if name==buffName then debuff = 1 end
   end
   return debuff
end



function checkMeleRange()
   inRange = IsSpellInRange("Claw", "target")
   return inRange
end

function CheckStarsurge()
   a,b=GetSpellCooldown("Starsurge")
   if a==0 and b==0 then return 1 else return 0 end
   
end




function Rotation()
   vars = { direction = "none",eclipse = false}
   local energy = UnitPower("player" , 8);
   if energy ==100 then vars.direction = "moon";         
   elseif energy == -100 then vars.direction = "sun";   
   else
      vars.direction = GetEclipseDirection() or vars.direction;
      if (vars.direction == "moon" and energy <=0) or (vars.direction == "sun"  and energy >=0) or (vars.direction == "none") then
         vars.eclipse=false;
      end
   end
   spellName=""
   print(CheckStarsurge())
   if CheckStarsurge()==0 then 
      if vars.direction=="none" and CheckStarsurge()==0 and IsSpellInRange("Wrath", "target")==1 then spellName = "Wrath" end
      if vars.direction=="moon" and CheckStarsurge()==0 and IsSpellInRange("Wrath", "target")==1 then spellName = "Wrath" end
      if vars.direction=="sun" and CheckStarsurge()==0 and and IsSpellInRange("Starfire", "target")==1 then spellName = "Starfire" end
   else
      if IsSpellInRange("Starsurge", "target")==1 then spellName = "Starsurge" end
   end
   
   if checkDebuff("Moonfire")==0 and IsSpellInRange("Moonfire", "target")==1 then spellName = "Moonfire" end
   -- if checkDebuff("Entangling Roots")==0 and IsSpellInRange("Entangling Roots", "target")==1 then spellName = "Entangling Roots" end
   --if checkBuff("Rejuvenation")==0 and checkMeleRange()==1 then spellName = "Rejuvenation" end
   --if GetSpellCooldown("War Stomp")==0 and checkMeleRange()==1 then spellName = "War Stomp" end
   --if GetSpellCooldown("Thorns")==0 and checkMeleRange()==1 then spellName = "Thorns" end
   if UnitCastingInfo("player")==nil and UnitExists("target") == 1 and  UnitHealth("target")>0 and IsResting()~=1 then 
      magicSquare.texture:SetTexture(getSpellTexture(spellName)) 
      
   end
   
end
