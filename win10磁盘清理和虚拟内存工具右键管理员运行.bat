@echo off
setlocal enabledelayedexpansion
rem ��������
echo ���ߣ�phenix
echo ���䣺279682817@qq.com
echo ��ӭ־ͬ���ϵĺ����ѣ���
echo ��������ʼ.
rem ������д���������
echo ������д��������ʼ.
rem �������Temporary Setup Files
echo �������Temporary Setup Files.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������DirectX��ɫ������
echo �������DirectX��ɫ������.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\D3D Shader Cache" /v StateFlags0099 /t reg_dword /d 2 /f
rem ����������Ż��ļ�
echo ����������Ż��ļ�.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Delivery Optimization Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������������ݲ鿴�����ݿ��ļ�
echo �������������ݲ鿴�����ݿ��ļ�.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Diagnostic Data Viewer database files" /v StateFlags0099 /t reg_dword /d 2 /f
rem ������������صĳ����ļ�
echo ������������صĳ����ļ�.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������Internet��ʱ�ļ�
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������������Դ�ļ�
echo �������������Դ�ļ�.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Language Pack" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������ɵ�Chkdsk�ļ�
echo �������ɵ�Chkdsk�ļ�.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem ����������վ
echo ����������վ.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������RetailDemo Offline Content
echo �������RetailDemo Offline Content.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\RetailDemo Offline Content" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������������־�ļ�
echo �������������־�ļ�.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������ϵͳ�����ڴ�ת���ļ�
echo �������ϵͳ�����ڴ�ת���ļ�.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������ϵͳ����С��ת���ļ�
echo �������ϵͳ����С��ת���ļ�.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files" /v StateFlags0099 /t reg_dword /d 2 /f
rem ���������ʱ�ļ�
echo ���������ʱ�ļ�.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem �����������ͼ
echo �����������ͼ.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������Windows��������
echo �������Windows��������.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" /v StateFlags0099 /t reg_dword /d 2 /f
rem ��������û��ļ���ʷ��¼
echo ��������û��ļ���ʷ��¼.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\User file versions" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������Microsoft Defender������
echo �������Microsoft Defender������.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /v StateFlags0099 /t reg_dword /d 2 /f
rem �������Windows���󱨸�ͷ������
echo �������Windows���󱨸�ͷ������.
start /wait reg add  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Files" /v StateFlags0099 /t reg_dword /d 2 /f
rem ������д������������
echo ������д������������. 
rem ��������������
start /wait cleanmgr /sagerun:99
echo ������������������.
rem ��ȡ����������������
echo list volume>%temp%\vl.vbs
for /f "tokens=1,2,3,4* delims= " %%a in ('diskpart /s %temp%\vl.vbs^|findstr "���̷���"^|findstr /v "ϵͳ����"') do (
set driver=%%c
echo ����!driver!�̿�ʼ.
start /wait /b chkdsk /scan /forceofflinefix !driver!:
echo ����!driver!�̽���.
)
rem ��ѯ��ϵͳ�̵������ÿռ�������
echo ��ѯ��ϵͳ�̵������ÿռ���������ʼ.
set maxSize=
set maxVol=
set maxUnit=
set winVol=!windir:~0,1!
for /f "tokens=1,2,3,4* delims= " %%a in ('diskpart /s %temp%\vl.vbs^|findstr "���̷���"^|findstr /v "ϵͳ����"') do (
if not "%%c" equ "!winVol!" (  
echo select volume %%c>%temp%\v3.vbs 
echo detail volume>>%temp%\v3.vbs
for /f "tokens=1,2* delims=:" %%x in ('diskpart /s %temp%\v3.vbs^|findstr "����ÿռ�"') do (
set temp=%%y
set leftSize=!temp:~2,-2!
set maxUnit=!temp:~-2!
if "!maxSize!" equ "" (
set maxSize=!leftSize!
set maxVol=%%c
) else (
if "!maxSize!" lss "!leftSize!" (
set maxSize=!leftSize!
set maxVol=%%c
)
)
)
)
)
echo ��ϵͳ�������ÿռ�!maxSize!,��λ!maxUnit!,�����ڴ�Ҫ���õ�������!maxVol!.
echo ��ѯ��ϵͳ�̵������ÿռ�����������.
rem ���������ڴ�
echo ����!maxVol!����ϵͳ����������ڴ�
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management" /v PagingFiles /t REG_MULTI_SZ /d "!maxVol!:\pagefile.sys 0 0" /f
echo �Ż�����.
pause