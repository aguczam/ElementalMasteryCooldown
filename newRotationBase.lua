if magicSquare==nil then magicSquare=CreateFrame("Frame","MovableTextureFrame",UIParent)
   magicSquare:SetMovable(true)
   magicSquare:EnableMouse(true)
   magicSquare:SetUserPlaced(true)
   magicSquare:RegisterForDrag("LeftButton")
   magicSquare:SetScript("OnDragStart", frame.StartMoving)
   magicSquare:SetScript("OnDragStop", frame.StopMovingOrSizing)
   magicSquare:SetSize(64,64)
   magicSquare:SetPoint("TOPLEFT")
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

function Rotation()
   spellName=""
   if GetSpellCooldown("Starsurge")==0 then spellName="Starsurge" end
   magicSquare.texture:SetTexture(getSpellTexture(spellName)) 
end
