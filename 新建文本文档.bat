@ECHO OFF
:START
::curl https://frp.msrx.online/api/?action=getconf<新建文本文档.txt
::curl http://1.15.79.61:666/api/?action=getconf<新建文本文档.txt
::curl http://1.15.79.61:666/api/index.php?action=getconf"&"apitoken=RXFRPToken|1"&"token=6233677172b561e7"&"node=1
::curl "http://1.15.79.61:666/api/index.php?action=getconf&&apitoken=RXFRPToken|1&&token=6233677172b561e7&node=1"
::curl "http://1.15.79.61:666/api/index.php?action=getconf&&apitoken=RXFRPToken|1&&token=7b696e1cabe0e288&node=5"
curl "https://frp.msrx.online/api/index.php?action=getconf&&apitoken=RXFRPToken|1&&token=7b696e1cabe0e288&node=5"
pause
goto START