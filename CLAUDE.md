# ProyectoDosisdeSalud · notas para Claude

## Skills de vídeo (en `.claude/skills/`)
- `videos-explicativos-claude`: vídeos explicativos animados con voz de ElevenLabs (por el conector MCP).
- `motion-graphics-claude`: motion graphics 2D/3D en MP4.
- `editar-reels-claude`: edición de reels de cabeza parlante (la toma la sube el usuario).

El usuario trabaja **desde el celular** en una sesión en la nube (Linux, sin GPU):
- Navegador: Chromium de Playwright (`/opt/pw-browsers/...`), enlazado en `/usr/bin/chromium` y `/usr/bin/google-chrome`.
  Si no existe el enlace, exporta `CHROME_PATH=$(ls -d /opt/pw-browsers/chromium-*/chrome-linux64/chrome | head -1)`.
- Playwright: usar el preinstalado (`/opt/node-tools/node_modules/playwright`), nunca `playwright install`.
  Las carpetas de trabajo `~/Documents/Motion Graphics` y `~/Documents/Videos explicativos` llevan un enlace a él en `node_modules/`.
- El script de arranque del entorno instala numpy/scipy/pillow/opencv, enlaza Chromium/Playwright, hace `npm install`
  de editar-reels y descarga el modelo RVM. **torch y Whisper no** (pesan ~3 GB): solo para `editar-reels-claude`,
  instalarlos al empezar con `pip install torch openai-whisper` (download.pytorch.org está bloqueado; PyPI funciona).
- Sin GPU: renderizar en 1080p; Whisper y el recorte (torch CPU) son lentos, usar modelos pequeños.
- Entrega: copiar el MP4 final a `videos/` dentro del repo y enviarlo al usuario con SendUserFile para que lo vea en la app.
  Los MP4 grandes no se suben a git salvo que el usuario lo pida.
- Contenido médico: guiones basados en evidencia (revistas indexadas, guías, preferiblemente >2020), citar fuentes y no inventar datos.
