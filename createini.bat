::

@ECHO OFF

:START
::��ȡ�����е�server_addr��չʾ��������
set servername=δ֪�ڵ�
for /f "tokens=3 delims= " %%i in ('findstr "server_addr" �����ļ�\tmp.txt') do set server_addr=%%i
if "%server_addr%"=="111.67.198.177" set servername=#9����1�ڵ�
if "%server_addr%"=="123.57.52.159" set servername=#10����2�ڵ�
if "%server_addr%"=="43.226.152.90" set servername=#14�����ڵ�
if "%server_addr%"=="cn-gy-dx-1.mefrp.com" set servername=#15���ݽڵ�
if "%server_addr%"=="124.223.79.186" set servername=#18�Ϻ��ڵ�
if "%server_addr%"=="124.222.202.111" set servername=#19�Ϻ��ڵ�
if "%server_addr%"=="43.158.199.131" set servername=#20����ڵ�
if "%server_addr%"=="106.12.142.44" set servername=#21���ݽڵ�
if "%server_addr%"=="cn-bj-lt-1.mefrp.com" set servername=#23����3�ڵ�
if "%server_addr%"=="cn-bj-yd-1.mefrp.com" set servername=#24����4�ڵ�
if "%server_addr%"=="107.151.196.109" set servername=#25��۽ڵ�
if "%server_addr%"=="cn-gd-lt-1.mefrp.com" set servername=#26��ɽ�ڵ�
if "%server_addr%"=="103.45.144.46" set servername=#27���ͺ��ؽڵ�
if "%server_addr%"=="de-tlg-bgp-1.mefrp.com" set servername=#28�¹��ڵ�
if "%server_addr%"=="cn-gs-yd-1.mefrp.com" set servername=#29����ڵ�
if "%server_addr%"=="de-tlg-bgp-2.mefrp.com" set servername=#30�¹��ڵ�
if "%server_addr%"=="cn-jx-dx-1.mefrp.com" set servername=#32�����ڵ�


::�����������ж��ٸ������num1��
for %%i in (�����ļ�\tmp.txt) do (
    for /f %%a in ('type %%~si ^|find /c "privilege_mode"')do (
    set num1=%%a
	)
)
::https://www.cnblogs.com/pzy4447/articles/3127791.html
if %num1% LSS 1 ECHO.��������������� & goto FINISH
ECHO.�������%servername%���ҵ�%num1%�����...
::��ѭ����ʼ
:CREATEINI-1
::����б�.txt�Ƿ���ڣ���������˵����ǰû����������ñ���������Ϊ1����ʼ��ӡ�
if not exist �����ļ�\�б�.txt set frpnum=1& goto CREATEINI-5
::��ȡ�б�.txt�����������
for /f "tokens=1 delims= " %%i in ('findstr "���" �����ļ�\�б�.txt') do set frpnum=%%i
::���ɱ���������
set /a frpnum+=1
:CREATEINI-5
::��ʼ��������
::��ȡ�������
for /f "tokens=1 delims= " %%i in ('findstr "[" �����ļ�\tmp.txt') do set frpname=%%i
::����Ƿ����и����������
if exist �����ļ�\%frpname% ECHO.���%frpname%�Ѵ��ڣ������� & goto CREATEINI-4
ECHO.����%frpname%�����ļ�...
::���common����
md �����ļ�\%frpname%
echo.[common]>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "server_addr" �����ļ�\tmp.txt') do set server_addr=%%i
echo.server_addr = %server_addr%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "server_port" �����ļ�\tmp.txt') do set server_port=%%i
echo.server_port = %server_port%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "tcp_mux" �����ļ�\tmp.txt') do set tcp_mux=%%i
echo.tcp_mux = %tcp_mux%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "protocol" �����ļ�\tmp.txt') do set protocol=%%i
echo.protocol = %protocol%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "user" �����ļ�\tmp.txt') do set user=%%i
echo.user = %user%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "token" �����ļ�\tmp.txt') do set token=%%i
echo.token = %token%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "dns_server" �����ļ�\tmp.txt') do set dns_server=%%i
echo.dns_server = %dns_server%>>�����ļ�\%frpname%\frpc.ini
echo.>>�����ļ�\%frpname%\frpc.ini
::����û�����
echo.%frpname%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "privilege_mode" �����ļ�\tmp.txt') do set privilege_mode=%%i
echo.privilege_mode = %privilege_mode%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "type" �����ļ�\tmp.txt') do set type=%%i
echo.type = %type%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "local_ip" �����ļ�\tmp.txt') do set local_ip=%%i
echo.local_ip = %local_ip%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "local_port" �����ļ�\tmp.txt') do set local_port=%%i
echo.local_port = %local_port%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "remote_port" �����ļ�\tmp.txt') do set remote_port=%%i
echo.remote_port = %remote_port%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "sk" �����ļ�\tmp.txt') do set sk=%%i
echo.sk = %sk%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "use_compression" �����ļ�\tmp.txt') do set use_compression=%%i
echo.use_compression = %use_compression%>>�����ļ�\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "use_compression" �����ļ�\tmp.txt') do set use_compression=%%i
echo.use_compression = %use_compression%>>�����ļ�\%frpname%\frpc.ini
echo.>>�����ļ�\%frpname%\frpc.ini
::д���б�.txt
echo.%frpnum% ���%frpnum% %frpname% %servername%-IP:%server_addr%:%remote_port%>>�����ļ�\�б�.txt
::ɾ��tmp.txt�иո������ɵ����
:CREATEINI-4
::����ȷ��frpname�����к�
::https://zhidao.baidu.com/question/623895683005139124.html
set num2=1
:CREATEINI-2
del �����ļ�\tmp2.txt 1>nul 2>nul
more +%num2% �����ļ�\tmp.txt>>�����ļ�\tmp2.txt
find "%frpname%" "�����ļ�\tmp2.txt" 1>nul 2>nul
if not "%errorlevel%"=="0" goto CREATEINI-3
set /a num2+=1
goto CREATEINI-2
:CREATEINI-3
::frpname�к���ȷ������num2��
::Ȼ�󱣴�tmp.txt��frpname������֮ǰ���������ݣ�Ҳ���Ǵ�tmp.txt��ɾ���˸ո���ӵ������
del �����ļ�\tmp2.txt 1>nul 2>nul
set num4=0
for /f "usebackq delims=" %%a in ("�����ļ�\tmp.txt") do (
   set /a num4+=1
   if !num4! LSS %num2% echo.%%a>>�����ļ�\tmp2.txt
   )
)
::https://zhidao.baidu.com/question/1576107140889323060.html
del �����ļ�\tmp.txt 1>nul 2>nul
ren �����ļ�\tmp2.txt tmp.txt 1>nul
::ɾ����ɡ�
:CREATEINI-FINISH
::��������һ����������������������1
set /a num1+=-1
::����������Ѿ�û�������������˴����á�
if "%num1%"=="0" goto FINISH
goto CREATEINI-1



:FINISH
del �����ļ�\tmp.txt 1>nul 2>nul
goto :eof
