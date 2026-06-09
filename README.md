# ART - Aoutomated Recon Tool

O*ART (Automated Recon Tool) é um script em Bash desenvolvido para automatizar a estapa inicial de reconhecimento externo em programas de Bug Bounty e testes de intrusão. A ferramenta combina a enumeração via DNS com a validação ativa de portas e extração de cabeçalhos HTTP/HTTPS, gerando relatórios estruturados para análise posterior.

-------

# Funcionalidades

Filtro Passivo de Arivos: Validação rápida de conectividade via DNS antes de interagir com o alvo.
Checagem Dupla de Protocolos: Validação adaptativa que testa conexões em HTTPS (porta 443) e faz fallback automático para HTTP comum (porta 80) caso o servidor não responda de forma criptografada.
Fingerprit de Web Server: Extração automática de banner do servidor (Cloudflare, Apache, Nginx, WAFs) direto dos headers de resposta
Geração de Relatório Automatizado: Output limpo e estruturado em formato .txt contendo a matriz completa de alvos para triagem.

-------

## Aviso de Isenção de Responsabilidade

Este projeto foi desenvolvido estritamente para **fins educacionais e de estudo** como parte do meu aprendizado em cibersegurança e automação em Bash.

O uso desta ferramente para testar ativos sem a autorização prévia e expressa do proprietário é ilegal e viola os termos de serviço da maioria das plataformas. O desenvolvedor não se responsabiliza por quaisquer danos, uso indevido ou consequências causadas pela utilização deste script. Utilize com responsabilidade e estritamente dentro do escopo de programas de Bug Bounty autorizados ou ambientes de laboratório controlados.

-------

# Como Utilizar

# Pré requisitos

Certifique-se de que possui os utilitários de rede padrão instalados no seu ambiente (como Ubuntu):

sudo apt install dnsutils curl -y

-------

# Execução
Dê permissão de execução ao script e passe o domínio alvo acompanhado de sua wordlist de subdomínios:

chmod +x recon.sh
./recon.sh <dominio_alvo> <arquivo_wordlist>

Exemplo:
./recon.sh alvo.com.br wordlist.txt

-------

# Estrutura do Relatório
O script cria autometicamente um arquivo de texto nomeado dinamicamente com o alvo e a data atual
(ex: recon_alvo_2026-06-01.txt), organizando os dados no seguinte formato:

DOMINIO | IP | STATUS HTTP | SERVIDOR
[www.alvo.com](htttps://www.alvo.com).br | 104.28.5.210 | 200 | cloudflare
api.alvo.om.br | 3.174.50.42 | Timeout | Desconhecido/WAF

-------

# Arquitetura de Lógica do Script
° Validação de Parâmetros: Garante que o operador forneceu o alvo e a wordlist antes de alocar recursos.
° Resolução de DNS Executa uma query via comando host. Se o subdomínio não resolver para um IP válido, o script o ignora e avança, poupando requisições desnecessárias na rede.
° Análise de Aplicação: Dispara requisições curl otimizadas com timeouts curtos para evitar travamentos em servidores lentos ou firewalls agressivos.
° Sanitização de Strings: Processamento de dados via grep, awk e tr para limpar quebras de linha no padrão Windows (\r) e formatar a saída de forma legível.

-------

# Próximos passos (Roadmap de Evolução)
As seguintes melhorias e refatorações estão planejadas para as próximas versões:
°[ ] Ajuste na Resolução de CNAMEs: Refatorar a captura do comando host para tratar subdomínios que respondem com aliases (CNAME) antes de apontarem para o IP final.
°[ ] Mapeamento Preciso de Cabeçalhos: Otimizar as expressões do grep para evitar colisões de strings na captura do banner do Web Server.
°[ ] Implementação de Multi-threading / Paralelismo: Adaptar o loop while para processar múltiplos subdomínios simultaneamente (usando xargs ou Backgrounds jobs do Bash), acelerando o scan de wordlists massivas.
°[ ] Integração com Ferramentas de OSINT: Adicionar checagem passiva via APIs públicas (como crt.sh ou VirusTotal).

-------

# Autor
Almir (almirlab) - Idealização e Desenvolvimento inicial - [Meu GitHub](https://github.com/AlmirBrandao).
