@ECHO OFF
setlocal enabledelayedexpansion
mode con cols=66 lines=30
COLOR 0E
TITLE ME FRP ������ SNASHOT-3.0 MAX#27

:START
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                              MEFrp
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO. 1.����/�ر������Ĭ�ϣ�
ECHO.
ECHO. 2.����/�������ã���ɾ����ǰ���������ļ���
ECHO.
ECHO. 3.����FRP����
ECHO.
ECHO. 4.����/�����û���Կ
ECHO.
ECHO. 5.ʹ��˵��
ECHO.
ECHO. 6.���ʹ���
ECHO.
ECHO.  ? 2022 MCServerX����MEFRP������Ϳᰲ@ĳ������һ��Ȩ��.
set choice=1
set /p choice= �������ְ�Enter������
if "%choice%"=="1" goto STARTFRP
if "%choice%"=="2" goto EDITINI
if "%choice%"=="3" goto RESETLAUNCHER
::if "%choice%"=="4" start https://mefrp.cn/?page=panel&module=addproxy & echo.����32038����32032>tmp.txt & clip < tmp.txt & del tmp.txt
if "%choice%"=="4" goto USERKEY
if "%choice%"=="5" goto INSTRUCTION
if "%choice%"=="6" start https://mefrp.cn/
goto START

:USERKEY
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                        ����/�����û���Կ
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.ע�⣡�����ڴ�ҳ�����ա�������¼�����û���Կ��ͬ���˻����룬й¶�ᵼ�����غ����
ECHO.
set userkey=blank
set /p userkey= �������û���Կ��
if "%userkey%"=="blank" msg %username% "δ�����κ�ֵ���û���Կ���ֲ��䡣" & goto START
echo.set userkey=%userkey%>config\userkey.bat
call config\userkey.bat
msg %username% "�ѱ����û���Կ��"
goto START

:INSTRUCTION
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                     ME FRP ������ ʹ��˵��
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.
ECHO. ��������Ҫ���� MEFrp ������ע��һ���˺š�
ECHO. https://mefrp.cn
ECHO.
ECHO. Ȼ��������ҳ��� ������� ��Ŀ��������������
ECHO.
ECHO. Ȼ����ʹ�����˵� ����/�������� ���ܣ�����������á�
ECHO.
ECHO. �ɹ�����󣬾Ϳ���ʹ�������������������
ECHO.
ECHO. ����FRP�����ܵ�˵����Ϊ��ʵ������࿪�������������ʱ�ὫFRP��  �س����ѹ�������ļ�����Ŀ¼��������������𻵣�����ʹ�ô˹�����  �á�
ECHO.
ECHO.
ECHO.bat�ű����ߣ��ᰲ@ĳ������������������˵���
pause>nul
goto START

:RESETLAUNCHER
for /R �����ļ� %%f in (*.exe) do del %%f
for /R �����ļ� %%f in (*.bat) do del %%f
for /R �����ļ� %%f in (*.vbs) do del %%f
goto START

:STARTFRP
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                            �������
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
if not exist �����ļ�\�б�.txt ECHO.�Ҳ��������ļ��б�����ʹ�� ����/�������� ���ܡ�������������˵��� & pause>nul & goto START
ECHO.�����ر���������������ţ������δ��������������������رա�
ECHO.�������ʱ���Զ����Ƶ�ַ�������塣
ECHO.������ֱ�Ӱ�Enterˢ�����״̬����ʱ���뿪������ˢ��״̬�ٲ�����
ECHO.
set frpnumtotal=blank
for /f "tokens=1 delims= " %%i in ('findstr "���" �����ļ�\�б�.txt') do set frpnumtotal=%%i
if "%frpnumtotal%"=="blank" ECHO.�����ļ��б��������������ʹ�� ����/�������� ���ܡ�������������˵��� & pause>nul & goto START
set frpnum=0
:STARTFRP-2
set /a frpnum+=1
if %frpnum% GTR %frpnumtotal% goto STARTFRP-3
for /f "tokens=3 delims= " %%i in ('findstr "���%frpnum%" �����ļ�\�б�.txt') do set frpname=%%i
for /f "tokens=4 delims= " %%i in ('findstr "���%frpnum%" �����ļ�\�б�.txt') do set frpaddress=%%i
TASKLIST /FI "IMAGENAME eq frpc-%frpname%.exe" | find "û�����е�����ƥ��ָ����׼" 1>nul 2>nul
if "%errorlevel%"=="0" ECHO.%frpnum%.�������%frpname% %frpaddress% & goto STARTFRP-2
ECHO.%frpnum%.[������]�ر����%frpname% %frpaddress%
goto STARTFRP-2
:STARTFRP-3
ECHO.
if not exist config\frpwindow.bat echo.set frpwindow=off>config\frpwindow.bat
set frpwindow=blank
call config\frpwindow.bat
if "%frpwindow%"=="blank" echo.set frpwindow=off>config\frpwindow.bat & goto STARTFRP-3
if "%frpwindow%"=="off" ECHO.A.��ʾ������д��ڣ���ǰ����Ϊ���ش��ڣ�
if "%frpwindow%"=="on" ECHO.A.����������д��ڣ���ǰ����Ϊ��ʾ���ڣ�
ECHO.B.�ر��������
ECHO.C.�����˵�
ECHO.
ECHO.
set choice=refresh
set /p choice= ����ѡ�Enter������
if "%choice%"=="refresh" goto STARTFRP
if "%choice%"=="A" call :startfrp-4 & goto STARTFRP
if "%choice%"=="a" call :startfrp-4 & goto STARTFRP
if "%choice%"=="B" echo.noticeoff>noticeoff & taskkill /f /im frpc-* & TIMEOUT /T 1 /NOBREAK>nul & goto STARTFRP
if "%choice%"=="b" echo.noticeoff>noticeoff & taskkill /f /im frpc-* & TIMEOUT /T 1 /NOBREAK>nul & goto STARTFRP
if "%choice%"=="C" goto START
if "%choice%"=="c" goto START
find "���%choice%" "�����ļ�\�б�.txt" 1>nul 2>nul
if not "%errorlevel%"=="0" ECHO. & ECHO.����������������ڣ���������������1��2��3����������������롣 & pause>nul & goto STARTFRP
for /f "tokens=3 delims= " %%i in ('findstr "���%choice%" �����ļ�\�б�.txt') do set frpname=%%i
for /f "tokens=4 delims= " %%i in ('findstr "���%choice%" �����ļ�\�б�.txt') do set frpaddress=%%i
TASKLIST /FI "IMAGENAME eq frpc-%frpname%.exe" | find "û�����е�����ƥ��ָ����׼" 1>nul 2>nul
if not "%errorlevel%"=="0" echo.noticeoff>noticeoff & taskkill /f /im frpc-%frpname%.exe & TIMEOUT /T 1 /NOBREAK>nul & goto STARTFRP
if not exist �����ļ�\%frpname%\frpc.ini ECHO. & ECHO.�Ҳ���ָ������������ļ���������������/�������á� & pause & goto STARTFRP
if not exist �����ļ�\%frpname%\frpc-%frpname%.exe 7z.exe x "program.zip" -o"�����ļ�\%frpname%\" -y & ren �����ļ�\%frpname%\frpc.exe frpc-%frpname%.exe
if not exist �����ļ�\%frpname%\startfrp.vbs 7z.exe x "program.zip" -o"�����ļ�\%frpname%\" -y
if "%frpwindow%"=="off" cd �����ļ�\%frpname%\ & start startfrp.vbs %frpname% %frpaddress% & cd /D %~dp0
if "%frpwindow%"=="on" start �����ļ�\%frpname%\startfrp.bat %frpname% %frpaddress%
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
ECHO.                          ����/��������
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.
ECHO.����ǰ���Զ����ݲ�ɾ����ǰ�������ã������Ҫ����ѡ��ָ���
ECHO.�����ļ�ֻ�ᱣ��һ���������µı�����Ḳ�Ǿɵġ�
ECHO.
ECHO.
ECHO.1.�Զ�����(�Ƽ�)      3.�Ӿɰ汾����
ECHO.
ECHO.4.�ָ���һ�εı���   5.�����˵�
ECHO.
ECHO.
set choice=1
set /p choice= �������ְ�Enter������
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
ECHO.                          ����/��������
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
set userkey=blank
call config\userkey.bat
if "%userkey%"=="blank" ECHO.����δ�����û���Կ������������롣 & pause>nul & goto USERKEY
ECHO.Ĭ��ʹ����������û���Կ����������������˵�������
ECHO.����ȡ�����κ����������ԭ��δ����������û���Կ��������ԭ��
ECHO.
ECHO.[i]��������ӷ�������ȡ����б��ٶ�ȡ���ڹ�����������硣


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
ECHO.��ɡ�������������˵���
pause>nul
goto START

:editini-9
curl "https://api.mefrp.cn/?action=getconf&&apitoken=MEFRPToken|%nodenum%&token=%userkey%&node=%nodenum%" 1>>�����ļ�\tmp2.txt 2>nul
@(for /f "delims=" %%i in (�����ļ�\tmp2.txt) do @(set /p a=%%i<nul&echo.))>>�����ļ�\tmp.txt
del �����ļ�\tmp2.txt
goto :eof




:EDITINI-C
call :editini-clean
for /f %%i in (address.txt) do set address=%%i>nul
start "" "%address%"
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                          ����/��������
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.
ECHO.�Ѵ򿪹ٷ������ļ���ȡҳ�档���û�е�½�����¼�����·���ַ��ʹ��������򿪡�
ECHO.
type address.txt & ECHO.
ECHO.
ECHO.�򿪺���ѡ��������������·������ļ����ݣ�Ȼ�������������
ECHO.
pause>nul
:EDITINI-1
del �����ļ�\tmp.txt 1>nul 2>nul
set server_addr=blank
set remote_port=blank
call getclickboard.vbs1
move tmp.txt �����ļ�\ 1>nul
ECHO.�ѱ�����������ݡ�������...
call createini.bat
ECHO.
ECHO.
ECHO.��������������ã���ѡ����һ�����������������ò���Enter������
ECHO.
ECHO.1.���������һ������������(Ĭ��)   2.����
ECHO.
set choice=1
set /p choice= �������ְ�Enter������
if "%choice%"=="2" del �����ļ�\tmp.txt & goto START
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                          ����/��������
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
ECHO.                          ����/��������
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.
ECHO.��ѡ��ɰ汾�� �����ļ� �ļ����Ե������ݡ�
ECHO.
call selfolder.bat
if not exist %folderpath%\�б�.txt ECHO.Ŀ���ļ�����û�������ļ��б�����������ء� & pause>nul & goto EDITINI
set num5=1
:EDITINI-7
find "���%num5%" "%folderpath%\�б�.txt" 1>nul 2>nul
if not "%errorlevel%"=="0" goto EDITINI-8
for /f "tokens=3 delims= " %%i in ('findstr "���%num5%" %folderpath%\�б�.txt') do set frpname=%%i
copy %folderpath%\�б�.txt �����ļ�\>nul
ECHO.����%frpname%...
if not exist %folderpath%\%frpname%\frpc.ini ECHO.�Ҳ��������ļ�������... & set /a num5+=1& goto EDITINI-7
md �����ļ�\%frpname%>nul
copy %folderpath%\%frpname%\frpc.ini �����ļ�\%frpname%\>nul
set /a num5+=1
goto EDITINI-7

:EDITINI-8
set /a num5+=-1
ECHO.
if "%num5%"=="0" ECHO.û���ҵ����������������������ļ��б�������ļ���ѡ����󡣰�����������˵��� & pause>nul & goto START
ECHO.���������%num5%����������������˵���
pause>nul
goto START

:EDITINI-D
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                          ����/��������
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
if not exist �����ļ�����.zip ECHO.û���ҵ����ݣ�����������ء� & pause>nul & goto EDITINI
echo.noticeoff>noticeoff
taskkill /f /im frpc-* 1>nul 2>nul
rd /s /Q �����ļ� 1>nul 2>nul
md �����ļ� 1>nul 2>nul
7z.exe x "�����ļ�����.zip" -o".\" -y
ECHO.
ECHO.��ɡ�������������˵���
pause>nul
goto START


:editini-clean
echo.noticeoff>noticeoff
taskkill /f /im frpc-*
del �����ļ�����.zip
ECHO.�Զ�����...
7z.exe a �����ļ�����.zip .\�����ļ�\
rd /s /Q �����ļ�
md �����ļ�
::https://www.cnblogs.com/EasonJim/p/6087636.html
goto :eof