@echo off
title Inventario de Hardware - Davi Senise TI
color 0A

cls
echo ================================================
echo        INVENTARIO DE HARDWARE DO SISTEMA
echo        Tecnico: Davi Senise - Suporte TI
echo ================================================
echo.
echo  As seguintes informacoes serao coletadas:
echo.
echo  - Sistema Operacional
echo  - Processador (CPU)
echo  - Memoria RAM
echo  - Placa-mae
echo  - Placa de Video (GPU)
echo  - Discos e armazenamento
echo  - Adaptadores de rede
echo  - Espaco em disco
echo.
echo ================================================
set /p confirma= Iniciar coleta? (S/N): 
if /i "%confirma%"=="N" goto SAIR

echo.
echo  Coletando informacoes, aguarde...
echo.

PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0inventario-hardware.ps1"

:SAIR
exit
