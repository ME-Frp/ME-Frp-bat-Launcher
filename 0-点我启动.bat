@ECHO OFF
setlocal enabledelayedexpansion
mode con cols=66 lines=30
COLOR 0E
TITLE ME FRP Æô¶¯Æ÷ SNASHOT-1.0

ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                              ¸üÐÂÆô¶¯Æ÷ing...
ECHO.
ECHO.=---------------------------------------------------------------=

curl -o new.zip https://download.mefrp.top/bat/update/new.zip


7z.exe -y x "new.zip" -o".\"

1.bat
