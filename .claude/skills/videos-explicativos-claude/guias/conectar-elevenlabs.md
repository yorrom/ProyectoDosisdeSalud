# Conectar ElevenLabs con Claude

Regla de oro: **tu clave (API key) nunca se pega en el chat** ni se guarda dentro de la carpeta del proyecto.
Quien tenga tu clave gasta tus créditos.

## Paso 0 · Cuenta y voz
1. Crea tu cuenta en ElevenLabs (el plan gratuito vale para empezar: 10 000 créditos al mes).
2. Ve a **Voices → Voice Library**, busca **David Martin** (español de España, narración) y pulsa **Add to My Voices**.
   ID de la voz: `Nh2zY9kknu6z4pZy6FhD`. Sin este paso la API y el conector no la encuentran.
3. Crea tu clave: **Developers → API Keys → Create API key**. Dale permiso de *Text to Speech* (y *Voices: read*).
   Si quieres, ponle un límite de créditos. Cópiala: solo se ve una vez.

## Opción A · Conector (MCP) — la más cómoda
### En claude.ai / app de escritorio de Claude
1. **Configuración → Conectores → Buscar conectores**, escribe «ElevenLabs» y pulsa **Conectar**.
2. Inicia sesión con tu cuenta de ElevenLabs y acepta. No tienes que copiar ninguna clave.
3. En un chat nuevo, comprueba en el botón de herramientas que el conector está activo.
> Si en tu cuenta no aparece en el directorio, usa la opción B o el servidor MCP local de abajo.

### En Claude Code (servidor MCP oficial, en tu ordenador)
Necesitas `uv` (Claude te lo puede instalar con permiso). Primero guarda la clave como variable de entorno
(ver opción B, paso 1) y luego, en una terminal:
```
claude mcp add elevenlabs -s user -- uvx elevenlabs-mcp
```
Cierra y abre Claude Code y escribe `/mcp`: debe salir `elevenlabs · connected`.
El servidor lee `ELEVENLABS_API_KEY` de tu entorno, así que la clave no queda escrita en la configuración.

## Opción B · API key en variable de entorno (sin conector)
1. Guarda la clave **una vez**:
   - **Windows (PowerShell):** `setx ELEVENLABS_API_KEY "pega-aqui-tu-clave"` → cierra y abre la terminal.
   - **Mac/Linux:** añade `export ELEVENLABS_API_KEY="pega-aqui-tu-clave"` al final de `~/.zshrc` y abre otra terminal.
   - O crea el archivo `~/.viegas/elevenlabs.env` con una línea `ELEVENLABS_API_KEY=tu-clave`.
   Hazlo tú en la terminal, **no** se lo dictes a Claude.
2. Pide a Claude: «Usa videos-explicativos-claude con la API de ElevenLabs, voz David Martin, modelo eleven_v4».
   La skill ejecuta `python scripts/voz.py <proyecto> --api --voz Nh2zY9kknu6z4pZy6FhD --modelo eleven_v4`.
   Si ese modelo no devuelve tiempos por palabra, la skill alinea con Whisper sola.

## ¿Cuánto gasto?
1 carácter ≈ 1 crédito. Un vídeo de 40 s ≈ 600–700 caracteres. Gratis: ~15 vídeos/mes con una toma (≈ 5 si sacas 3 tomas).
Starter: ~45 vídeos/mes (≈ 15 con 3 tomas). **Aprueba el guion antes de generar la voz.**

## Licencia
Plan gratuito: uso **no comercial y con atribución** a ElevenLabs. Para monetizar, hacer anuncios o trabajar para
clientes necesitas un plan de pago (Starter incluye licencia comercial).

## Problemas
- `401 / invalid api key`: la variable no está cargada → abre una terminal nueva o revisa el nombre exacto.
- `voice not found`: no añadiste la voz a *My Voices*.
- `quota_exceeded`: sin créditos este mes.
