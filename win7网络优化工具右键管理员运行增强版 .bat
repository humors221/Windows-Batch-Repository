@echo off
setlocal enabledelayedexpansion
echo windows10网络优化工具
echo.
echo 作者：phenix
echo.
echo 邮箱：279682817@qq.com
echo.
echo 内置了以下网址测试：
echo.
echo 腾讯视频 http://v.qq.com/
echo 爱奇艺 http://www.iqiyi.com/
echo 淘宝网 https://www.taobao.com/
echo 京东网 https://www.jd.com/
echo QQ音乐 http://y.qq.com/
echo 网易云音乐 http://music.163.com/
echo QQ邮箱 http://mail.qq.com/
echo 网易163邮箱 http://mail.163.com/
echo 携程网 https://www.ctrip.com/
echo 12306 https://www.12306.cn/index/
echo BOSS直聘 https://www.zhipin.com
echo 前程无忧 https://www.51job.com/
echo 新浪微博 https://weibo.com/
echo 百度搜索 http://www.baidu.com
echo 必应搜索 https://cn.bing.com/
echo 新浪网 https://www.sina.com.cn/
echo 网易网 https://www.163.com/
echo 搜狐网 https://www.sohu.com/
echo 腾讯网 https://www.qq.com/
echo 央视网 https://www.cctv.com/ 
echo.
echo http://v.qq.com/>%temp%\url.txt
echo http://www.iqiyi.com/>>%temp%\url.txt
echo https://www.taobao.com/>>%temp%\url.txt
echo https://www.jd.com/>>%temp%\url.txt
echo http://y.qq.com/>>%temp%\url.txt
echo http://music.163.com/>>%temp%\url.txt
echo http://mail.qq.com/>>%temp%\url.txt
echo http://mail.163.com/>>%temp%\url.txt
echo https://www.ctrip.com/>>%temp%\url.txt
echo https://www.12306.cn/index/>>%temp%\url.txt
echo https://www.zhipin.com>>%temp%\url.txt
echo https://www.51job.com/>>%temp%\url.txt
echo https://weibo.com/>>%temp%\url.txt
echo http://www.baidu.com>>%temp%\url.txt
echo https://cn.bing.com/>>%temp%\url.txt
echo https://www.sina.com.cn/>>%temp%\url.txt
echo https://www.163.com/>>%temp%\url.txt
echo https://www.sohu.com/>>%temp%\url.txt
echo https://www.qq.com/>>%temp%\url.txt
echo https://www.cctv.com/>>%temp%\url.txt
set /p checkInput=需要输入自定义网址吗？1需要0不需要:
echo.
if !checkInput! equ 1 (
call :inputUrl
)
echo.
set seq=1
for /F "tokens=* delims=" %%t in (%temp%\url.txt) do (
set url=%%t
if !seq! equ 1 (
echo Set client = CreateObject("MSXML2.ServerXMLHTTP"^)>%temp%\send.vbs
) else (
echo Set client = CreateObject("MSXML2.ServerXMLHTTP"^)>>%temp%\send.vbs
)
echo client.open "GET","!url!",false>>%temp%\send.vbs
echo client.send(^)>>%temp%\send.vbs
set /a seq+=1
)
set avgTime=0
set totalTime=0
set minTime=
set minBuffer=
set initBuffer=512
echo 初始化DnsCacheEnabled
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v DnsCacheEnabled /t reg_dword /d 2 /f
echo.
echo 初始化ConnectTimeOut
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ConnectTimeOut /t reg_dword /d 0 /f
echo.
echo 初始化SendTimeOut 
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v SendTimeOut /t reg_dword /d 0 /f
call reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SendTimeOut /t reg_dword /d 0 /f
echo.
echo 初始化ReceiveTimeOut
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ReceiveTimeOut /t reg_dword /d 0 /f
call reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v ReceiveTimeOut /t reg_dword /d 0 /f
echo.
echo 初始化DnsCacheTimeout
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v DnsCacheTimeout /t reg_dword /d 0 /f
echo.
for /L %%f in (1,1,5) do (
echo 初始化Buffer为!initBuffer!
echo.
call reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !initBuffer! /f
call reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !initBuffer! /f
echo.
for /L %%t in (1,1,10) do (
set start=!time!
start /wait wscript %temp%\send.vbs
set end=!time!
set start=!start::=!
set start=!start:.=!
set end=!end::=!
set end=!end:.=!
rem echo !start!  !end!
set /a dura=!end!-!start!
if !dura! lss 0 (
set /a dura=!dura!+23600000
)
echo Buffer为!initBuffer!第%%t次值为!dura!
echo.
set /a totalTime+=!dura!
)
set /a avgTime=!totalTime!/10
echo Buffer为!initBuffer!总值为!totalTime!，平均值为!avgTime!
echo.
if "!minTime!" equ "" (
set minTime=!avgTime!
set minBuffer=!initBuffer!
) else (
if !avgTime! lss !minTime! (
set minTime=!avgTime!
set minBuffer=!initBuffer!
)
)
set /a initBuffer*=2
set avgTime=0
set totalTime=0
)
echo 最短平均值为!minTime!，Buffer设置为!minBuffer!
echo.
set /p input=使用上述值设置Buffer嘛？1则自动设置，0则手填:
echo.
if "!input!" equ "1" (
echo 设置Buffer开始
echo.
call reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !minBuffer! /f
echo.
call reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !minBuffer! /f
echo.
) else (
if "!input!" equ "0" (
set /p timeout=请输入超时时间毫秒1秒^=1000毫秒:
echo.
echo 初始化ConnectTimeOut
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ConnectTimeOut /t reg_dword /d !timeout! /f
echo.
echo 初始化SendTimeOut 
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v SendTimeOut /t reg_dword /d !timeout! /f
call reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SendTimeOut /t reg_dword /d !timeout! /f
echo.
echo 初始化ReceiveTimeOut
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ReceiveTimeOut /t reg_dword /d !timeout! /f
call reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v ReceiveTimeOut /t reg_dword /d !timeout! /f
echo.
echo 初始化DnsCacheTimeout
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v DnsCacheTimeout /t reg_dword /d !timeout! /f
echo.
echo 设置Buffer数值
echo.
set /p buffer=请输入数值512-8192：
echo.
if !buffer! leq 8192 (
if !buffer! geq 512 (
echo 设置Buffer开始
echo.
call reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !buffer! /f
echo.
call reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !buffer! /f
echo.
)
)
)
)
pause
exit

:inputUrl
echo 网址格式：http://www.baidu.com
for /L %%f in (1,1,1000) do (
set /p urls=请输入网址:
echo !urls!>>%temp%\url.txt
set /p checkIn=是否继续输入?1继续0结束:
if not !checkIn! equ 1 (
goto :eof
)
)