#!/bin/bash
#=================================================================================================================
#Ferramenta: Automated recon Tool (ART)
#Descrição: Enumeração de subdomínios via DNS e validação de Headers HTTP/HTTPS.
#Autor: Almir (almirlab)
#Uso: ./recon.sh <domini_alvo> <arquivo_wordlist>
#=================================================================================================================

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "[-] Erro: Parâmetros ausentes."
    echo "[*] Uso correto: $0 <alvo.com> <wordlist.txt>"
    exit 1
fi

TARGET="$1"
LISTA="$2"
USER_AGENT="Bughunt - Security Research"
OUTPUT_FILE="recon_${TARGET}_$(date +%F).txt"

echo "-----------------------------------------"
echo "[+] Iniciando Reconhecimento em: $TARGET"
echo "[+] Dicionário utilizado: $LISTA"
echo "[+] Relatório será salvo em: $OUTPUT_FILE"
echo "-----------------------------------------"

echo "DOMINIO | IP | STATUS HTTP | SERVIDOR" > "$OUTPUT_FILE"

while read -r sub; do
    [ -z "$sub" ] && continue
	DOMINIO="$sub.$TARGET"

	IP=$(host "$DOMINIO" | grep "has address" | awk '{print $4}' | head -n 1)

	if [ -z "$IP" ]; then
		continue

	else
        HTTP_RESPONSE=$(curl -s -I -A "$USER_AGENT" --connect-timeout 3 "https://$DOMINIO" < /dev/null)
        STATUS=$(echo "$HTTP_RESPONSE" | grep -i "HTTP/" | awk '{print $2}' | head -n 1)
        SERVER=$(echo "$HTTP_RESPONSE" | grep -i "SERVER" | awk '{print $2}' | tr -d '\r' | head -n 1)
        if [ -z "$STATUS" ]; then
            HTTP_RESPONSE=$(curl -s -I -A "$USER_AGENT" --connect-timeout 3 "http://$DOMINIO" < /dev/null)
            STATUS=$(echo "$HTTP_RESPONSE" | grep -i "HTTP/" | awk '{print $2}' | head -n 1)
            SERVER=$(echo "$HTTP_RESPONSE" | grep -i "SERVER" | awk '{print $2}' | tr -d '\r' | head -n 1)
        fi

        [ -z "$SERVER" ] && SERVER="Desconhecido/WAF"
        [ -z "$STATUS" ] && STATUS="Timeout"
        
        echo "[FOUND] $DOMINIO | $IP | HTTP: $STATUS | Servidor: $SERVER"   
        echo "$DOMINIO | $IP | $STATUS | $SERVER" >> "$OUTPUT_FILE"
    fi

done < "$LISTA"

echo "-------------------------------"
echo "[+] Reconhecimento Finalizado. Resultados salvos em: $OUTPUT_FILE"
