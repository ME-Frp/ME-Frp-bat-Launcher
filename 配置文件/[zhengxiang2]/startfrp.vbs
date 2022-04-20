Set ws = CreateObject("Wscript.Shell")
frpname = WScript.Arguments(0)
frpaddress = WScript.Arguments(1)
frpwindows = off
' msgbox(frpname)
' msgbox(frpaddress)
ws.run "cmd /c startfrp.bat "&frpname&" "&frpaddress&" "&frpwindow&"",vbhide
' https://www.jb51.net/article/14352.htm
' https://zhidao.baidu.com/question/242553418.html
' https://jingyan.baidu.com/article/9113f81b5b8c392b3214c71b.html
' https://blog.csdn.net/qq_36530891/article/details/97010987