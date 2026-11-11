#!/usr/bin/env bash
# Une la voz en off (6 MP3 de ElevenLabs) con el video animado.
# Descarga las tomas desde el flow "R3 Ejercicio · Moverte después de comer" en ElevenLabs
# y guárdalas en esta carpeta como s1.mp3 … s6.mp3 (una por escena). Luego: bash unir_voz.sh
set -euo pipefail
cd "$(dirname "$0")"
# Inicio de cada toma en el video (ms), sincronizado con la animación
D=(150 3850 8550 16700 25200 32300)
IN=(); FC=""
for i in 1 2 3 4 5 6; do IN+=(-i "s$i.mp3"); FC+="[$i:a]adelay=${D[$((i-1))]}|${D[$((i-1))]},aresample=48000[a$i];"; done
FC+="[a1][a2][a3][a4][a5][a6]amix=inputs=6:normalize=0,apad,atrim=0:39.5,loudnorm=I=-14:TP=-1.5:LRA=11[a]"
ffmpeg -y -i r3_video_sin_voz.mp4 "${IN[@]}" -filter_complex "$FC" \
  -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k -shortest r3_moverte_despues_de_comer.mp4
echo "Listo: r3_moverte_despues_de_comer.mp4"
