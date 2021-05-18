@echo off
setlocal enabledelayedexpansion
echo windows10网络优化工具
echo.
echo 作者：phenix
echo.
echo 邮箱：279682817@qq.com
echo.
set /p recover=是否需要恢复优化之前的设置?1是0否:
if !recover! equ 1 (
echo.
rem echo 恢复服务设置
rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\RpcEptMapper" /v Start /t reg_dword /d 3 /f
rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v Start /t reg_dword /d 3 /f
rem echo.
rem echo 恢复MaxCacheTtl
rem echo.
rem start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /f
rem echo.
echo 恢复Buffer
echo.
start /wait /b reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /f
echo.
start /wait /b reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /f
echo.
echo 恢复UdpRecvBufferSize
echo.
start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /f
echo.
echo 恢复MaxCacheSize
echo.
start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /f
echo.
echo 恢复完毕！
echo.
pause
exit
)
echo.
set useOld=
if exist %temp%\url.txt (
set /p useOld=需要使用上次的网址测试吗?1是0否:
)
echo.
if not !useOld! equ 1 (
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
set /p checkInput=需要定制测试网址吗？1需要0不需要:
echo.
if !checkInput! equ 1 (
call :inputUrl
)
echo.
)
set seq=1
for /F "tokens=* delims=" %%t in (%temp%\url.txt) do (
set url=%%t
if !seq! equ 1 (
echo Set client = CreateObject("MSXML2.ServerXMLHTTP"^)>%temp%\send.vbs
) else (
echo Set client = CreateObject("MSXML2.ServerXMLHTTP"^)>>%temp%\send.vbs
)
echo client.SetTimeOuts 120000,120000,120000,120000>>%temp%\send.vbs
echo client.open "GET","!url!",false>>%temp%\send.vbs
echo client.send(^)>>%temp%\send.vbs
set /a seq+=1
)
set avgTime=0
set totalTime=0
set minTime=
set minBuffer=
set initBuffer=512
echo.
echo 初始化服务设置
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\RpcEptMapper" /v Start /t reg_dword /d 2 /f
rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\DcomLaunch" /v Start /t reg_dword /d 2 /f
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\nsi" /v Start /t reg_dword /d 2 /f
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v Start /t reg_dword /d 2 /f
echo.
echo 启动服务
call net start RpcEptMapper
rem call net start DcomLaunch
call net start nsi
call net start Dnscache
echo.
echo 初始化MaxCacheTtl
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /t reg_dword /d 255 /f
echo.
for /L %%f in (1,1,5) do (
echo 初始化Buffer为!initBuffer!
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !initBuffer! /f
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !initBuffer! /f
echo.
echo 初始化UdpRecvBufferSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !initBuffer! /f
echo.
echo 初始化MaxCacheSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !initBuffer! /f
echo.
for /L %%t in (1,1,10) do (
set start=!time!
start /wait wscript /b %temp%\send.vbs
set end=!time!
set /a startHour=1!start:~0,2!-100
set /a startMin=1!start:~3,2!-100
set /a startSec=1!start:~6,2!-100
set /a startMil=1!start:~9,2!-100
set /a endHour=1!end:~0,2!-100
set /a endMin=1!end:~3,2!-100
set /a endSec=1!end:~6,2!-100
set /a endMil=1!end:~9,2!-100
set /a start=startHour*360000+startMin*6000+startSec*100+startMil
set /a end=endHour*360000+endMin*6000+endSec*100+endMil
set /a dura=!end!-!start!
echo Buffer为!initBuffer!第%%t次时间为!dura!
echo.
set /a totalTime+=!dura!
)
set /a avgTime=!totalTime!/10
echo Buffer为!initBuffer!总时间为!totalTime!，平均时间为!avgTime!
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
echo 最短平均时间为!minTime!，Buffer设置为!minBuffer!
echo.
set /p input=使用上述值设置Buffer嘛？1则自动设置，0则手填:
echo.
if "!input!" equ "1" (
echo 设置Buffer开始
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !minBuffer! /f
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !minBuffer! /f
echo.
echo 初始化UdpRecvBufferSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !minBuffer! /f
echo.
echo 初始化MaxCacheSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !minBuffer! /f
echo.
) else (
if "!input!" equ "0" (
set /p buffer=请输入数值512-8192：
echo.
if !buffer! leq 8192 (
if !buffer! geq 512 (
echo 设置Buffer开始
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !buffer! /f
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !buffer! /f
echo.
echo 初始化UdpRecvBufferSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !buffer! /f
echo.
echo 初始化MaxCacheSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !buffer! /f
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