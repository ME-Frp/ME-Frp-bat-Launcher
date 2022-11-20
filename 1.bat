@ECHO OFF
setlocal enabledelayedexpansion
mode con cols=66 lines=30
COLOR 0E
TITLE ME FRP 启动器 SNASHOT-3.0 MAX#27

:START
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                              MEFrp
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO. 1.启动/关闭隧道（默认）
ECHO.
ECHO. 2.导入/更新配置（会删除当前所有配置文件）
ECHO.
ECHO. 3.重置FRP程序
ECHO.
ECHO. 4.输入/更改用户密钥
ECHO.
ECHO. 5.使用说明
ECHO.
ECHO. 6.访问官网
ECHO.
ECHO.  ? 2022 MCServerX网络MEFRP运行组和酷安@某贼保留一切权利.
set choice=1
set /p choice= 输入数字按Enter继续：
if "%choice%"=="1" goto STARTFRP
if "%choice%"=="2" goto EDITINI
if "%choice%"=="3" goto RESETLAUNCHER
::if "%choice%"=="4" start https://mefrp.cn/?page=panel&module=addproxy & echo.逆向32038正向32032>tmp.txt & clip < tmp.txt & del tmp.txt
if "%choice%"=="4" goto USERKEY
if "%choice%"=="5" goto INSTRUCTION
if "%choice%"=="6" start https://mefrp.cn/
goto START

:USERKEY
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                        输入/更改用户密钥
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.注意！请勿在此页面拍照、截屏、录屏，用户密钥等同于账户密码，泄露会导致严重后果！
ECHO.
set userkey=blank
set /p userkey= 请输入用户密钥：
if "%userkey%"=="blank" msg %username% "未输入任何值，用户密钥保持不变。" & goto START
echo.set userkey=%userkey%>config\userkey.bat
call config\userkey.bat
msg %username% "已保存用户密钥。"
goto START

:INSTRUCTION
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                     ME FRP 启动器 使用说明
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.
ECHO. 首先你需要访问 MEFrp 官网，注册一个账号。
ECHO. https://mefrp.cn
ECHO.
ECHO. 然后请点击网页左侧 创建隧道 栏目，创建你的隧道。
ECHO.
ECHO. 然后请使用主菜单 导入/更新配置 功能，导入你的配置。
ECHO.
ECHO. 成功导入后，就可以使用启动器启动隧道啦！
ECHO.
ECHO. 重置FRP程序功能的说明：为了实现隧道多开，初次启动隧道时会将FRP相  关程序解压到配置文件所在目录。如果程序意外损坏，可以使用此功能重  置。
ECHO.
ECHO.
ECHO.bat脚本作者：酷安@某贼。按任意键返回主菜单。
pause>nul
goto START

:RESETLAUNCHER
for /R 配置文件 %%f in (*.exe) do del %%f
for /R 配置文件 %%f in (*.bat) do del %%f
for /R 配置文件 %%f in (*.vbs) do del %%f
goto START

:STARTFRP
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                            启动隧道
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
if not exist 配置文件\列表.txt ECHO.找不到配置文件列表！请先使用 导入/更新配置 功能。按任意键回主菜单。 & pause>nul & goto START
ECHO.启动关闭隧道请输入隧道编号，若隧道未启动则启动，已启动则关闭。
ECHO.启动隧道时会自动复制地址到剪贴板。
ECHO.不输入直接按Enter刷新隧道状态。长时间离开后请先刷新状态再操作。
ECHO.
set frpnumtotal=blank
for /f "tokens=1 delims= " %%i in ('findstr "隧道" 配置文件\列表.txt') do set frpnumtotal=%%i
if "%frpnumtotal%"=="blank" ECHO.配置文件列表中无隧道！请先使用 导入/更新配置 功能。按任意键回主菜单。 & pause>nul & goto START
set frpnum=0
:STARTFRP-2
set /a frpnum+=1
if %frpnum% GTR %frpnumtotal% goto STARTFRP-3
for /f "tokens=3 delims= " %%i in ('findstr "隧道%frpnum%" 配置文件\列表.txt') do set frpname=%%i
for /f "tokens=4 delims= " %%i in ('findstr "隧道%frpnum%" 配置文件\列表.txt') do set frpaddress=%%i
TASKLIST /FI "IMAGENAME eq frpc-%frpname%.exe" | find "没有运行的任务匹配指定标准" 1>nul 2>nul
if "%errorlevel%"=="0" ECHO.%frpnum%.启动隧道%frpname% %frpaddress% & goto STARTFRP-2
ECHO.%frpnum%.[运行中]关闭隧道%frpname% %frpaddress%
goto STARTFRP-2
:STARTFRP-3
ECHO.
if not exist config\frpwindow.bat echo.set frpwindow=off>config\frpwindow.bat
set frpwindow=blank
call config\frpwindow.bat
if "%frpwindow%"=="blank" echo.set frpwindow=off>config\frpwindow.bat & goto STARTFRP-3
if "%frpwindow%"=="off" ECHO.A.显示隧道运行窗口（当前设置为隐藏窗口）
if "%frpwindow%"=="on" ECHO.A.隐藏隧道运行窗口（当前设置为显示窗口）
ECHO.B.关闭所有隧道
ECHO.C.回主菜单
ECHO.
ECHO.
set choice=refresh
set /p choice= 输入选项按Enter继续：
if "%choice%"=="refresh" goto STARTFRP
if "%choice%"=="A" call :startfrp-4 & goto STARTFRP
if "%choice%"=="a" call :startfrp-4 & goto STARTFRP
if "%choice%"=="B" echo.noticeoff>noticeoff & taskkill /f /im frpc-* & TIMEOUT /T 1 /NOBREAK>nul & goto STARTFRP
if "%choice%"=="b" echo.noticeoff>noticeoff & taskkill /f /im frpc-* & TIMEOUT /T 1 /NOBREAK>nul & goto STARTFRP
if "%choice%"=="C" goto START
if "%choice%"=="c" goto START
find "隧道%choice%" "配置文件\列表.txt" 1>nul 2>nul
if not "%errorlevel%"=="0" ECHO. & ECHO.输入错误或隧道不存在！请输入隧道编号如1，2，3。按任意键重新输入。 & pause>nul & goto STARTFRP
for /f "tokens=3 delims= " %%i in ('findstr "隧道%choice%" 配置文件\列表.txt') do set frpname=%%i
for /f "tokens=4 delims= " %%i in ('findstr "隧道%choice%" 配置文件\列表.txt') do set frpaddress=%%i
TASKLIST /FI "IMAGENAME eq frpc-%frpname%.exe" | find "没有运行的任务匹配指定标准" 1>nul 2>nul
if not "%errorlevel%"=="0" echo.noticeoff>noticeoff & taskkill /f /im frpc-%frpname%.exe & TIMEOUT /T 1 /NOBREAK>nul & goto STARTFRP
if not exist 配置文件\%frpname%\frpc.ini ECHO. & ECHO.找不到指定隧道的配置文件！请更换隧道或导入/更新配置。 & pause & goto STARTFRP
if not exist 配置文件\%frpname%\frpc-%frpname%.exe 7z.exe x "program.zip" -o"配置文件\%frpname%\" -y & ren 配置文件\%frpname%\frpc.exe frpc-%frpname%.exe
if not exist 配置文件\%frpname%\startfrp.vbs 7z.exe x "program.zip" -o"配置文件\%frpname%\" -y
if "%frpwindow%"=="off" cd 配置文件\%frpname%\ & start startfrp.vbs %frpname% %frpaddress% & cd /D %~dp0
if "%frpwindow%"=="on" start 配置文件\%frpname%\startfrp.bat %frpname% %frpaddress%
TIMEOUT /T 1 /NOBREAK>nul
goto STARTFRP

:startfrp-4
if "%frpwindow%"=="off" echo.set frpwindow=on>config\frpwindow.bat
if "%frpwindow%"=="on" echo.set frpwindow=off>config\frpwindow.bat
goto :eof

:EDITINI
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                          导入/更新配置
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.
ECHO.导入前会自动备份并删除当前所有配置，如果需要可以选择恢复。
ECHO.备份文件只会保留一个，如有新的备份则会覆盖旧的。
ECHO.
ECHO.
ECHO.1.自动导入(推荐)      3.从旧版本导入
ECHO.
ECHO.4.恢复上一次的备份   5.回主菜单
ECHO.
ECHO.
set choice=1
set /p choice= 输入数字按Enter继续：
if "%choice%"=="1" goto EDITINI-E
if "%choice%"=="2" goto EDITINI-C
if "%choice%"=="3" goto EDITINI-B
if "%choice%"=="4" goto EDITINI-D
if "%choice%"=="5" goto START
goto EDITINI

:EDITINI-E
call :editini-clean
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                          导入/更新配置
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
set userkey=blank
call config\userkey.bat
if "%userkey%"=="blank" ECHO.你尚未输入用户密钥，按任意键输入。 & pause>nul & goto USERKEY
ECHO.默认使用已输入的用户密钥，如需更改请在主菜单操作。
ECHO.若获取不到任何隧道，可能原因：未建立隧道、用户密钥错误、网络原因
ECHO.
ECHO.[i]将逐个连接服务器获取隧道列表，速度取决于官网和你的网络。


set nodenum=9
call :editini-9
call createini.bat

set nodenum=10
call :editini-9
call createini.bat

set nodenum=14
call :editini-9
call createini.bat

set nodenum=15
call :editini-9
call createini.bat

set nodenum=18
call :editini-9
call createini.bat

set nodenum=19
call :editini-9
call createini.bat

set nodenum=21
call :editini-9
call createini.bat

set nodenum=23
call :editini-9
call createini.bat

set nodenum=24
call :editini-9
call createini.bat

set nodenum=26
call :editini-9
call createini.bat

set nodenum=27
call :editini-9
call createini.bat

set nodenum=28
call :editini-9
call createini.bat

set nodenum=29
call :editini-9
call createini.bat

set nodenum=30
call :editini-9
call createini.bat

set nodenum=32
call :editini-9
call createini.bat

ECHO.
ECHO.完成。按任意键回主菜单。
pause>nul
goto START

:editini-9
curl "https://api.mefrp.cn/?action=getconf&&apitoken=MEFRPToken|%nodenum%&token=%userkey%&node=%nodenum%" 1>>配置文件\tmp2.txt 2>nul
@(for /f "delims=" %%i in (配置文件\tmp2.txt) do @(set /p a=%%i<nul&echo.))>>配置文件\tmp.txt
del 配置文件\tmp2.txt
goto :eof




:EDITINI-C
call :editini-clean
for /f %%i in (address.txt) do set address=%%i>nul
start "" "%address%"
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                          导入/更新配置
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.
ECHO.已打开官方配置文件获取页面。如果没有登陆，请登录后复制下方网址并使用浏览器打开。
ECHO.
type address.txt & ECHO.
ECHO.
ECHO.打开后请选择服务器，复制下方配置文件内容，然后按任意键继续。
ECHO.
pause>nul
:EDITINI-1
del 配置文件\tmp.txt 1>nul 2>nul
set server_addr=blank
set remote_port=blank
call getclickboard.vbs1
move tmp.txt 配置文件\ 1>nul
ECHO.已保存剪贴板内容。分析中...
call createini.bat
ECHO.
ECHO.
ECHO.如果想继续添加配置，请选择下一个服务器，复制配置并按Enter继续。
ECHO.
ECHO.1.继续添加下一个服务器配置(默认)   2.结束
ECHO.
set choice=1
set /p choice= 输入数字按Enter继续：
if "%choice%"=="2" del 配置文件\tmp.txt & goto START
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                          导入/更新配置
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.
goto EDITINI-1



:EDITINI-B
call :editini-clean
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                          导入/更新配置
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.
ECHO.请选择旧版本的 配置文件 文件夹以导入数据。
ECHO.
call selfolder.bat
if not exist %folderpath%\列表.txt ECHO.目标文件夹中没有配置文件列表！按任意键返回。 & pause>nul & goto EDITINI
set num5=1
:EDITINI-7
find "隧道%num5%" "%folderpath%\列表.txt" 1>nul 2>nul
if not "%errorlevel%"=="0" goto EDITINI-8
for /f "tokens=3 delims= " %%i in ('findstr "隧道%num5%" %folderpath%\列表.txt') do set frpname=%%i
copy %folderpath%\列表.txt 配置文件\>nul
ECHO.导入%frpname%...
if not exist %folderpath%\%frpname%\frpc.ini ECHO.找不到配置文件！跳过... & set /a num5+=1& goto EDITINI-7
md 配置文件\%frpname%>nul
copy %folderpath%\%frpname%\frpc.ini 配置文件\%frpname%\>nul
set /a num5+=1
goto EDITINI-7

:EDITINI-8
set /a num5+=-1
ECHO.
if "%num5%"=="0" ECHO.没有找到隧道！这可能是由于配置文件列表有误或文件夹选择错误。按任意键回主菜单。 & pause>nul & goto START
ECHO.共导入隧道%num5%个。按任意键回主菜单。
pause>nul
goto START

:EDITINI-D
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                          导入/更新配置
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
if not exist 配置文件备份.zip ECHO.没有找到备份！按任意键返回。 & pause>nul & goto EDITINI
echo.noticeoff>noticeoff
taskkill /f /im frpc-* 1>nul 2>nul
rd /s /Q 配置文件 1>nul 2>nul
md 配置文件 1>nul 2>nul
7z.exe x "配置文件备份.zip" -o".\" -y
ECHO.
ECHO.完成。按任意键回主菜单。
pause>nul
goto START


:editini-clean
echo.noticeoff>noticeoff
taskkill /f /im frpc-*
del 配置文件备份.zip
ECHO.自动备份...
7z.exe a 配置文件备份.zip .\配置文件\
rd /s /Q 配置文件
md 配置文件
::https://www.cnblogs.com/EasonJim/p/6087636.html
goto :eof