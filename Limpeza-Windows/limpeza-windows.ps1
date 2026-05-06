param([string]$Tipo)

$desktop = (Get-Item ([System.Environment]::GetFolderPath("Desktop"))).FullName
$data = Get-Date -Format 'yyyyMMdd_HHmm'
$arquivo = "$desktop\limpeza_$($env:COMPUTERNAME)_$data.txt"

$log = @()
$log += '================================================'
$log += '   RELATORIO DE LIMPEZA DO WINDOWS'
$log += '   Tecnico: Davi Senise - Suporte TI'
$log += '================================================'
$log += ''
$log += 'Data: ' + (Get-Date -Format 'dd/MM/yyyy HH:mm')
$log += 'Maquina: ' + $env:COMPUTERNAME
$log += 'Usuario: ' + $env:USERNAME
$log += 'Tipo: ' + $Tipo
$log += ''

Write-Host ''

if ($Tipo -eq 'completa') {
    Write-Host '[1/7] Limpando temporarios do usuario...'
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    $log += '[1/7] Temporarios do usuario: Concluido'
    Write-Host '      Concluido!'

    Write-Host '[2/7] Limpando temporarios do sistema...'
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    $log += '[2/7] Temporarios do sistema: Concluido'
    Write-Host '      Concluido!'

    Write-Host '[3/7] Limpando cache do Windows Update...'
    Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
    Start-Service wuauserv -ErrorAction SilentlyContinue
    $log += '[3/7] Cache Windows Update: Concluido'
    Write-Host '      Concluido!'

    Write-Host '[4/7] Esvaziando lixeira...'
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    $log += '[4/7] Lixeira: Concluido'
    Write-Host '      Concluido!'

    Write-Host '[5/7] Limpando Prefetch...'
    Remove-Item "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
    $log += '[5/7] Prefetch: Concluido'
    Write-Host '      Concluido!'

    Write-Host '[6/7] Limpando logs antigos...'
    Get-ChildItem "C:\Windows\Logs" -Recurse -Filter *.log -ErrorAction SilentlyContinue |
        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } |
        Remove-Item -Force -ErrorAction SilentlyContinue
    $log += '[6/7] Logs antigos: Concluido'
    Write-Host '      Concluido!'

    Write-Host '[7/7] Executando Limpeza de Disco (cleanmgr)...'
    Start-Process cleanmgr -ArgumentList '/sagerun:1' -Wait -ErrorAction SilentlyContinue
    $log += '[7/7] Limpeza de Disco (cleanmgr): Concluido'
    Write-Host '      Concluido!'

} else {
    Write-Host '[1/2] Limpando temporarios do usuario...'
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    $log += '[1/2] Temporarios do usuario: Concluido'
    Write-Host '      Concluido!'

    Write-Host '[2/2] Esvaziando lixeira...'
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    $log += '[2/2] Lixeira: Concluido'
    Write-Host '      Concluido!'
}

$log += ''
$log += '[ESPACO EM DISCO APOS LIMPEZA]'
$drives = Get-CimInstance Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}
foreach($dr in $drives){
    $linha = $dr.DeviceID + ' Livre: ' + [math]::Round($dr.FreeSpace/1GB,1) + 'GB / Total: ' + [math]::Round($dr.Size/1GB,1) + 'GB'
    $log += $linha
    Write-Host $linha
}

$log += ''
$log += 'Status: Concluido com sucesso'
$log | Out-File -FilePath $arquivo -Encoding UTF8

Write-Host ''
Write-Host '================================================'
Write-Host ' Limpeza concluida!'
Write-Host ' Relatorio salvo em: ' $arquivo
Write-Host '================================================'
Write-Host ''
Read-Host 'Pressione Enter para voltar ao menu'
