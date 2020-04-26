if magicSquare==nil then magicSquare=CreateFrame("Frame","MovableTextureFrame",UIParent)
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

spellName = "War Stomp"
magicSquare.texture:SetTexture(getSpellTexture(spellName)) 
