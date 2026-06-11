@echo off
title Inventario de Hardware - Davi Senise TI
color 0A

:: Eleva pra Administrador automaticamente se ainda nao estiver
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando permissao de Administrador...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cls
echo ================================================
echo        INVENTARIO DE HARDWARE DO SISTEMA
echo        Tecnico: Davi Senise - Suporte TI
echo ================================================
echo.
echo  Informacoes coletadas:
echo.
echo   - Sistema Operacional
echo   - Processador (CPU)
echo   - Memoria RAM (total e por pente)
echo   - Placa-mae
echo   - Placa de Video (GPU) e VRAM real
echo   - Discos (SSD/HDD e barramento)
echo   - Espaco em disco
echo   - Adaptadores de rede
echo.
echo ================================================
set /p confirma= Iniciar coleta? (S/N): 
if /i "%confirma%"=="N" goto SAIR

echo.
echo  Coletando, aguarde...
echo.

PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0inventario-hardware.ps1"

:SAIR
exit
