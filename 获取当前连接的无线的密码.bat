@echo off
setlocal enabledelayedexpansion
echo 程序名:获取无线密码程序
echo.
echo 功能：获取当前连接的无线的密码（请先连接无线）
call :main

:main
echo.
call :getWifiState

rem 获取无线连接状态
:getWifiState
set row=1
FOR /F "tokens=1,2* delims=:" %%a in ('netsh wlan show interfaces') do (
if !row! equ 6 (
if "%%b" equ " 已断开连接" (
echo 请先连接无线，再查看密码！
echo.
pause
goto :main
) else (
echo 获取无线连接状态:已连接
echo.
call :getWifiName
)
)
set /a row+=1
)

rem 获取无线连接名称
:getWifiName
set row1=1
FOR /F "tokens=1,2* delims=:" %%c in ('netsh wlan show interfaces') do (
if !row1! equ 7 (
echo 获取无线连接名称:%%d
echo 无线名:%%d>>无线连接信息.txt
echo.
call :getWifiKey %%d
)
set /a row1+=1
)

rem 获取无线连接密码
:getWifiKey
set wifiName=%1
netsh wlan show profile name="!wifiName!" key=clear|find "关键内容">%temp%\getWifiKey.txt
set /p key=<%temp%\getWifiKey.txt
echo 获取无线连接密码:!key:~22!
echo.
echo 无线信息保存在:无线连接信息.txt中，以备随时查看。
echo 无线密码:!key:~22!>>无线连接信息.txt
echo.>>无线连接信息.txt
echo.
pause
goto :main