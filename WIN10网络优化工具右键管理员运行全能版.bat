@echo off
setlocal enabledelayedexpansion
echo windows10�����Ż�����
echo.
echo ���ߣ�phenix
echo.
echo ���䣺279682817@qq.com
echo.
set /p recover=�Ƿ���Ҫ�ָ��Ż�֮ǰ������?1��0��:
if !recover! equ 1 (
echo.
rem echo �ָ���������
rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\RpcEptMapper" /v Start /t reg_dword /d 3 /f
rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v Start /t reg_dword /d 3 /f
rem echo.
rem echo �ָ�MaxCacheTtl
rem echo.
rem start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /f
rem echo.
echo �ָ�Buffer
echo.
start /wait /b reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /f
echo.
start /wait /b reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /f
echo.
echo �ָ�UdpRecvBufferSize
echo.
start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /f
echo.
echo �ָ�MaxCacheSize
echo.
start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /f
echo.
echo �ָ���ϣ�
echo.
pause
exit
)
echo.
set useOld=
if exist %temp%\url.txt (
set /p useOld=��Ҫʹ���ϴε���ַ������?1��0��:
)
echo.
if not !useOld! equ 1 (
echo ������������ַ���ԣ�
echo.
echo ��Ѷ��Ƶ http://v.qq.com/
echo ������ http://www.iqiyi.com/
echo �Ա��� https://www.taobao.com/
echo ������ https://www.jd.com/
echo QQ���� http://y.qq.com/
echo ���������� http://music.163.com/
echo QQ���� http://mail.qq.com/
echo ����163���� http://mail.163.com/
echo Я���� https://www.ctrip.com/
echo 12306 https://www.12306.cn/index/
echo BOSSֱƸ https://www.zhipin.com
echo ǰ������ https://www.51job.com/
echo ����΢�� https://weibo.com/
echo �ٶ����� http://www.baidu.com
echo ��Ӧ���� https://cn.bing.com/
echo ������ https://www.sina.com.cn/
echo ������ https://www.163.com/
echo �Ѻ��� https://www.sohu.com/
echo ��Ѷ�� https://www.qq.com/
echo ������ https://www.cctv.com/ 
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
set /p checkInput=��Ҫ���Ʋ�����ַ��1��Ҫ0����Ҫ:
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
echo ��ʼ����������
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\RpcEptMapper" /v Start /t reg_dword /d 2 /f
rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\DcomLaunch" /v Start /t reg_dword /d 2 /f
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\nsi" /v Start /t reg_dword /d 2 /f
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v Start /t reg_dword /d 2 /f
echo.
echo ��������
call net start RpcEptMapper
rem call net start DcomLaunch
call net start nsi
call net start Dnscache
echo.
echo ��ʼ��MaxCacheTtl
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /t reg_dword /d 255 /f
echo.
for /L %%f in (1,1,5) do (
echo ��ʼ��BufferΪ!initBuffer!
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !initBuffer! /f
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !initBuffer! /f
echo.
echo ��ʼ��UdpRecvBufferSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !initBuffer! /f
echo.
echo ��ʼ��MaxCacheSize
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
echo BufferΪ!initBuffer!��%%t��ʱ��Ϊ!dura!
echo.
set /a totalTime+=!dura!
)
set /a avgTime=!totalTime!/10
echo BufferΪ!initBuffer!��ʱ��Ϊ!totalTime!��ƽ��ʱ��Ϊ!avgTime!
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
echo ���ƽ��ʱ��Ϊ!minTime!��Buffer����Ϊ!minBuffer!
echo.
set /p input=ʹ������ֵ����Buffer�1���Զ����ã�0������:
echo.
if "!input!" equ "1" (
echo ����Buffer��ʼ
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !minBuffer! /f
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !minBuffer! /f
echo.
echo ��ʼ��UdpRecvBufferSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !minBuffer! /f
echo.
echo ��ʼ��MaxCacheSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !minBuffer! /f
echo.
) else (
if "!input!" equ "0" (
set /p buffer=��������ֵ512-8192��
echo.
if !buffer! leq 8192 (
if !buffer! geq 512 (
echo ����Buffer��ʼ
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !buffer! /f
echo.
start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !buffer! /f
echo.
echo ��ʼ��UdpRecvBufferSize
echo.
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !buffer! /f
echo.
echo ��ʼ��MaxCacheSize
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
echo ��ַ��ʽ��http://www.baidu.com
for /L %%f in (1,1,1000) do (
set /p urls=��������ַ:
echo !urls!>>%temp%\url.txt
set /p checkIn=�Ƿ��������?1����0����:
if not !checkIn! equ 1 (
goto :eof
)
)