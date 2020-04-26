editBox = CreateFrame("EditBox", "logEditBox", buyFrame, "InputBoxTemplate")
editBox:SetFrameStrata("DIALOG")
editBox:SetSize(300,300)
editBox:SetAutoFocus(false)
editBox:SetText("")
editBox:SetPoint("TOPLEFT", 30, -30)

function toEditBox(text)
   editBox:SetText(text)
end
