# Usar el kit con ChatGPT / Codex (misma voz de ElevenLabs)

El kit son archivos normales (HTML, Python, Node), así que también funciona con **Codex** (el agente de OpenAI
que trabaja en tu ordenador). **ChatGPT en el navegador no sirve** para renderizar: no puede ejecutar Chrome ni ffmpeg
en tu equipo. Usa **Codex CLI** o la **app de Codex**.

## 1. Instalar Codex
`npm install -g @openai/codex` y luego `codex` (inicia sesión con tu cuenta de ChatGPT).

## 2. Poner la skill a mano de Codex
- Si tu versión de Codex admite skills: copia la carpeta `videos-explicativos-claude` en `~/.codex/skills/`.
- Si no: crea tu carpeta de trabajo (p. ej. `Documentos/Videos explicativos`), copia allí la carpeta del kit y crea un
  archivo `AGENTS.md` con este texto:
  ```
  Para hacer vídeos explicativos sigue al pie de la letra videos-explicativos-claude/SKILL.md
  (y sus referencias). <skill> = ./videos-explicativos-claude. Para la voz usa siempre ElevenLabs por API
  (voz Nh2zY9kknu6z4pZy6FhD, modelo eleven_v4) con la clave de ELEVENLABS_API_KEY. Nunca imprimas la clave.
  Para el guion, espera mi OK antes de generar la voz.
  ```

## 3. La voz: la misma que en Claude
Guarda tu clave en la variable `ELEVENLABS_API_KEY` (mira `conectar-elevenlabs.md`, opción B). Codex ejecutará:
```
python videos-explicativos-claude/scripts/voz.py "<proyecto>" --api --voz Nh2zY9kknu6z4pZy6FhD --modelo eleven_v4
```
Opcional, con conector: añade el servidor MCP oficial en `~/.codex/config.toml`:
```
[mcp_servers.elevenlabs]
command = "uvx"
args = ["elevenlabs-mcp"]
env_vars = ["ELEVENLABS_API_KEY"]
```

## 4. Pide el vídeo
> Sigue AGENTS.md: hazme un vídeo explicativo de por qué se nos taponan los oídos en el avión, en segunda persona.

Codex sandbox: la primera vez te pedirá permiso para usar la red (ElevenLabs) y para ejecutar Node/ffmpeg. Acéptalo
solo para esos comandos.
