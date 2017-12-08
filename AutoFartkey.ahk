#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#InstallKeybdHook

extensions := "mp3,wav,ogg"

Gui, Add, Text ,x5 y10, Folder Name
Gui, Add, Edit, x80 y7 w100 r1 vfolder,Farts
Gui, Add, Text, x5 y40, Probability
Gui, Add, Slider, x72 y40 w115 vchance, 100
Gui, Add, Checkbox, x5 vkeyboard Checked, Keyboard
Gui, Add, Checkbox, x5 vmouse Checked, Mouse
IniRead, count, farts.ini, farts, count, 0
Gui, Add, Text, x5 vfarts, You farted %count% times.
Gui, Add, Button, x5 w190 gsubmit Default, Start (F2 to reopen)
Gui, Show, w200 h165

Loop {
	if(running && ((A_TimeIdlePhysical<5 && keyboard) || ((GetKeyState("LButton",p) || GetKeyState("RButton",p) || GetKeyState("MButton",p) || GetKeyState("XButton1",p) || GetKeyState("XButton1",p))&&mouse))) {
		Random, rnd, 0, 100
		if rnd <= %chance%
		{
			Random,i,1,% filenames.MaxIndex()
			SoundPlay, % filenames[i]
			count++
			IniWrite, %count%, farts.ini, farts, count
		}
		Sleep, 100
	}
}

submit:
Gui, Submit
filenames := Object()
Loop %folder%\* {
	if A_LoopFileExt in %extensions%
		filenames.Insert(A_LoopFileFullPath)
}
running:=true
return

F2::
running:=false
GuiControl,,farts, You farted %count% times.
Gui, Show, w200 h185
return

GuiClose:
ExitApp