@echo off
setlocal enabledelayedexpansion
echo ������:��ȡ�����������
echo.
echo ���ܣ���ȡ��ǰ���ӵ����ߵ����루�����������ߣ�
call :main

:main
echo.
call :getWifiState

rem ��ȡ��������״̬
:getWifiState
set row=1
FOR /F "tokens=1,2* delims=:" %%a in ('netsh wlan show interfaces') do (
if !row! equ 6 (
if "%%b" equ " �ѶϿ�����" (
echo �����������ߣ��ٲ鿴���룡
echo.
pause
goto :main
) else (
echo ��ȡ��������״̬:������
echo.
call :getWifiName
)
)
set /a row+=1
)

rem ��ȡ������������
:getWifiName
set row1=1
FOR /F "tokens=1,2* delims=:" %%c in ('netsh wlan show interfaces') do (
if !row1! equ 7 (
echo ��ȡ������������:%%d
echo ������:%%d>>����������Ϣ.txt
echo.
call :getWifiKey %%d
)
set /a row1+=1
)

rem ��ȡ������������
:getWifiKey
set wifiName=%1
netsh wlan show profile name="!wifiName!" key=clear|find "�ؼ�����">%temp%\getWifiKey.txt
set /p key=<%temp%\getWifiKey.txt
echo ��ȡ������������:!key:~22!
echo.
echo ������Ϣ������:����������Ϣ.txt�У��Ա���ʱ�鿴��
echo ��������:!key:~22!>>����������Ϣ.txt
echo.>>����������Ϣ.txt
echo.
pause
goto :main