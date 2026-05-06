# 🪟 Guia Definitivo de Otimização — Windows 11

> Guia prático baseado em experiência real de suporte técnico. Aplicável também ao Windows 10.
> Autor: Davi Senise | Técnico de Suporte TI

---

## 1️⃣ Instalação limpa do sistema (Opcional)

Instale o Windows 11 do zero sempre que possível para evitar resíduos de instalações anteriores.

---

## 2️⃣ Atualizações do Windows

Rode as atualizações normais e também as **Atualizações Opcionais**, que contêm drivers importantes:

```
Windows Update → Opções Avançadas → Atualizações Opcionais
```

---

## 3️⃣ Drivers críticos

Os dois mais importantes são **Placa de Vídeo** e **Chipset**.

| Fabricante | Link |
|---|---|
| AMD (GPU + Chipset) | https://www.amd.com/es/support |
| NVIDIA | https://la.nvidia.com/Download/index.aspx |
| Intel Chipset | https://www.intel.com/content/www/us/en/download/19347 |

> ⚠️ Evite instalar drivers de periféricos (mouse, teclado) a menos que seja estritamente necessário.

---

## 4️⃣ Ativação do Windows

Via PowerShell como Administrador:

```powershell
irm https://get.activated.win | iex
```

Projeto: https://github.com/massgravel/Microsoft-Activation-Scripts  
Funciona para Windows 10, 11, Server e Office.

---

## 5️⃣ Opções de Energia

`Painel de Controle → Opções de Energia → Alto Desempenho`

- Em **desktops**: Alto Desempenho ou Desempenho Máximo
- Em **notebooks**: Equilibrado

> 💡 Dica: Edite o plano e defina "Estado mínimo do processador: 5%" para economizar energia em standby sem perda de performance.

---

## 6️⃣ WinUtil — Otimizações automáticas

Ferramenta do Chris Titus Tech. Execute via PowerShell como Administrador:

```powershell
irm "https://christitus.com/win" | iex
```

**Na aba Tweaks — Essential Tweaks (marcar):**
- [x] Activity History - Disable
- [x] ConsumerFeatures - Disable
- [x] Disk Cleanup - Run
- [x] End Task With Right Click - Enable
- [x] PowerShell 7 Telemetry - Disable
- [x] Restore Point - Create
- [x] Services - Set to Manual
- [x] Telemetry - Disable
- [x] Temporary Files - Remove

**Advanced Tweaks — CAUTION (marcar):**
- [x] Background Apps - Disable
- [x] File Explorer Gallery - Disable
- [x] File Explorer Home - Disable
- [x] Microsoft Edge - Debloat
- [x] Notification Tray & Calendar - Disable
- [x] Teredo - Disable
- [x] Unwanted Pre-Installed Apps - Remove
- [x] Visual Effects - Set to Best Performance

> ⚠️ Não marcar: IPv6 - Disable, Microsoft Edge - Remove, Microsoft OneDrive - Remove (pode precisar depois), Xbox & Gaming Components (se usar jogos)

Clique em **Run Tweaks** → Reinicie.

Após reiniciar, abra novamente e clique em **Run OO Shutup 10** → aplique as configurações → Reinicie.

---

## 7️⃣ Remoção de bloatware

Execute no PowerShell como Administrador:

```powershell
# Bloatware principal
Get-AppxPackage -AllUsers MicrosoftCorporationII.QuickAssist | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.WindowsFeedbackHub | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.Copilot | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.BingSearch | Remove-AppxPackage
Get-AppxPackage -AllUsers Clipchamp.Clipchamp | Remove-AppxPackage
Get-AppxPackage -AllUsers MSTeams | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.Todos | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.MicrosoftStickyNotes | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.OutlookForWindows | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.WindowsAlarms | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage

# Opcionais
Get-AppxPackage -AllUsers Microsoft.WindowsCamera | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.WindowsSoundRecorder | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.ScreenSketch | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.OneDriveSync | Remove-AppxPackage
Start-Process -FilePath "$env:SystemRoot\System32\OneDriveSetup.exe" -ArgumentList "/uninstall" -NoNewWindow -Wait

# Xbox (se não usar)
Get-AppxPackage -AllUsers Microsoft.Xbox.TCUI | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.GamingApp | Remove-AppxPackage
```

---

## 8️⃣ Otimizações NVIDIA (se aplicável)

No Painel de Controle NVIDIA:
- **Cache do Shader**: 10 GB
- **Otimização Encadeada (Threaded Optimization)**: Desativado

Desative o **Modo Jogo** do Windows:
```
Barra de tarefas → pesquise "Modo Jogo" → Desativar
```

---

## 9️⃣ Otimização de Frametime (RTSS)

Baixe o **RivaTuner Statistics Server**:  
https://www.guru3d.com/files-details/rtss-rivatuner-statistics-server-download.html

- Desative V-Sync, Double/Triple Buffer no jogo
- Limite FPS pelo RTSS: **taxa do monitor - 3**  
  Exemplos: Monitor 144Hz → 141 FPS | Monitor 240Hz → 237 FPS
- RTSS deve iniciar com o sistema

> 💡 Para NVIDIA: ative NVIDIA REFLEX no menu do jogo (apenas "Ativado", nunca "Ativado+Boost")

---

## 🔟 Otimização de HPET

PowerShell como Administrador:

```powershell
bcdedit /set useplatformtick yes
bcdedit /set disabledynamictick yes
bcdedit /deletevalue useplatformclock
```

> ⚠️ Se o último comando der erro, ignore — é preventivo.

Reinicie e baixe o **ISLC (Timertool)**:  
https://www.wagnardsoft.com/forums/viewtopic.php?t=1256

Configurações:
- Marque os 4 checks
- "Free memory is lower than": RAM total arredondada (ex: 32000 MB para 32 GB)
- "ISLC polling rate": polling rate do seu mouse (geralmente 1000 Hz)

---

## 1️⃣1️⃣ Antivírus

Substitua o Windows Defender pelo **Panda Free Antivirus**:  
https://www.pandasecurity.com/es/homeusers/free-antivirus/

> Isso desativa automaticamente o Defender. Tentar desativar o Defender manualmente não funciona permanentemente.

---

## 1️⃣2️⃣ Programas na inicialização

Abra o Gerenciador de Tarefas → aba **Inicializar** → desative tudo, exceto:
- Antivírus
- ISLC (Timertool)
- Aplicativos essenciais (ex: Discord)

---

## ✅ Resultado esperado

Após seguir todos os passos:
- Sistema mais leve e responsivo
- Menor input lag
- Frametime estável
- Sem bloatware

---

## 📋 Checklist rápido

- [ ] Instalação limpa
- [ ] Windows Update + Atualizações Opcionais
- [ ] Drivers GPU e Chipset
- [ ] Windows ativado
- [ ] Plano de energia: Alto Desempenho
- [ ] WinUtil executado
- [ ] Bloatware removido
- [ ] NVIDIA configurada (se aplicável)
- [ ] Modo Jogo desativado
- [ ] RTSS instalado e configurado
- [ ] HPET otimizado
- [ ] Antivírus instalado
- [ ] Inicialização limpa

---

*Guia baseado em experiência prática de suporte técnico. Testado em múltiplos ambientes corporativos e domésticos.*
