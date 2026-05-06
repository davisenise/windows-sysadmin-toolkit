@echo off
chcp 65001 >nul
title Inventário de Hardware - Davi Senise TI
color 0A

echo ================================================
echo       INVENTÁRIO DE HARDWARE DO SISTEMA
echo       Técnico: Davi Senise - Suporte TI
echo ================================================
echo.

:: Data e hora
echo [DATA/HORA]
echo Data: %date%  Hora: %time%
echo.

:: Informações do sistema
echo [SISTEMA OPERACIONAL]
wmic os get Caption, Version, BuildNumber, OSArchitecture /format:list | findstr "="
echo.

:: Processador
echo [PROCESSADOR]
wmic cpu get Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed /format:list | findstr "="
echo.

:: Memória RAM
echo [MEMÓRIA RAM]
wmic computersystem get TotalPhysicalMemory /format:list | findstr "="
wmic memorychip get Capacity, Speed, Manufacturer /format:list | findstr "="
echo.

:: Placa-mãe
echo [PLACA-MÃE]
wmic baseboard get Manufacturer, Product, Version /format:list | findstr "="
echo.

:: Placa de vídeo
echo [PLACA DE VÍDEO]
wmic path win32_videocontroller get Name, AdapterRAM, DriverVersion /format:list | findstr "="
echo.

:: Discos
echo [DISCOS / ARMAZENAMENTO]
wmic diskdrive get Model, Size, MediaType /format:list | findstr "="
echo.

:: Rede
echo [ADAPTADORES DE REDE]
wmic nic where "NetEnabled=True" get Name, MACAddress /format:list | findstr "="
echo.

:: Usuário e hostname
echo [INFORMAÇÕES DA MÁQUINA]
echo Hostname: %COMPUTERNAME%
echo Usuário: %USERNAME%
echo.

:: Espaço em disco
echo [ESPAÇO EM DISCO]
wmic logicaldisk get DeviceID, Size, FreeSpace, FileSystem /format:list | findstr "="
echo.

echo ================================================
echo   Inventário concluído! Pressione qualquer tecla
echo ================================================

:: Salvar relatório em arquivo
set "arquivo=inventario_%COMPUTERNAME%_%date:~6,4%%date:~3,2%%date:~0,2%.txt"
(
echo ================================================
echo       INVENTÁRIO DE HARDWARE DO SISTEMA
echo       Técnico: Davi Senise - Suporte TI
echo ================================================
echo.
echo Data: %date%  Hora: %time%
echo Hostname: %COMPUTERNAME%
echo Usuário: %USERNAME%
echo.
echo [SISTEMA OPERACIONAL]
wmic os get Caption, Version, BuildNumber, OSArchitecture /format:list | findstr "="
echo.
echo [PROCESSADOR]
wmic cpu get Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed /format:list | findstr "="
echo.
echo [MEMÓRIA RAM]
wmic computersystem get TotalPhysicalMemory /format:list | findstr "="
echo.
echo [PLACA-MÃE]
wmic baseboard get Manufacturer, Product, Version /format:list | findstr "="
echo.
echo [PLACA DE VÍDEO]
wmic path win32_videocontroller get Name, AdapterRAM, DriverVersion /format:list | findstr "="
echo.
echo [DISCOS]
wmic diskdrive get Model, Size, MediaType /format:list | findstr "="
echo.
echo [REDE]
wmic nic where "NetEnabled=True" get Name, MACAddress /format:list | findstr "="
echo.
echo [ESPAÇO EM DISCO]
wmic logicaldisk get DeviceID, Size, FreeSpace, FileSystem /format:list | findstr "="
) > "%USERPROFILE%\Desktop\%arquivo%"

echo Relatório salvo em: %USERPROFILE%\Desktop\%arquivo%
echo.
pause
