@echo off
setlocal enabledelayedexpansion
echo windows10�����Ż�����
echo.
echo ���ߣ�phenix
echo.
echo ���䣺279682817@qq.com
echo.
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
set /p checkInput=��Ҫ�����Զ�����ַ��1��Ҫ0����Ҫ:
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
echo ��ʼ��DnsCacheEnabled
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v DnsCacheEnabled /t reg_dword /d 2 /f
echo.
echo ��ʼ��ConnectTimeOut
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ConnectTimeOut /t reg_dword /d 0 /f
echo.
echo ��ʼ��SendTimeOut 
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v SendTimeOut /t reg_dword /d 0 /f
call reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SendTimeOut /t reg_dword /d 0 /f
echo.
echo ��ʼ��ReceiveTimeOut
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ReceiveTimeOut /t reg_dword /d 0 /f
call reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v ReceiveTimeOut /t reg_dword /d 0 /f
echo.
echo ��ʼ��DnsCacheTimeout
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v DnsCacheTimeout /t reg_dword /d 0 /f
echo.
for /L %%f in (1,1,5) do (
echo ��ʼ��BufferΪ!initBuffer!
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
echo BufferΪ!initBuffer!��%%t��ֵΪ!dura!
echo.
set /a totalTime+=!dura!
)
set /a avgTime=!totalTime!/10
echo BufferΪ!initBuffer!��ֵΪ!totalTime!��ƽ��ֵΪ!avgTime!
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
echo ���ƽ��ֵΪ!minTime!��Buffer����Ϊ!minBuffer!
echo.
set /p input=ʹ������ֵ����Buffer�1���Զ����ã�0������:
echo.
if "!input!" equ "1" (
echo ����Buffer��ʼ
echo.
call reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !minBuffer! /f
echo.
call reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !minBuffer! /f
echo.
) else (
if "!input!" equ "0" (
set /p timeout=�����볬ʱʱ�����1��^=1000����:
echo.
echo ��ʼ��ConnectTimeOut
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ConnectTimeOut /t reg_dword /d !timeout! /f
echo.
echo ��ʼ��SendTimeOut 
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v SendTimeOut /t reg_dword /d !timeout! /f
call reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SendTimeOut /t reg_dword /d !timeout! /f
echo.
echo ��ʼ��ReceiveTimeOut
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ReceiveTimeOut /t reg_dword /d !timeout! /f
call reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v ReceiveTimeOut /t reg_dword /d !timeout! /f
echo.
echo ��ʼ��DnsCacheTimeout
echo.
call reg add  "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v DnsCacheTimeout /t reg_dword /d !timeout! /f
echo.
echo ����Buffer��ֵ
echo.
set /p buffer=��������ֵ512-8192��
echo.
if !buffer! leq 8192 (
if !buffer! geq 512 (
echo ����Buffer��ʼ
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
echo ��ַ��ʽ��http://www.baidu.com
for /L %%f in (1,1,1000) do (
set /p urls=��������ַ:
echo !urls!>>%temp%\url.txt
set /p checkIn=�Ƿ��������?1����0����:
if not !checkIn! equ 1 (
goto :eof
)
)