# Guia de otimização — Windows 10/11

Guia prático de otimização baseado em atendimento real de suporte. Foco em deixar a máquina estável, limpa e rápida, sem gambiarra e sem nada que comprometa o sistema.

Autor: Davi Senise — Técnico de Suporte TI

> Ordem importa: faça de cima pra baixo. Cada etapa assume que a anterior foi feita.

---

## 1. Atualizações do Windows

Sistema desatualizado é a causa raiz de uma porção de problema que parece "do nada".

- Vá em `Configurações → Windows Update` e instale tudo.
- Entre em `Opções avançadas → Atualizações opcionais` — é onde ficam drivers importantes que o Windows não instala sozinho.
- Reinicie e rode de novo até não sobrar atualização pendente.

---

## 2. Drivers

Os que mais impactam estabilidade e performance são **placa de vídeo** e **chipset**. Baixe sempre do site do fabricante, nunca de site aleatório.

| Componente | Onde baixar |
|---|---|
| GPU NVIDIA | nvidia.com (seção Drivers) |
| GPU/Chipset AMD | amd.com (seção Support) |
| Chipset Intel | intel.com (Download Center) |

> Driver de mouse e teclado: só instale se o periférico tiver função específica (macro, RGB). Pro uso comum, o driver genérico do Windows resolve.

---

## 3. Plano de energia

`Painel de Controle → Opções de Energia`

- **Desktop**: Alto Desempenho.
- **Notebook**: Equilibrado (Alto Desempenho derruba a bateria rápido e esquenta).

No plano escolhido, em `Alterar configurações do plano → Alterar configurações avançadas`, vale checar:
- Disco rígido: desligar após "Nunca" (evita travadinha ao acordar o disco).
- Suspensão seletiva USB: desativada se algum periférico desconecta sozinho.

---

## 4. Remoção de bloatware

App pré-instalado que o usuário nunca abre consome espaço e às vezes roda em segundo plano. Dá pra remover com PowerShell **como Administrador**.

> Antes de sair removendo: confirme com o usuário/empresa o que realmente não é usado. Em ambiente corporativo, alguns desses apps fazem parte do fluxo de trabalho.

```powershell
# Exemplo — remove apps de consumo comuns
$apps = @(
    'Microsoft.BingWeather',
    'Microsoft.BingNews',
    'Microsoft.WindowsFeedbackHub',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.WindowsAlarms'
)

foreach ($app in $apps) {
    Get-AppxPackage -AllUsers $app | Remove-AppxPackage -ErrorAction SilentlyContinue
}
```

Pra ver tudo que está instalado antes de decidir:

```powershell
Get-AppxPackage -AllUsers | Select-Object Name | Sort-Object Name
```

> Não recomendo remover OneDrive, Store ou componentes do sistema — costuma dar dor de cabeça depois e o ganho é mínimo.

---

## 5. Programas na inicialização

Metade da lentidão "no boot" é programa abrindo junto com o Windows sem necessidade.

`Gerenciador de Tarefas → aba Inicializar` → desative o que não precisa subir com o sistema. Mantenha:
- Antivírus
- Apps que o usuário realmente usa logo de cara

Pra inicialização mais detalhada (serviços, tarefas agendadas), o **Autoruns** (Sysinternals, da própria Microsoft) mostra tudo: learn.microsoft.com/sysinternals/downloads/autoruns

---

## 6. Ferramentas de otimização

O **WinUtil** (open-source, do Chris Titus) automatiza vários ajustes de telemetria, serviços e limpeza numa interface só.

```powershell
irm "https://christitus.com/win" | iex
```

> Ressalva profissional: rodar script remoto direto via `iex` baixa e executa código da internet na hora. Em máquina pessoal, ok. Em ambiente corporativo, **não** rode script remoto sem revisar antes — leia o que a ferramenta faz e confirme se a política da empresa permite. Esse cuidado é o que separa técnico de quem só copia comando.

Ajustes seguros que valem marcar: desativar telemetria, criar ponto de restauração antes, limpar arquivos temporários, ajustar efeitos visuais pra performance.

---

## 7. Antivírus

O **Windows Defender** moderno é competente pra maioria dos casos — mantenha ele ativo e atualizado em vez de trocar por terceiros sem motivo. Antivírus extra só faz sentido quando há exigência específica da empresa ou um cenário que justifique.

Mantenha:
- Proteção em tempo real ligada
- Definições atualizadas (vem junto do Windows Update)
- Uma varredura completa de tempos em tempos

---

## Resultado esperado

Depois de seguir o guia:
- Boot mais rápido (inicialização limpa)
- Menos consumo de RAM/CPU em segundo plano
- Sem bloatware sobrando
- Sistema atualizado e com drivers certos

---

## Checklist rápido

- [ ] Windows Update + atualizações opcionais
- [ ] Drivers de GPU e chipset
- [ ] Plano de energia ajustado
- [ ] Bloatware removido (com o aval do usuário)
- [ ] Inicialização limpa
- [ ] Telemetria/temporários tratados (WinUtil)
- [ ] Defender ativo e atualizado

---

> Tweaks específicos de gaming (HPET, limitador de FPS, frametime, timer de mouse) saíram deste guia de propósito: mexem em configuração de boot e são de nicho. Se você quiser, dá pra montar um repo separado só pra otimização de PC gamer — assim este guia continua sendo referência limpa pra suporte corporativo.

*Guia baseado em experiência prática de suporte técnico, testado em ambientes corporativos e domésticos.*
