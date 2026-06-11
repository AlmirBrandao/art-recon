# ART - Asset Recon Tool

Ferramenta desenvolvida em Bash para automatizar etapas iniciais de identificação e validação de ativos expostos.

---

## Visão Geral

O ART (Asset Recon Tool) foi desenvolvido como projeto de estudo para praticar automação em Linux, manipulação de dados em Bash e conceitos fundamentais de redes de computadores.

A ferramenta realiza a enumeração de subdomínios a partir de uma wordlist, valida a resolução de DNS dos ativos encontrados, verifica a disponibilidade de serviços HTTP/HTTPS e gera relatórios estruturados para análise posterior.

---

## Objetivos do Projeto

   - Praticar automação utilizando Bash Script.
   - Aplicar conceitos de DNS e protocolos HTTP/HTTPS.
   - Exercitar manipulação de dados em ambiente Linux.
   - Desenvolver habilidades de coleta e organização de informações.
   - Produzir relatórios estruturados a partir de dados obtidos automaticamente.

---

## Funcionalidades

### Enumeração de Subdomínios

Processa uma wordlist fornecida pelo usuário e identifica subdomínios válidos através de consultas DNS.

### Validação DNS

Ignora automaticamente entradas que não possuem resolução válida.

### Verificação de Serviços Web

Realiza tentativa inicial via HTTPS e utiliza HTTP como alternativa quando necessário.

### Coleta de Cabeçalhos HTTP

Obtém informações básicas disponibilizadas pelo servidor através dos cabeçalhos de resposta.

### Geração de Relatório

Produz um arquivo contendo:

   - Domínio
   - Endereço IP
   - Status HTTP
   - Identificador do servidor

---

## Tecnologia Utilizadas

   - Bash
   - Linux
   - DNS (host)
   - HTTP/HTTPS (curl)
   - grep
   - awk
   - tr

---

## Estrutura do Projeto

```text
art-recon/
├──README.md
├──recon.sh
├──examples/
│  └──sample_report.txt
└──docs/
```
---

## Pré-requisitos

Instale os pacotes necessários:
```bash
sudo apt install dnsutils curl -y
```
---

## Execução

Conceda permissões de execução ao script:
```bash
chmod +x recon.sh
```
execute informando o domínio alvo e a wordlist:
```bash
./recon.sh exemplo.com.br wordlist.txt
```
Exemplo:
```bash
./recon.sh exemplo.com.br subdominios.txt
```
---

## Exemplo de Saída
```bash
DOMINIO | IP | STATUS HTTP | SERVIDOR

www.exemplo.com.br | 104.21.15.30 | 200 | cloudflare
api.exemplo.com.br | 172.67.50.10 | 403 | nginx
```
---

## Estrutura do Relatório

O relatório é salvo automaticamente utilizando o formato:
```bash
recon_<dominio>_<data>.txt
```
Exemplo:
```bash
recon_exemplo.com.br_2026-06-10.txt
```
---

## Fluxo de Funcionamento

```text
wordlist
  |
  v
DNS Relosution
  |
  v
HTTPS Validation
  |
  +----> HTTP Fallback
  |
  v
Header Collection
  |
  v
Report Generation
```
---

## Limitações Conhecidas

Atualmente a ferramenta:

   - Não trata adequadamente registros CNAME encadeados.
   - Processa os subdomínios de forma sequencial.
   - Realiza apenas coleta básica de cabeçalhos HTTP.
   - Não utiliza fontes externas de enumeração.

---

## Roadmap

### Melhorias Planejadas

   - [ ] Tratamento completo de registros CNAME.
   - [ ] Processamento paralelo para grandes wordlists.
   - [ ] Melhorias na identificação de servidores web.
   - [ ] Integração com fontes públicas de OSINT.
   - [ ] Exportação dos resultados para CSV
   - [ ] Implementação de logs de execução.

---

## Aviso

Este projeto foi desenvolvido exclusivamente para fins educacionais.

A utilização da ferramenta deve ocorrer apenas em ativos próprios, ambientes de laboratórios ou escopos explicitamente autorizados.

O uso indevido pode violar legislações, contratos e políticas de uso aceitável.

---

## Autor

Almir Brandão

[GitHub](https://github.com/AlmirBrandao)
