::

@ECHO OFF

:START
::读取配置中的server_addr以展示服务器名
set servername=未知节点
for /f "tokens=3 delims= " %%i in ('findstr "server_addr" 配置文件\tmp.txt') do set server_addr=%%i
if "%server_addr%"=="111.67.198.177" set servername=#9北京1节点
if "%server_addr%"=="123.57.52.159" set servername=#10北京2节点
if "%server_addr%"=="43.226.152.90" set servername=#14辽宁节点
if "%server_addr%"=="cn-gy-dx-1.mefrp.com" set servername=#15贵州节点
if "%server_addr%"=="124.223.79.186" set servername=#18上海节点
if "%server_addr%"=="124.222.202.111" set servername=#19上海节点
if "%server_addr%"=="43.158.199.131" set servername=#20孟买节点
if "%server_addr%"=="106.12.142.44" set servername=#21广州节点
if "%server_addr%"=="cn-bj-lt-1.mefrp.com" set servername=#23北京3节点
if "%server_addr%"=="cn-bj-yd-1.mefrp.com" set servername=#24北京4节点
if "%server_addr%"=="107.151.196.109" set servername=#25香港节点
if "%server_addr%"=="cn-gd-lt-1.mefrp.com" set servername=#26中山节点
if "%server_addr%"=="103.45.144.46" set servername=#27呼和浩特节点
if "%server_addr%"=="de-tlg-bgp-1.mefrp.com" set servername=#28德国节点
if "%server_addr%"=="cn-gs-yd-1.mefrp.com" set servername=#29甘肃节点
if "%server_addr%"=="de-tlg-bgp-2.mefrp.com" set servername=#30德国节点
if "%server_addr%"=="cn-jx-dx-1.mefrp.com" set servername=#32江西节点


::计算配置中有多少个隧道（num1）
for %%i in (配置文件\tmp.txt) do (
    for /f %%a in ('type %%~si ^|find /c "privilege_mode"')do (
    set num1=%%a
	)
)
::https://www.cnblogs.com/pzy4447/articles/3127791.html
if %num1% LSS 1 ECHO.此配置中无隧道。 & goto FINISH
ECHO.正在添加%servername%，找到%num1%个隧道...
::大循环开始
:CREATEINI-1
::检查列表.txt是否存在，不存在则说明当前没有隧道，设置本次隧道编号为1并开始添加。
if not exist 配置文件\列表.txt set frpnum=1& goto CREATEINI-5
::读取列表.txt中最大隧道编号
for /f "tokens=1 delims= " %%i in ('findstr "隧道" 配置文件\列表.txt') do set frpnum=%%i
::生成本次隧道编号
set /a frpnum+=1
:CREATEINI-5
::开始隧道的添加
::获取隧道名称
for /f "tokens=1 delims= " %%i in ('findstr "[" 配置文件\tmp.txt') do set frpname=%%i
::检查是否已有该隧道的配置
if exist 配置文件\%frpname% ECHO.隧道%frpname%已存在，跳过。 & goto CREATEINI-4
ECHO.创建%frpname%配置文件...
::添加common部分
md 配置文件\%frpname%
echo.[common]>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "server_addr" 配置文件\tmp.txt') do set server_addr=%%i
echo.server_addr = %server_addr%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "server_port" 配置文件\tmp.txt') do set server_port=%%i
echo.server_port = %server_port%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "tcp_mux" 配置文件\tmp.txt') do set tcp_mux=%%i
echo.tcp_mux = %tcp_mux%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "protocol" 配置文件\tmp.txt') do set protocol=%%i
echo.protocol = %protocol%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "user" 配置文件\tmp.txt') do set user=%%i
echo.user = %user%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "token" 配置文件\tmp.txt') do set token=%%i
echo.token = %token%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "dns_server" 配置文件\tmp.txt') do set dns_server=%%i
echo.dns_server = %dns_server%>>配置文件\%frpname%\frpc.ini
echo.>>配置文件\%frpname%\frpc.ini
::添加用户部分
echo.%frpname%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "privilege_mode" 配置文件\tmp.txt') do set privilege_mode=%%i
echo.privilege_mode = %privilege_mode%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "type" 配置文件\tmp.txt') do set type=%%i
echo.type = %type%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "local_ip" 配置文件\tmp.txt') do set local_ip=%%i
echo.local_ip = %local_ip%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "local_port" 配置文件\tmp.txt') do set local_port=%%i
echo.local_port = %local_port%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "remote_port" 配置文件\tmp.txt') do set remote_port=%%i
echo.remote_port = %remote_port%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "sk" 配置文件\tmp.txt') do set sk=%%i
echo.sk = %sk%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "use_compression" 配置文件\tmp.txt') do set use_compression=%%i
echo.use_compression = %use_compression%>>配置文件\%frpname%\frpc.ini
for /f "tokens=3 delims= " %%i in ('findstr "use_compression" 配置文件\tmp.txt') do set use_compression=%%i
echo.use_compression = %use_compression%>>配置文件\%frpname%\frpc.ini
echo.>>配置文件\%frpname%\frpc.ini
::写入列表.txt
echo.%frpnum% 隧道%frpnum% %frpname% %servername%-IP:%server_addr%:%remote_port%>>配置文件\列表.txt
::删除tmp.txt中刚刚添加完成的隧道
:CREATEINI-4
::首先确定frpname所在行号
::https://zhidao.baidu.com/question/623895683005139124.html
set num2=1
:CREATEINI-2
del 配置文件\tmp2.txt 1>nul 2>nul
more +%num2% 配置文件\tmp.txt>>配置文件\tmp2.txt
find "%frpname%" "配置文件\tmp2.txt" 1>nul 2>nul
if not "%errorlevel%"=="0" goto CREATEINI-3
set /a num2+=1
goto CREATEINI-2
:CREATEINI-3
::frpname行号已确定：第num2行
::然后保存tmp.txt中frpname所在行之前的所有内容，也就是从tmp.txt中删除了刚刚添加的隧道。
del 配置文件\tmp2.txt 1>nul 2>nul
set num4=0
for /f "usebackq delims=" %%a in ("配置文件\tmp.txt") do (
   set /a num4+=1
   if !num4! LSS %num2% echo.%%a>>配置文件\tmp2.txt
   )
)
::https://zhidao.baidu.com/question/1576107140889323060.html
del 配置文件\tmp.txt 1>nul 2>nul
ren 配置文件\tmp2.txt tmp.txt 1>nul
::删除完成。
:CREATEINI-FINISH
::已完成添加一个隧道，此配置中隧道数减1
set /a num1+=-1
::如果配置中已经没有隧道，则结束此次配置。
if "%num1%"=="0" goto FINISH
goto CREATEINI-1



:FINISH
del 配置文件\tmp.txt 1>nul 2>nul
goto :eof
