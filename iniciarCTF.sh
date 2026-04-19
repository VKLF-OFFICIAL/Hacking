#!/bin/bash

#Este script crea mediante un parametro se le pasa la IP del objetivo, 
#crea un directorio con el nombre de la IP, se mete dentro 
#y lanza un escaneo de nmap y guarda el resultado en un archivo llamado scan_IP.txt

# 1. Comprobamos si nos has dado una IP
if [ -z "$1" ]; then
    echo "[!] Uso: . ./script.sh <IP>"
    return 1
fi

ip="$1"

# 2. Creamos directorio y entramos
mkdir -p "$ip" && cd "$ip" || exit

echo "[+] Iniciando escaneo para: $ip"

# 3. Lanzamos el escaneo (ajustado para que sea más limpio)
nmap -p- --open -Pn -sCV -T4 "$ip" -oN "scan_${ip}.txt"

echo "[+] Escaneo finalizado. Resultados en $ip/scan_${ip}.txt"
