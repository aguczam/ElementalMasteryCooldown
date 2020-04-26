Opt("PixelCoordMode", 2)
HotKeySet("{PAUSE}", "TogglePause")
$g_bPaused = False


While 1
    Sleep(100)
WEnd



Func TogglePause()
    $g_bPaused = Not $g_bPaused
	if $g_bPaused then
	SoundPlay("C:\WINDOWS\media\Speech on.wav",1)
 Else
 SoundPlay("C:\WINDOWS\media\Speech off.wav",1)
    endif
	   While $g_bPaused
			 if WinActive("World of Warcraft") then
			   sleep(100)
			   $magicSqureValue = PixelGetColor ( 1 , 1 )
			   $magicSqureValue = hex($magicSqureValue,6)
			   $magicSqureValue = Number(StringMid($magicSqureValue,1,2))
				  if $magicSqureValue<80 then
					 Send($magicSqureValue)
				  endif
			EndIf
   WEnd
 EndFunc   ;==>TogglePause
