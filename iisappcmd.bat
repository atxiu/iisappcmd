@echo off
%systemroot%\system32\inetsrv\AppCmd.exe list sites /state:Started /text:name > test.txt
for /f "delims=" %%i in (test.txt)^
do (
    echo "获取%%i"
    echo %%i >> iisappcmd.txt
    echo --- >> iisappcmd.txt
    echo "获取%%i绑定域名"
    %systemroot%\system32\inetsrv\AppCmd.exe list site %%i /text:bindings >> iisappcmd.txt
    echo --- >> iisappcmd.txt
    echo "获取%%i根目录"
    %systemroot%\system32\inetsrv\AppCmd.exe list vdirs %%i/ /text:physicalPath >> iisappcmd.txt
    echo --- >> iisappcmd.txt
    echo "获取%%iPHP信息"
    %systemroot%\system32\inetsrv\AppCmd.exe list Config %%i /section:system.webServer/handlers | findstr "php" >> iisappcmd.txt
    echo --- >> iisappcmd.txt
    echo "获取%%i默认入口文件"
    %systemroot%\system32\inetsrv\AppCmd.exe list Config %%i /section:system.webServer/defaultDocument | findstr "value" >> iisappcmd.txt
    echo ___ >> iisappcmd.txt
)
