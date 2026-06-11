<#
    Inventario de Hardware do Sistema
    Autor : Davi Senise - Suporte TI
    Coleta SO, CPU, RAM, placa-mae, GPU, discos, espaco e rede.
    Salva relatorio .txt no Desktop.
#>

$desktop = (Get-Item ([System.Environment]::GetFolderPath("Desktop"))).FullName
$data    = Get-Date -Format 'yyyyMMdd_HHmm'
$arquivo = "$desktop\inventario_$($env:COMPUTERNAME)_$data.txt"

$out = @()
$out += '================================================'
$out += '   INVENTARIO DE HARDWARE DO SISTEMA'
$out += '   Tecnico: Davi Senise - Suporte TI'
$out += '================================================'
$out += ''
$out += 'Data: ' + (Get-Date -Format 'dd/MM/yyyy HH:mm')
$out += 'Hostname: ' + $env:COMPUTERNAME
$out += 'Usuario: ' + $env:USERNAME
$out += ''

# --- SISTEMA OPERACIONAL ---
$out += '[SISTEMA OPERACIONAL]'
try {
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
    $out += 'Nome: ' + $os.Caption
    $out += 'Versao: ' + $os.Version
    $out += 'Build: ' + $os.BuildNumber
    $out += 'Arquitetura: ' + $os.OSArchitecture
} catch { $out += 'Falha ao coletar SO: ' + $_.Exception.Message }
$out += ''

# --- PROCESSADOR ---
$out += '[PROCESSADOR]'
try {
    $cpu = Get-CimInstance Win32_Processor -ErrorAction Stop | Select-Object -First 1
    $out += 'Nome: ' + $cpu.Name.Trim()
    $out += 'Nucleos fisicos: ' + $cpu.NumberOfCores
    $out += 'Nucleos logicos: ' + $cpu.NumberOfLogicalProcessors
    $out += 'Clock max: ' + $cpu.MaxClockSpeed + ' MHz'
} catch { $out += 'Falha ao coletar CPU: ' + $_.Exception.Message }
$out += ''

# --- MEMORIA RAM ---
$out += '[MEMORIA RAM]'
try {
    $sys = Get-CimInstance Win32_ComputerSystem -ErrorAction Stop
    $out += 'Total: ' + [math]::Round($sys.TotalPhysicalMemory/1GB, 2) + ' GB'
    $pentes = Get-CimInstance Win32_PhysicalMemory -ErrorAction Stop
    foreach ($p in $pentes) {
        $out += 'Pente: ' + [math]::Round($p.Capacity/1GB,0) + 'GB - ' + $p.Speed + 'MHz - ' + $p.Manufacturer
    }
} catch { $out += 'Falha ao coletar RAM: ' + $_.Exception.Message }
$out += ''

# --- PLACA-MAE ---
$out += '[PLACA-MAE]'
try {
    $mb = Get-CimInstance Win32_BaseBoard -ErrorAction Stop
    $out += 'Fabricante: ' + $mb.Manufacturer
    $out += 'Modelo: ' + $mb.Product
} catch { $out += 'Falha ao coletar placa-mae: ' + $_.Exception.Message }
$out += ''

# --- PLACA DE VIDEO ---
# AdapterRAM do WMI e uint32, estoura em 4GB. Por isso buscamos o valor real
# (qwMemorySize, 64-bit) no registro, e so usamos o WMI como fallback.
$out += '[PLACA DE VIDEO]'
try {
    $gpus = Get-CimInstance Win32_VideoController -ErrorAction Stop
    $regBase = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
    $regKeys = Get-ChildItem $regBase -ErrorAction SilentlyContinue

    foreach ($g in $gpus) {
        $out += 'Nome: ' + $g.Name
        $vram = $null
        foreach ($k in $regKeys) {
            $info = Get-ItemProperty $k.PSPath -ErrorAction SilentlyContinue
            if ($info.DriverDesc -eq $g.Name -and $info.'HardwareInformation.qwMemorySize') {
                $vram = [math]::Round($info.'HardwareInformation.qwMemorySize'/1GB, 1)
                break
            }
        }
        if (-not $vram -and $g.AdapterRAM) {
            # fallback: pode estar limitado a 4GB pela limitacao do WMI
            $vram = [math]::Round($g.AdapterRAM/1GB, 1)
        }
        $out += 'VRAM: ' + $(if ($vram) { "$vram GB" } else { 'nao detectada' })
        $out += 'Driver: ' + $g.DriverVersion
    }
} catch { $out += 'Falha ao coletar GPU: ' + $_.Exception.Message }
$out += ''

# --- DISCOS ---
# Win32_DiskDrive.MediaType nao diferencia SSD de HDD (retorna "Fixed hard disk"
# pra tudo). Get-PhysicalDisk entrega o tipo real (SSD/HDD) e o barramento (NVMe/SATA).
$out += '[DISCOS]'
try {
    $discos = Get-PhysicalDisk -ErrorAction Stop
    foreach ($d in $discos) {
        $out += 'Modelo: ' + $d.FriendlyName
        $out += 'Tamanho: ' + [math]::Round($d.Size/1GB,0) + ' GB'
        $out += 'Tipo: ' + $d.MediaType
        $out += 'Barramento: ' + $d.BusType
        $out += ''
    }
} catch {
    # fallback pro metodo antigo se Get-PhysicalDisk nao existir
    $discos = Get-CimInstance Win32_DiskDrive -ErrorAction SilentlyContinue
    foreach ($d in $discos) {
        $out += 'Modelo: ' + $d.Model
        $out += 'Tamanho: ' + [math]::Round($d.Size/1GB,0) + ' GB'
        $out += ''
    }
}

# --- ESPACO EM DISCO ---
$out += '[ESPACO EM DISCO]'
try {
    $drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" -ErrorAction Stop
    foreach ($dr in $drives) {
        $out += $dr.DeviceID + ' Livre: ' + [math]::Round($dr.FreeSpace/1GB,1) + 'GB / Total: ' + [math]::Round($dr.Size/1GB,1) + 'GB'
    }
} catch { $out += 'Falha ao coletar espaco em disco: ' + $_.Exception.Message }
$out += ''

# --- REDE ---
$out += '[REDE]'
try {
    $nics = Get-CimInstance Win32_NetworkAdapter -Filter "PhysicalAdapter=True" -ErrorAction Stop
    foreach ($n in $nics) {
        if ($n.MACAddress) {
            $out += 'Nome: ' + $n.Name
            $out += 'MAC: ' + $n.MACAddress
        }
    }
} catch { $out += 'Falha ao coletar rede: ' + $_.Exception.Message }

# --- SALVAR ---
$out | Out-File -FilePath $arquivo -Encoding UTF8
Write-Host ''
Write-Host 'Relatorio salvo em: ' $arquivo -ForegroundColor Green
Write-Host ''
Read-Host 'Pressione Enter para sair'
