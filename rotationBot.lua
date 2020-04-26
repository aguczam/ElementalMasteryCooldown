if magicSquare==nil then magicSquare=CreateFrame("Frame","MovableTextureFrame",UIParent)
   magicSquare:SetSize(2,2)
   magicSquare:SetPoint("TOPLEFT")
   
   magicSquare.texture = magicSquare:CreateTexture(nil,"ARTWORK")
   magicSquare.texture:SetAllPoints(true)
   
   magicSquare.texture:SetTexture(128/255,0,0,1) 
end


if constantSpam==nil then 
   constantSpam = CreateFrame("Frame")
   constantSpam:SetScript("OnUpdate", function(self, event, ...)
         Rotation()
   end)
end

function Rotation()
   spell=1;
   vSnD=0;
   b={UnitBuff("player", "Slice and Dice")};
   if b[7]~=nil then vSnD=b[7]-GetTime() end;
   if GetComboPoints("player")>4 and UnitPower("player")>=35 then spell = 2 end
   if (vSnD==0 or vSnD<4) and GetComboPoints("player")>0 and UnitPower("player")>=25 then spell=3 end
   if UnitExists("target") == 1 and  UnitHealth("target")>0 and CheckInteractDistance("target", 3)==1 and IsResting()~=1 then 
      magicSquare.texture:SetTexture(spell/255,0,0,1)
   else
      magicSquare.texture:SetTexture(128/255,0,0,1) 
   end
end
