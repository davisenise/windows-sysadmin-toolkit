$desktop = (Get-Item ([System.Environment]::GetFolderPath("Desktop"))).FullName
$data = Get-Date -Format 'yyyyMMdd_HHmm'
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

$out += '[SISTEMA OPERACIONAL]'
$os = Get-CimInstance Win32_OperatingSystem
$out += 'Nome: ' + $os.Caption
$out += 'Versao: ' + $os.Version
$out += 'Build: ' + $os.BuildNumber
$out += 'Arquitetura: ' + $os.OSArchitecture
$out += ''

$out += '[PROCESSADOR]'
$cpu = Get-CimInstance Win32_Processor
$out += 'Nome: ' + $cpu.Name
$out += 'Nucleos fisicos: ' + $cpu.NumberOfCores
$out += 'Nucleos logicos: ' + $cpu.NumberOfLogicalProcessors
$out += 'Clock max: ' + $cpu.MaxClockSpeed + ' MHz'
$out += ''

$out += '[MEMORIA RAM]'
$ram = Get-CimInstance Win32_ComputerSystem
$out += 'Total: ' + [math]::Round($ram.TotalPhysicalMemory/1GB, 2) + ' GB'
$pentes = Get-CimInstance Win32_PhysicalMemory
foreach($p in $pentes){ $out += 'Pente: ' + [math]::Round($p.Capacity/1GB,0) + 'GB - ' + $p.Speed + 'MHz - ' + $p.Manufacturer }
$out += ''

$out += '[PLACA-MAE]'
$mb = Get-CimInstance Win32_BaseBoard
$out += 'Fabricante: ' + $mb.Manufacturer
$out += 'Modelo: ' + $mb.Product
$out += ''

$out += '[PLACA DE VIDEO]'
$gpu = Get-CimInstance Win32_VideoController
foreach($g in $gpu){
    $out += 'Nome: ' + $g.Name
    $out += 'VRAM: ' + [math]::Round($g.AdapterRAM/1GB,1) + ' GB'
    $out += 'Driver: ' + $g.DriverVersion
}
$out += ''

$out += '[DISCOS]'
$discos = Get-CimInstance Win32_DiskDrive
foreach($d in $discos){
    $out += 'Modelo: ' + $d.Model
    $out += 'Tamanho: ' + [math]::Round($d.Size/1GB,0) + ' GB'
    $out += 'Tipo: ' + $d.MediaType
}
$out += ''

$out += '[ESPACO EM DISCO]'
$drives = Get-CimInstance Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}
foreach($dr in $drives){
    $out += $dr.DeviceID + ' Livre: ' + [math]::Round($dr.FreeSpace/1GB,1) + 'GB / Total: ' + [math]::Round($dr.Size/1GB,1) + 'GB'
}
$out += ''

$out += '[REDE]'
$nics = Get-CimInstance Win32_NetworkAdapter | Where-Object {$_.PhysicalAdapter -eq $true}
foreach($n in $nics){
    $out += 'Nome: ' + $n.Name
    $out += 'MAC: ' + $n.MACAddress
}

$out | Out-File -FilePath $arquivo -Encoding UTF8
Write-Host ''
Write-Host 'Relatorio salvo em: ' $arquivo
Write-Host ''
Read-Host 'Pressione Enter para sair'
