Dim objFile
Dim Arg

Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
If WScript.Arguments.Count > 0 Then 
	For Each Arg in Wscript.Arguments 
		Arg =  Trim(Arg) 
	If InStr(Arg,".") Then 
		'Set objFile = objFSO.GetFile(Arg)

		Set regExOn = New RegExp
		regExOn.Pattern = ".*Z-[0-9].* F.*"
		regExOn.IgnoreCase = True
		regExOn.Global = True

		Set regExOff = New RegExp
		regExOff.Pattern = ".*Z[0-9].* F.*"
		regExOff.IgnoreCase = True
		regExOff.Global = True

		gcode = objFSO.OpenTextFile(Arg).ReadAll
		gcode = regExOff.replace(gcode, "M05")
		gcode = regExOn.replace(gcode, "M03")

		newFile = Split(Arg,".")(0) & "-laser." & Split(Arg,".")(1)

		Set objFile = objFSO.CreateTextFile(newFile,True)
		objFile.Write(gcode)
		MsgBox "Done!"
    Else 
    	MsgBox "File not detected. Exiting."
    End If 
    Next 
Else
	MsgBox "Drag an NC/GCode file into this VBS script to convert to laser."
End If