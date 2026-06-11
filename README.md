# windows-sysadmin-toolkit

Coleção de guias, checklists e scripts pra suporte técnico e manutenção de ambientes Windows.

Tudo aqui saiu de atendimento real de suporte N1/N2 — não é teoria de curso. Cada arquivo documenta o que fazer e, principalmente, **por que** fazer, pra qualquer um conseguir entender, repetir e adaptar no próprio ambiente.

---

## conteúdo

| Arquivo | O que é |
|---|---|
| [guia-otimizacao-windows.md](./guia-otimizacao-windows.md) | Otimização de Windows 10/11: atualização, drivers, energia, remoção de bloatware e inicialização |
| [checklist-manutencao-pc.md](./checklist-manutencao-pc.md) | Manutenção preventiva e corretiva, diagnóstico de problemas comuns e modelo de relatório de atendimento |
| [inventario-hardware.ps1](./inventario-hardware.ps1) | Script PowerShell que coleta CPU, RAM, placa-mãe, GPU, discos e rede e salva relatório no Desktop |
| [inventario-hardware.bat](./inventario-hardware.bat) | Atalho que roda o script de inventário como Administrador |

---

## como usar

Os guias e checklists são `.md`, é só ler aqui no GitHub.

Pro inventário, baixa os dois arquivos (`.ps1` e `.bat`) na mesma pasta e roda o `.bat` como **Administrador**. Ele chama o PowerShell e gera um `.txt` no Desktop.

> Se o PowerShell reclamar de permissão de execução, o `.bat` já passa `-ExecutionPolicy Bypass` só pra aquela execução — não mexe na política da máquina.

---

## requisitos

- Windows 10 ou 11
- PowerShell 5.1 ou superior
- Permissão de Administrador (pros scripts)

---

## outros repositórios

| Repositório | O que é |
|---|---|
| [inventario-ti](https://github.com/davisenise/inventario-ti) | Inventário de máquinas em rede com export pra Excel |
| [limpeza-windows](https://github.com/davisenise/limpeza-windows) | Limpeza automática de temporários, cache, prefetch e lixeira com relatório |

---

## autor

**Davi Senise** — Técnico de Suporte TI
[LinkedIn](https://linkedin.com/in/davisenise) · [GitHub](https://github.com/davisenise)
