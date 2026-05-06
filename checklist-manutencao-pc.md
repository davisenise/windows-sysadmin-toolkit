# 🔧 Checklist de Manutenção de PC

> Guia prático para manutenção preventiva e corretiva de computadores.  
> Autor: Davi Senise | Técnico de Suporte TI

---

## 🛠️ Manutenção Preventiva (Mensal)

### Sistema Operacional
- [ ] Verificar e instalar atualizações do Windows
- [ ] Checar atualizações opcionais (drivers via Windows Update)
- [ ] Limpar arquivos temporários (`%temp%` e `temp` no Executar)
- [ ] Esvaziar lixeira
- [ ] Verificar espaço em disco (mínimo 15% livre)

### Segurança
- [ ] Atualizar definições do antivírus
- [ ] Realizar varredura completa de vírus e malwares
- [ ] Verificar programas desconhecidos instalados
- [ ] Checar programas na inicialização (Gerenciador de Tarefas → Inicializar)

### Performance
- [ ] Verificar uso de CPU e RAM em idle (deve ser abaixo de 20%)
- [ ] Checar temperatura da CPU e GPU (ideal: abaixo de 70°C em carga)
- [ ] Desfragmentar HDD (não aplicar em SSDs)
- [ ] Verificar integridade do disco:
```cmd
chkdsk C: /f /r
```

---

## 🧹 Manutenção Física (A cada 3-6 meses)

- [ ] Desligar e desconectar o PC da tomada
- [ ] Abrir o gabinete
- [ ] Limpar com ar comprimido: coolers, dissipadores, slots de RAM, GPU
- [ ] Limpar filtros de poeira do gabinete
- [ ] Verificar cabos soltos ou danificados
- [ ] Verificar pasta térmica (reaplicar se CPU passar de 85°C em carga)
- [ ] Fechar gabinete e testar

---

## ⚠️ Diagnóstico de Problemas Comuns

### PC lento
- [ ] Verificar uso de CPU/RAM/Disco no Gerenciador de Tarefas
- [ ] Checar se há vírus ou malware
- [ ] Verificar temperatura (superaquecimento causa throttling)
- [ ] Checar saúde do HD/SSD com CrystalDiskInfo
- [ ] Limpar inicialização

### PC não liga
- [ ] Verificar cabo de energia e tomada
- [ ] Testar com outro cabo/fonte
- [ ] Verificar se a fonte está ligada (botão atrás)
- [ ] Retirar e recolocar os pentes de RAM
- [ ] Verificar LED de diagnóstico da placa-mãe (se houver)

### Tela azul (BSOD)
- [ ] Anotar o código de erro
- [ ] Verificar atualizações pendentes
- [ ] Atualizar ou reverter drivers recentes
- [ ] Rodar `sfc /scannow` no CMD como administrador
- [ ] Testar RAM com Windows Memory Diagnostic

### Internet lenta / sem conexão
- [ ] Reiniciar roteador e modem
- [ ] Verificar cabo de rede ou sinal Wi-Fi
- [ ] `ipconfig /release` e `ipconfig /renew` no CMD
- [ ] `netsh winsock reset` e reiniciar
- [ ] Atualizar driver de placa de rede

---

## 🔨 Ferramentas Essenciais

| Ferramenta | Uso | Link |
|---|---|---|
| CrystalDiskInfo | Saúde do HD/SSD | https://crystalmark.info |
| HWMonitor | Temperaturas e tensões | https://www.cpuid.com/softwares/hwmonitor.html |
| Malwarebytes | Remoção de malware | https://www.malwarebytes.com |
| Autoruns | Gerenciar inicialização | https://learn.microsoft.com/sysinternals/downloads/autoruns |
| DDU | Desinstalar drivers GPU | https://www.wagnardsoft.com |
| Rufus | Criar pendrive bootável | https://rufus.ie |

---

## 💻 Comandos úteis (CMD / PowerShell como Admin)

```cmd
# Verificar integridade dos arquivos do sistema
sfc /scannow

# Reparar imagem do Windows
DISM /Online /Cleanup-Image /RestoreHealth

# Verificar disco
chkdsk C: /f /r

# Resetar configurações de rede
netsh winsock reset
ipconfig /flushdns

# Ver temperatura via PowerShell
Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"
```

---

## 📋 Relatório pós-manutenção (modelo)

```
Data: ___/___/______
Técnico: Davi Senise
Cliente/Equipamento: _______________

Serviços realizados:
[ ] Limpeza física
[ ] Formatação
[ ] Remoção de vírus
[ ] Troca de pasta térmica
[ ] Substituição de componente: _______________
[ ] Outros: _______________

Observações:
_______________________________________________

Status: ✅ Resolvido | ⚠️ Requer acompanhamento | ❌ Pendente
```

---

*Checklist baseado em experiência prática com mais de 50 atendimentos realizados.*
