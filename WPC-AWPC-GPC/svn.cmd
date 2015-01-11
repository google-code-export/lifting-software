C:\Progra~1\TortoiseSVN\bin\svn.exe update %~dp0
IF NOT %ERRORLEVEL% == 0 GOTO END

C:\Progra~2\TortoiseSVN\bin\svn.exe update %~dp0
IF NOT %ERRORLEVEL% == 0 GOTO END

REM here goes the rest of the script

:END
start %~dp0fontsAdd.vbs