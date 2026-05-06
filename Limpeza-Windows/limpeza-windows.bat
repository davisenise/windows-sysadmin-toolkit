@echo off
title Limpeza do Windows - Davi Senise TI
color 0A

:MENU
cls
echo ================================================
echo        LIMPEZA E OTIMIZACAO DO WINDOWS
echo        Tecnico: Davi Senise - Suporte TI
echo ================================================
echo.
echo  [1] Limpeza completa (recomendado)
echo      - Arquivos temporarios do sistema e usuario
echo      - Cache do Windows Update
echo      - Lixeira
echo      - Logs antigos do sistema
echo      - Prefetch
echo.
echo  [2] Limpeza rapida
echo      - Apenas arquivos temporarios
echo      - Lixeira
echo.
echo  [3] Ver espaco em disco
echo.
echo  [0] Sair
echo.
echo ================================================
set /p opcao= Escolha uma opcao: 

if "%opcao%"=="1" goto LIMPEZA_COMPLETA
if "%opcao%"=="2" goto LIMPEZA_RAPIDA
if "%opcao%"=="3" goto VER_DISCO
if "%opcao%"=="0" goto SAIR
goto MENU

:VER_DISCO
cls
echo ================================================
echo           ESPACO EM DISCO ATUAL
echo ================================================
echo.
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | ForEach-Object { Write-Host ($_.DeviceID + ' Livre: ' + [math]::Round($_.FreeSpace/1GB,1) + 'GB / Total: ' + [math]::Round($_.Size/1GB,1) + 'GB') }"
echo.
pause
goto MENU

:LIMPEZA_RAPIDA
cls
echo ================================================
echo              LIMPEZA RAPIDA
echo ================================================
echo.
echo  Sera executado:
echo  - Limpeza de arquivos temporarios do usuario
echo  - Esvaziamento da lixeira
echo.
set /p confirma= Confirmar? (S/N): 
if /i "%confirma%"=="S" goto EXEC_RAPIDA
goto MENU

:EXEC_RAPIDA
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0limpeza-windows.ps1" -Tipo "rapida"
goto MENU

:LIMPEZA_COMPLETA
cls
echo ================================================
echo            LIMPEZA COMPLETA
echo ================================================
echo.
echo  ATENCAO: Sera executado:
echo  [1] Arquivos temporarios do usuario
echo  [2] Arquivos temporarios do sistema
echo  [3] Cache do Windows Update
echo  [4] Lixeira
echo  [5] Logs antigos do sistema
echo  [6] Prefetch
echo.
set /p confirma= Confirmar limpeza completa? (S/N): 
if /i "%confirma%"=="S" goto EXEC_COMPLETA
goto MENU

:EXEC_COMPLETA
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0limpeza-windows.ps1" -Tipo "completa"
goto MENU

:SAIR
cls
echo  Ate mais! - Davi Senise TI
timeout /t 2 >nul
exit
