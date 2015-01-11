Option Explicit
' Installing multiple Fonts in Windows 7
' http://www.cloudtec.ch 2011
 
Dim objShell, objFSO, wshShell
Dim strFontSourcePath, strWinFontsFolder, objFolder, objFont, objNameSpace, objFile
 
Set objShell = CreateObject("Shell.Application")
Set wshShell = CreateObject("WScript.Shell")
Set objFSO = createobject("Scripting.Filesystemobject")

if ((objShell is nothing) or (wshShell is nothing) or (objFSO is nothing)) then WScript.Quit(1)

strWinFontsFolder  = objFSO.GetSpecialFolder(0)

'Wscript.Echo strWinFontsFolder&"\Fonts\"

strFontSourcePath = ".\extscr\fonts"
 
If objFSO.FolderExists(strFontSourcePath) Then
 
Set objNameSpace = objShell.Namespace(objFSO.GetAbsolutePathName(strFontSourcePath))
Set objFolder = objFSO.getFolder(strFontSourcePath)

if ((objNameSpace is nothing) or (objFolder is nothing)) then WScript.Quit(1)

 
For Each objFile In objFolder.files
    If LCase(right(objFile,4)) = ".ttf" OR LCase(right(objFile,4)) = ".otf" Then
        If objFSO.FileExists(strWinFontsFolder & objFile.Name) Then
            Wscript.Echo "Font already installed: " & objFile.Name
        Else
'            Wscript.Echo objFile.Name
'            Wscript.Echo objNameSpace.title
			Set objFont = objNameSpace.ParseName(objFile.Name)
            objFont.InvokeVerb("Install")
'            Wscript.Echo "Installed Font: " & objFile.Name
            Set objFont = Nothing
        End If
    End If
    Next
    Else
        Wscript.Echo "Font Source Path does not exists"
    End If