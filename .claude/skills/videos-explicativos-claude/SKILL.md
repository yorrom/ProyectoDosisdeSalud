---
name: videos-explicativos-claude
description: "Hace vídeos explicativos verticales 100 % animados en código por Claude (Reels, TikTok, Shorts): un tema concreto explicado de forma muy visual (cómo funciona algo por dentro, por qué pasa algo, cómo ocurrió un suceso), con dibujos que se trazan, cortes en sección, cámara que hace zoom al detalle, partículas (agua, gas, calor), voz en off de ElevenLabs (por conector MCP, API o la voz que tengas) y subtítulos palabra a palabra sincronizados con la voz. Investiga con fuentes, escribe el guion (35–50 s), genera la voz con sus tiempos, anima cada idea en la palabra exacta, mezcla música y efectos a −14 LUFS y entrega el MP4 1080×1920 a 60 fps. Úsala cuando pidan «un vídeo explicativo», «explícame en vídeo cómo funciona X», «un vídeo animado tipo el del tren / el del sifón», «faceless explainer», «vídeo con voz de ElevenLabs y animaciones», aunque no nombren la skill. Kit de Viegas Estudio."
---

# videos-explicativos-claude · vídeos explicativos animados con Claude

Cada vídeo es **una página HTML** con un mundo dibujado en SVG (1080×1920) que se pinta para cualquier instante
(`window.seek(t)`). Chrome sin ventana lo fotografía y ffmpeg lo convierte en MP4. **Todo va anclado a las palabras de
la voz** (`X.en('sifón')`), nunca a segundos fijos: si cambias la voz, las animaciones se vuelven a sincronizar solas.

`<skill>` = la carpeta de este SKILL.md. En Windows usa `python`; en Mac, `python3`. Habla claro y sin jerga: quien te
lo pide puede no saber programar. Antes de cada paso, di en una frase qué vas a hacer.

Lee una vez `referencias/requisitos.md` (lo que hace que estos vídeos funcionen, con la investigación en
`referencias/investigacion.md`) y mira el ejemplo terminado `ejemplos/malos-olores-lavabo/` (guion, escena y vídeo).

## 0 · Comprobar el equipo (la primera vez)
`python <skill>/scripts/preparar.py` revisa Node.js, ffmpeg, Chrome, Playwright y Python (numpy/scipy para la música,
Whisper opcional). Si falta algo, **explica qué es y pide permiso** antes de instalar (`--instalar`). Los proyectos van en
`Documentos/Videos explicativos/<AAAA-MM-DD · tema>/` (ahí se instala Playwright una vez).

## 1 · Entrevista corta (un mensaje, máx. 4 preguntas, con tu recomendación)
1. **Tema** y el «por qué» que quieres que se entienda. Si es un suceso real, ¿qué fuente oficial hay?
2. **Voz:** ElevenLabs por **conector MCP** (recomendado) · API de ElevenLabs con tu clave · tu propia voz grabada ·
   voz de prueba del sistema (solo para montar). ¿Qué voz? (en español de España o latino).
3. **Estilo:** oscuro con un acento (por defecto, `motor/explica.css`) o los colores de tu marca.
4. **Cierre:** sin CTA (lo que mejor retiene) · «Sígueme para más» · «Comenta PALABRA».

## 2 · Investigar (sin datos inventados)
Busca en la web y apunta en `fuentes.md` **una URL por cada dato** (cifra, nombre, causa). Lo que no tenga fuente no sale.
Sucesos con víctimas: lee la sección «Temas sensibles» de `referencias/requisitos.md` (rótulo «recreación», hipótesis
como hipótesis, sin culpables, sin morbo y sin retratos de personas reales: solo figuras genéricas).

## 3 · Guion (parada: espera el OK)
Escribe `voz.txt` (exactamente lo que se dice) con la estructura de `referencias/requisitos.md`:
gancho en la primera frase (el misterio o el resultado) → contexto → el mecanismo en 2–4 pasos → el giro → la solución
o el cierre que vuelve al principio. **90–120 palabras (35–50 s)**, frases cortas, números en cifra si la voz los lee bien.
Lee antes `referencias/ganchos.md` y **propón 3 ganchos** (fórmulas distintas, máx. 8 palabras) para que elija.
Enséñalo junto al **plan de planos**: una línea por idea con la palabra ancla y lo que se ve
(«sifón → se dibuja la U y se rellena de agua»). **Un cambio visual cada 2–4 s.** Espera el OK.

## 4 · Voz con tiempos palabra a palabra
Antes, rescribe `voz.txt` «para el oído» (sección Voz de `referencias/requisitos.md`) y elige voz: la clonada de la persona
(lo más humano) o una de la lista de voces populares. Genera el texto entero de una vez y, si puedes, 2–3 tomas.
- **Higgsfield (conector):** `generate_audio` con `model: text2speech_v2`, `variant: elevenlabs`, y su voz clonada
  (`list_voices` → `voice_type: element`) o una preset. Cuesta ≈ 3 créditos por vídeo: dilo antes de generar. Descarga el MP3 del
  resultado y usa `--alinear voz/tomas/<toma>.mp3` (no trae tiempos).
- **Conector MCP de ElevenLabs:** usa su herramienta de texto a voz con tiempos (with-timestamps / alignment) con el texto de
  `voz.txt`, modelo `eleven_multilingual_v2` (o `eleven_v3`/`v4` si devuelve alignment), estabilidad 0,45, parecido 0,8,
  estilo 0,25. Guarda la respuesta (audio en base64 + alignment) en `voz/eleven.json` y ejecuta
  `python <skill>/scripts/voz.py <proyecto> --elevenlabs voz/eleven.json`.
  Si la herramienta solo devuelve el audio (sin tiempos): guárdalo y usa `--alinear voz/voz.mp3` (Whisper).
- **API:** `python <skill>/scripts/voz.py <proyecto> --api --voz <voice_id>` (clave en `ELEVENLABS_API_KEY` o en
  `~/.viegas/elevenlabs.env`; nunca la imprimas ni la escribas en el proyecto).
- **Su propia voz:** `--alinear <audio>`. **Prueba:** `--prueba --permitir-prueba` (voz del sistema + Whisper; solo para ensayar el ritmo, NUNCA en un vídeo que se publica: para publicar, siempre ElevenLabs).
Salen `voz/voz.wav`, `voz/timeline.json` y `voz/timeline.js`. El script dice el ritmo (ideal 2,4–3,0 palabras/s).
**Parada: que escuche la voz** antes de animar.

## 5 · La escena (`escena.html`)
Lee entero `referencias/calidad-visual.md` (el nivel de dibujo, los recursos llamativos y las reglas de retención).
Copia `plantillas/escena.html` al proyecto y dibuja el tema en el SVG del mundo (`#cam`), con materiales (`motor/materiales.js`:
`X.materiales(svg)` y `filter="url(#m-metal)"`…), lupa, ondas, flechas, contadores y destellos. Reglas:
- **Dibuja el objeto real**, no iconos genéricos: el sifón con su U y su agua, el carril, el motor por dentro. Si hace falta,
  busca un esquema técnico real y cópialo en limpio. Sección transversal + zoom al detalle es lo que más explica.
- **Movimiento natural y estética:** lee «Movimiento natural» y «Estética» en `referencias/requisitos.md` y mira
  `ejemplos/malos-olores-lavabo/escena.html` (puertas que se abren, agua con olas, humo, azulejos con parallax, grano).
  Usa `X.defs(svg)` (degradados y sombras), `X.grano(lienzo)`, `X.humo`, `X.ola` y `X.profundidad`; curvas `natural`, `blando`, `firme`.
- **Cámara siempre viva** (`X.camara`, con inercia y pulso de mano; claves con `r` para girar un poco y `rx`/`ry` para
  inclinarla en 3D): plano general → zoom al detalle de cada paso → vuelve a abrir en el giro.
- **Profundidad:** fondo que se desenfoca con el zoom (`X.desenfoqueFondo`) y objetos de primer plano que pasan por delante
  desenfocados (`X.primerPlano`). Sección «3D y profundidad de campo» de `referencias/requisitos.md`.
- Cada idea entra **en su palabra**: `X.en('palabra')` / `X.fin('frase')`, con `X.debe()` para las obligatorias.
- Entradas con `X.anima` (curva rápida con frenada suave y desenfoque), trazos con `X.traza`, flujos con `X.particulas`
  (agua, gas, calor, electricidad), etiquetas cortas (1–3 palabras) en mayúsculas o en el color de acento.
- **Un color de acento** y colores con significado (agua azul, gas verde, peligro rojo, bien verde).
- Primer fotograma = la imagen más fuerte + titular grande + movimiento desde 0 s (`referencias/ganchos.md`).
- **Detalle:** al menos 3 elementos por plano (qué, dónde, quién) y un dibujo para cada cosa importante que dice el guion;
  figuras humanas genéricas permitidas (sin cara ni parecido con nadie real).
- Subtítulos con `X.subtitulos` (palabra a palabra, palabra clave en acento, y = 1470: fuera de la interfaz de Reels).
- Sonidos con `X.sonido(t, 'whoosh'|'pop'|'click'|'swoosh'|'notificacion'|'teclado'|'dinero'|'feedback')` en cada cambio.
API completa en la cabecera de `motor/explica.js`. Puedes abrir `escena.html?ver` en el navegador para verla con la voz.

## 6 · Revisar antes de renderizar
1. `node <skill>/scripts/render.mjs <proyecto> comprobar` → 0 anclas perdidas (si falta una, para con código 3).
2. `node <skill>/scripts/render.mjs <proyecto> hoja 18` → **mira `resultados/hoja.jpg`**: en cada momento se ve lo que la
   voz está diciendo, nada tapado por los subtítulos, ningún elemento fuera de sitio, el texto se lee en un móvil.
3. `node <skill>/scripts/render.mjs <proyecto> gancho` → `resultados/gancho.jpg` y pasa la lista de `referencias/ganchos.md`.
4. Corrige y repite hasta que esté bien. Enséñale la hoja y el gancho.

## 7 · Render y entrega
- Previa: `node <skill>/scripts/render.mjs <proyecto> video` (540×960 a 30 fps, rápido).
- Final: `node <skill>/scripts/render.mjs <proyecto> video --calidad final --mb 3` → `resultados/video-final.mp4` (1080×1920 a 60 fps
  con desenfoque de movimiento real de 3 subfotogramas,
  música de la biblioteca propia bajo la voz, efectos, −14 LUFS). Cuenta los fotogramas y se para si falta alguno.
- Música en `estilo.json` del proyecto: `{ "musica": "ambient-2" | "lofi-1" | "cinematic-2" | "sin" | "ruta.mp3", "musica_db": -22 }`
  (lista de estilos en `musica/catalogo.json`).
- Entrega: el MP4, `voz.txt`, `fuentes.md` y una leyenda corta (gancho + 2 frases + fuentes si es un suceso real).

## Si algo falla
- «No encuentro «X» en la voz»: la palabra ancla no está tal cual en `voz.txt` o Whisper la escribió distinta → usa otra
  palabra o una frase más corta.
- Fotograma en blanco o fuente distinta: las fuentes se cargan desde `motor/fuentes/` (no las del sistema).
- Voz robótica: no subas la velocidad de ElevenLabs por encima de 1,1; mejor recorta el guion.

## Errores que ya nos hemos encontrado (y su solución)
| Síntoma | Causa | Solución |
|---|---|---|
| Whisper se cae con `metadata_errors` / error de PyAV al leer el audio | PyAV (de faster-whisper) no lee bien algunos MP3 con metadatos | Convierte antes a WAV: `ffmpeg -i voz.mp3 -ar 16000 -ac 1 voz.wav` y alinea el WAV. |
| `faster-whisper` falla con `cublas64_12.dll` / cuBLAS no encontrado | Falta la librería CUDA que pide faster-whisper en la GPU | Usa **openai-whisper** (`pip install openai-whisper`), que usa la GPU por torch; `voz.py` lo prueba primero. Si no, faster-whisper en CPU (`int8`). |
| Subtítulos con palabras mal escritas («su maleca de facción») | Whisper oye mal | `voz.py --alinear` coloca las palabras **del guion** (`voz.txt`) sobre los tiempos de Whisper. El texto manda siempre el guion. |
| «No encuentro «X» en la voz» / `render.mjs comprobar` sale con código 3 | La palabra ancla no está tal cual en `voz.txt` | Usa una palabra que esté escrita igual (con sus tildes) o una frase más corta. 0 anclas perdidas antes de renderizar. |
| El vídeo dura más que la voz o queda negro al final | Vídeo y audio de distinta longitud | La unión final usa `-shortest`; la escena debe durar lo que dura la voz. |
| Volumen distinto en cada vídeo (−17, −12 LUFS…) | Un `loudnorm` de una pasada se confunde con los golpes de los efectos | `mezcla.py` hace **loudnorm en dos pasadas** (mide y luego corrige) a **−14 LUFS**, pico −1 dBTP. |
| La voz suena a robot | Velocidad > 1,1, frases largas o texto corto (< 250 caracteres) | Velocidad 1,0–1,05, frases de 6–12 palabras, genera el guion entero de una vez y saca 2–3 tomas. |
| Usar la voz del sistema (Windows/Mac) para publicar | Sale robótica y mata la retención | **Prohibido para entregas.** Solo para ensayar el ritmo (`--prueba --permitir-prueba`). Para publicar: ElevenLabs. |
| El modelo eleven_v4 no devuelve tiempos (alignment) | Depende del endpoint / conector | Guarda el MP3 y usa `voz.py --alinear voz/voz.mp3` (Whisper) — mismo resultado. |
| Fotograma en blanco o fuente rara | Fuente del sistema | Las fuentes se cargan de `motor/fuentes/`; no cambies la ruta. |
| Te quedas sin créditos a mitad | Muchas tomas | Aprueba el guion **antes** de generar la voz. Un vídeo ≈ 600–700 caracteres = 600–700 créditos por toma. |

## Seguridad de la clave
Nunca pegues tu clave de ElevenLabs en el chat ni en un archivo del proyecto. Va en la variable de entorno
`ELEVENLABS_API_KEY` o en `~/.viegas/elevenlabs.env` (una línea `ELEVENLABS_API_KEY=...`). Claude nunca la imprime.
