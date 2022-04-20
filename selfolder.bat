@ECHO OFF

<!-- :
for /f "delims=" %%a in ('mshta "%~f0"') do set folderpath=%%a
::for /f %%i in (log\folderpath.log) do set folderpath=%%i
::echo.%folderpath%>log\folderpath.log
::pause&exit /b
goto :eof
-->

<script>
var Shell = new ActiveXObject("Shell.Application");
var Folder = Shell.BrowseForFolder(0, "请选择旧版本 配置文件 文件夹", 0); //起始目录为：桌面
if (Folder != null) {
	Folder = Folder.items();
	Folder = Folder.item();
	Folder = Folder.Path;
	new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(Folder);
}
close();
</script>
::http://www.bathome.net/thread-34496-1-2.html


::解决格式问题：