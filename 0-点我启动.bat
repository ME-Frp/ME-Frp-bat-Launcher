@ECHO OFF
setlocal enabledelayedexpansion
mode con cols=66 lines=30
COLOR 0E
TITLE ME FRP 启动器 SNASHOT-3.0

ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                              更新启动器ing...
ECHO.
ECHO.=---------------------------------------------------------------=

curl -o new.zip https://cdn.114514.space/Download/update/new.zip


7z.exe -y x "new.zip" -o".\"

1.bat