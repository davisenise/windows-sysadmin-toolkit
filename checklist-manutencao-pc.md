# Checklist de manutenção de PC

Guia prático de manutenção preventiva e corretiva. Pensado pra ser seguido na ordem, marcando o que já foi feito.

Autor: Davi Senise — Técnico de Suporte TI

---

## Manutenção preventiva (mensal)

### Sistema operacional
- [ ] Instalar atualizações do Windows
- [ ] Checar atualizações opcionais (drivers via Windows Update)
- [ ] Limpar arquivos temporários (`%temp%` no Executar)
- [ ] Esvaziar a lixeira
- [ ] Verificar espaço em disco (mínimo ~15% livre)

### Segurança
- [ ] Atualizar definições do antivírus
- [ ] Rodar varredura completa
- [ ] Revisar programas instalados desconhecidos
- [ ] Revisar programas na inicialização

### Performance
- [ ] Verificar uso de CPU e RAM em repouso
- [ ] Checar temperatura de CPU e GPU (ideal abaixo de ~70°C em carga)
- [ ] Verificar saúde do disco (CrystalDiskInfo)
- [ ] Desfragmentar **apenas HDD** — nunca SSD

---

## Manutenção física (a cada 3–6 meses)

- [ ] Desligar e tirar o PC da tomada
- [ ] Abrir o gabinete
- [ ] Limpar com ar comprimido: coolers, dissipadores, slots de RAM, GPU
- [ ] Limpar filtros de poeira
- [ ] Conferir cabos soltos ou danificados
- [ ] Avaliar pasta térmica (reaplicar se CPU passar de ~85°C em carga)
- [ ] Fechar e testar

---

## Diagnóstico de problemas comuns

### PC lento
- [ ] Ver uso de CPU/RAM/Disco no Gerenciador de Tarefas
- [ ] Checar vírus/malware
- [ ] Verificar temperatura (superaquecimento causa throttling)
- [ ] Checar saúde do disco (CrystalDiskInfo)
- [ ] Limpar inicialização

### PC não liga
- [ ] Testar cabo de energia e tomada
- [ ] Testar com outro cabo/fonte
- [ ] Conferir o botão da fonte (atrás)
- [ ] Reassentar os pentes de RAM
- [ ] Verificar LED de diagnóstico da placa-mãe (se houver)

### Tela azul (BSOD)
- [ ] Anotar o código de erro
- [ ] Verificar atualizações pendentes
- [ ] Atualizar ou reverter drivers recentes
- [ ] Rodar `sfc /scannow` (CMD como Admin)
- [ ] Testar RAM com o Diagnóstico de Memória do Windows

### Internet lenta / sem conexão
- [ ] Reiniciar roteador e modem
- [ ] Conferir cabo de rede ou sinal Wi-Fi
- [ ] `ipconfig /release` e `ipconfig /renew`
- [ ] `netsh winsock reset` e reiniciar
- [ ] Atualizar driver da placa de rede

---

## Ferramentas essenciais

| Ferramenta | Uso |
|---|---|
| CrystalDiskInfo | Saúde do HD/SSD |
| HWMonitor | Temperaturas e tensões |
| Malwarebytes | Remoção de malware |
| Autoruns (Sysinternals) | Gerenciar inicialização |
| DDU | Remover drivers de GPU |
| Rufus | Criar pendrive bootável |

---

## Comandos úteis (CMD / PowerShell como Admin)

```cmd
:: Verificar integridade dos arquivos do sistema
sfc /scannow

:: Reparar a imagem do Windows
DISM /Online /Cleanup-Image /RestoreHealth

:: Verificar disco (roda no próximo boot na unidade do sistema)
chkdsk C: /f /r

:: Resetar rede
netsh winsock reset
ipconfig /flushdns
```

> `chkdsk C: /f /r` na unidade do sistema não roda na hora — ele agenda pro próximo boot. Avise o usuário, porque pode demorar.

---

## Modelo de relatório pós-atendimento

```
Data: ___/___/______
Técnico: Davi Senise
Cliente / Equipamento: _______________

Serviços realizados:
[ ] Limpeza física
[ ] Formatação
[ ] Remoção de vírus
[ ] Troca de pasta térmica
[ ] Substituição de componente: _______________
[ ] Outros: _______________

Observações:
_______________________________________________

Status:  Resolvido  |  Requer acompanhamento  |  Pendente
```

---

*Checklist baseado em experiência prática de atendimento.*
