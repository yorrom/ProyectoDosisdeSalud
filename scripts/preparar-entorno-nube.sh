#!/usr/bin/env bash
# Prepara un contenedor de Claude Code en la nube para las skills de vídeo de .claude/skills/.
# Idempotente: se puede ejecutar las veces que haga falta. No toca credenciales.
# Nunca aborta: si un paso falla, lo deja escrito en el informe y sigue (un fallo aquí impediría abrir la sesión).
# Informe: ~/preparacion-videos.log  (Claude lo lee al empezar; ver CLAUDE.md)
set -u
LOG="$HOME/preparacion-videos.log"
: > "$LOG"; : > "$LOG.detalle"
ok()    { echo "OK    $*" | tee -a "$LOG"; }
falla() { echo "FALTA $*" | tee -a "$LOG"; }
paso()  { local n="$1"; shift; if "$@" >> "$LOG.detalle" 2>&1; then ok "$n"; else falla "$n (ver $LOG.detalle)"; fi; }

# 1. Localizar el repositorio (la sesión puede empezar en la carpeta padre o dentro del repo)
REPO=""
for c in "$PWD" "$PWD/ProyectoDosisdeSalud" /home/user/ProyectoDosisdeSalud; do
  if [ -d "$c/.claude/skills" ]; then REPO="$(cd "$c" && pwd)"; break; fi
done
[ -n "$REPO" ] && ok "repositorio en $REPO" || falla "no encuentro .claude/skills (¿rama sin las skills?)"
SK="$REPO/.claude/skills"

# 2. Paquetes de Python ligeros (torch y Whisper van aparte: ~3 GB, solo para editar reels)
paso "pip: numpy scipy pillow opencv yt-dlp" python3 -m pip install -q --disable-pip-version-check \
  numpy scipy pillow opencv-python-headless yt-dlp

# 3. Navegador: el Chromium preinstalado de Playwright. Las skills lo buscan en /usr/bin/chromium o /usr/bin/google-chrome.
CH="$(ls -d /opt/pw-browsers/chromium-*/chrome-linux64/chrome 2>/dev/null | sort -V | tail -1)"
if [ -n "$CH" ]; then
  for l in /usr/bin/chromium /usr/bin/google-chrome; do
    # solo crea o actualiza el enlace si no hay un navegador real instalado en esa ruta
    if [ ! -e "$l" ] || [ -L "$l" ]; then ln -sfn "$CH" "$l"; fi
  done
  ok "Chromium: $CH"
else
  falla "Chromium de Playwright no encontrado en /opt/pw-browsers"
fi

# 4. Playwright preinstalado, enlazado en las carpetas de trabajo (nunca se instala otra versión)
PW=/opt/node-tools/node_modules
if [ -d "$PW/playwright" ]; then
  for d in "Motion Graphics" "Videos explicativos"; do
    mkdir -p "$HOME/Documents/$d/node_modules"
    for p in playwright playwright-core; do ln -sfn "$PW/$p" "$HOME/Documents/$d/node_modules/$p"; done
  done
  ok "Playwright enlazado"
else
  falla "Playwright preinstalado no encontrado en $PW"
fi

if [ -n "$REPO" ]; then
  # 5. editar-reels: dependencias exactas del package-lock (npm ci), con auditoría activada
  if [ -f "$SK/editar-reels-claude/scripts/package-lock.json" ]; then
    paso "npm ci (editar-reels)" npm ci --prefix "$SK/editar-reels-claude/scripts" --no-fund
  fi
  # 6. Modelo de recorte RVM (~100 MB, GitHub). Solo se descarga si falta.
  if [ -f "$SK/editar-reels-claude/models/rvm_resnet50_fp32.torchscript" ]; then ok "modelo RVM ya estaba"
  else paso "modelo RVM" python3 "$SK/editar-reels-claude/scripts/check_env.py" --descargar-modelo; fi
  # 7. Carpeta de trabajo de motion graphics (crea package.json y CLAUDE.md si no existen)
  [ -d "$SK/motion-graphics-claude" ] && paso "carpeta Motion Graphics" python3 "$SK/motion-graphics-claude/scripts/preparar.py" --instalar
fi

# 8. Resumen de herramientas
command -v ffmpeg >/dev/null && ok "ffmpeg" || falla "ffmpeg"
command -v node   >/dev/null && ok "node $(node -v)" || falla "node"
python3 -c "import torch, whisper" 2>/dev/null && ok "torch + whisper" \
  || echo "AVISO torch + whisper no instalados (solo los necesita editar-reels: pip install torch openai-whisper)" | tee -a "$LOG"
exit 0
