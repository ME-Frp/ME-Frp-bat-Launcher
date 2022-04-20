@ECHO OFF
set "%frpname%"=="%1"
set "%frpaddress%"=="%2"
set "frpwindow"=="%3"
cd /D %~dp0
mode con cols=62 lines=16
TITLE ME FRP：%frpname%

CLS
ECHO.
ECHO.
ECHO.启动隧道%frpname%： %frpaddress%
ECHO.
ECHO.
echo.%frpaddress%>addrtmp.txt
clip < addrtmp.txt
del addrtmp.txt 1>nul 2>nul
COLOR 2F
ECHO.下方出现 start proxy success 即为隧道启动成功，否则隧道尚未启动。地址已复制到剪贴板。关闭此窗口即关闭隧道。
del ..\..\noticeoff 1>nul 2>nul
frpc-%frpname%.exe -c frpc.ini
::能走到这里说明frpc程序已停止运行
if exist ..\..\noticeoff del ..\..\noticeoff & EXIT
if "%frpwindow%"=="off" msg %username% "ME_FRP：隧道%frpname%已停止运行！这可能是由于隧道启动失败或程序被结束。" & EXIT
ECHO.
COLOR 4F
ECHO.frpc.exe程序已停止运行！这可能是由于隧道启动失败或程序被结束。
pause>nul
EXIT