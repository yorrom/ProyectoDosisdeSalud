# videos-explicativos-claude · instalación

Skill gratuita de **Viegas Estudio** para hacer vídeos explicativos verticales 100 % animados (Reels, TikTok, Shorts)
con Claude Code y la voz de **ElevenLabs**. Sale un MP4 1080×1920 a 60 fps, con subtítulos palabra a palabra y −14 LUFS.

## 1. Instalar la skill
**Opción A: copiar la carpeta**
1. Descomprime el `.zip`. Tendrás la carpeta `videos-explicativos-claude` (dentro está `SKILL.md`).
2. Cópiala en tu carpeta de skills de Claude Code:
   - **Windows:** `C:\Users\TU_USUARIO\.claude\skills\videos-explicativos-claude`
     (escribe `%USERPROFILE%\.claude\skills` en la barra del Explorador; si no existe `skills`, créala).
   - **Mac:** `~/.claude/skills/videos-explicativos-claude` (Finder → Cmd+Mayús+G → `~/.claude/skills`).
3. Comprueba que queda así: `.claude/skills/videos-explicativos-claude/SKILL.md` (sin carpeta repetida dentro).

**Opción B: que lo haga Claude Code.** Abre Claude Code donde descargaste el `.zip` y escribe:
> Descomprime videos-explicativos-claude.zip y copia la carpeta videos-explicativos-claude en mi carpeta ~/.claude/skills

## 2. Preparar el equipo (una vez)
> Usa la skill videos-explicativos-claude y comprueba si mi equipo tiene todo lo necesario.

Claude ejecuta `scripts/preparar.py`, te dice qué falta (Node.js, ffmpeg, Chrome/Playwright, Python con numpy/scipy,
Whisper opcional) y **te pide permiso** antes de instalar nada.

## 3. Conectar la voz (ElevenLabs)
Lee `guias/conectar-elevenlabs.md`. Dos caminos: el **conector** (sin tocar claves) o la **API key** en una variable de
entorno. Nunca pegues la clave en el chat. Voz recomendada: **David Martin** (`Nh2zY9kknu6z4pZy6FhD`), modelo `eleven_v4`.
Con el plan gratuito de ElevenLabs salen unos 15 vídeos al mes (una toma por vídeo).

¿Usas ChatGPT / Codex en vez de Claude? Lee `guias/chatgpt-codex.md`.

## 4. Tu primer vídeo
> Usa videos-explicativos-claude: hazme un vídeo explicativo de por qué se empañan los cristales del coche en invierno,
> con la voz de ElevenLabs David Martin, en segunda persona.

Claude te pregunta 4 cosas, investiga con fuentes, te enseña el guion y 3 ganchos (**espera tu OK antes de gastar
créditos**), genera la voz, anima cada idea en su palabra, te enseña una hoja de fotogramas y renderiza el MP4.

En `ejemplos/` tienes 7 vídeos terminados (guion, escena, fuentes y MP4) para ver el nivel.

## Licencias
Ver `LICENCIAS.md`. Si usas ElevenLabs gratis, su licencia es **no comercial y con atribución**: para monetizar o
trabajar para clientes necesitas un plan de pago (Starter o superior).

¿Dudas? Grupo de WhatsApp: https://grupo.viegasestudio.com/whatsapp · Curso gratis en Skool: https://www.skool.com/viegas-academy-free-2786
