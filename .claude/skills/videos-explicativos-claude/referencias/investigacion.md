# Vídeos explicativos 100 % animados con Claude + ElevenLabs — informe para una skill

*Investigación web, 3 de noviembre de 2026. Lo que no se ha podido confirmar está marcado como **[sin datos]**.*

---

## 0. Lo que NO he encontrado (para no inventar)

- **Hilos de Reddit r/ClaudeAI concretos:** la búsqueda no devolvió ninguno.
- **Estudios serios sobre explicativos con «sección transversal / cutaway»:** no hay; solo blogs de herramientas con cifras genéricas sobre Shorts.
- **Si `eleven_v4` / `eleven_v3` devuelven alineación en `with-timestamps`:** la documentación no lo dice. Hay que probarlo.
- **Tiempos de render en local medidos (Remotion / HyperFrames):** no hay cifras fiables; solo «varios minutos para 60 s».

---

## 1. Quién lo hace y cómo

| Proyecto / caso | Qué es | Stack | Datos |
|---|---|---|---|
| **anything2explainer** — [github.com/Vincentwei1021/anything2explainer](https://github.com/Vincentwei1021/anything2explainer) | Skill de Claude Code/Codex: tema → explicativo narrado, todo dibujado en código | Remotion 4 + React, Chromium headless, ffmpeg; TTS edge-tts (chino) / kokoro (inglés) | 3,0 k estrellas (~256 al día los primeros 4 días, [Enterprise DNA](https://enterprisedna.co/resources/ai-pulse/ai-pulse-2026-09-12-topic-to-explainer-video-skill-spreads-fast/)). **Horizontal 1280×720, 30 fps, de 2 a 8 min, sin 9:16**. De 1 a 3 h por vídeo con 4–14 subagentes. |
| **claude-faceless-shorts-creator** (Hassan) — [github.com/hassancs91/claude-faceless-shorts-creator](https://github.com/hassancs91/claude-faceless-shorts-creator), [guía](https://learnwithhasan.com/guide/how-to-make-faceless-youtube-shorts-with-claude-code/) | El más parecido al formato que buscamos: shorts verticales dibujados en TSX | Remotion + ElevenLabs (voz, SFX y música) + ffmpeg; probado en Windows 11 | 1080×1920, 30 fps, de 38 a 42 s (algunos de 55 s). Licencia MIT. |
| **Vídeo «civilización occidental»** de @IterIntellectus en X (24-09-2026) | Caso viral de «le pedí a Claude un vídeo» | Sin confirmar (dice «one shot»; no publicó la sesión) | ~15 M de vistas y 2:16 min, según un único blog ([dooza.ai](https://www.dooza.ai/blog/claude-made-video-western-civilization)). Líneas doradas sobre fondo oscuro. Le criticaron un relato sesgado y las omisiones. |
| **MindStudio**: Claude Code + HyperFrames + ElevenLabs — [guía](https://www.mindstudio.ai/blog/ai-video-generation-claude-code-hyperframes-elevenlabs) | Flujo por escenas | `script.json` → HTML por escena → HyperFrames → un MP3 por escena → ffmpeg | Recomienda dejar un 10–15 % de margen en la duración de cada escena. |
| **HyperFrames** (HeyGen) — [github.com/heygen-com/hyperframes](https://github.com/heygen-com/hyperframes) | HTML con animaciones que se pueden buscar fotograma a fotograma → MP4 reproducible | GSAP, CSS, Lottie, Three.js, WAAPI; Node 22+ y ffmpeg; Apache 2.0 | Opcional. |
| **Remotion + Claude Code** — [remotion.dev/docs/ai/claude-code](https://www.remotion.dev/docs/ai/claude-code) | Skill oficial | React → MP4 | — |
| **Manim**: [manim-skill](https://github.com/Yusuke710/manim-skill), [Math-To-Manim](https://github.com/HarleyCoops/Math-To-Manim) | Estilo 3Blue1Brown | Python | Bueno para mates y física; flojo para objetos reales (trenes, tuberías). |
| **Lista de herramientas** — [Claude-Code-Video-Toolkit](https://github.com/wilwaldon/Claude-Code-Video-Toolkit), [digitalsamba/claude-code-video-toolkit](https://github.com/digitalsamba/claude-code-video-toolkit) | Recopilatorios | — | — |

**Conclusión:** casi todos siguen el mismo flujo: **investigación con fuentes → guion → voz con tiempos → storyboard por planos → código por plano → render en Chrome headless → ffmpeg → control de calidad con fotogramas**. Ninguno de los proyectos públicos está pensado para vertical en español.

---

## 2. Qué tienen en común los que funcionan

**Duración.** Hassan apunta a **38–42 s, unas 100 palabras a 2,7 palabras/s** (en inglés). Con 3,3 palabras/s el TTS tuvo que acelerarse ×1,3 y se notaba. El blog de dooza recomienda de 15 a 60 s. Para español, la velocidad hay que medirla con la voz elegida **[sin datos propios para ES]**.

**Gancho (0 a ~3 s).** La regla de Hassan: el primer fotograma ya es el resultado, sin fundido desde negro. Las cifras de blogs sobre la decisión de seguir viendo (sin rigor) hablan de ~1,7 s en TikTok, 2,1 s en Reels y 2,5 s en Shorts ([gofaceless](https://www.gofaceless.ai/en/blog/mastering-first-impressions-two-second-rule), [clipspeed](https://www.clipspeed.ai/blog/hook-first-second-video-retention.html)). Un logo animado de 1,5 s al principio es tiempo perdido.

**Estructura del guion** (Hassan, compatible con la que propones):
1. **HOOK** (0–3,4 s): pregunta o imagen imposible.
2. **SETUP** (3,4–11 s): solo el contexto imprescindible.
3. **QUIZ** opcional (~2,5 s): «¿sabes por qué…?».
4. **REVEAL**: el mecanismo en 2–4 pasos, cada paso pegado a la palabra que lo nombra.
5. **TWIST**: un giro antes del final.
6. **LOOP**: el último fotograma enlaza con el primero. Hassan no pone CTA.

anything2explainer usa la misma lógica a mayor escala: **un párrafo = un plano**, 10 fotogramas de pausa entre frases y 30 al final de cada párrafo, y cada plano se mantiene 1–1,5 s después de que aparece su último elemento.

**Ritmo.** Cifras de blogs: un cambio visual cada 2–4 s en los Shorts que funcionan ([opus.pro](https://opus.pro/blog/ideal-youtube-shorts-length-format-retention)). En un vídeo de 40 s eso da unos 12–20 planos o cambios.

**Estilo visual.** Lo que se repite: fondo oscuro con líneas claras y un solo color de acento (anything2explainer: blanco y morado; el vídeo viral de X: dorado sobre oscuro), diagramas que se dibujan, titulares muy gruesos y animaciones como funciones puras del fotograma. Para «cómo funciona X por dentro», la referencia del sector es el 3D rápido estilo Zack D. Films («Fast. 3D. Educational. Addictive.», según [estudios que venden ese estilo](https://linkedin.com/company/animasterstudio); es una fuente comercial). **No hay datos que comparen isométrico, flat o sección transversal**: la recomendación es de criterio propio. Para tuberías, motores y trenes, la sección transversal con zoom al detalle es la forma natural de enseñar el mecanismo.

**Subtítulos.** Tiempos reales por palabra, centrados en **y≈1500 de 1920**. Zonas seguras: nada importante en los **340 px de abajo ni en los 160 px de la derecha** (Hassan). anything2explainer usa 44 px sobre 720p (≈6 % del alto), blanco con contorno negro y bloques de 48 caracteres como máximo en inglés. Un blog afirma que el 86,6 % de los shorts que funcionan llevan subtítulos animados palabra a palabra (cifra sin verificar).

**Música y SFX.** Hassan genera SFX y música con ElevenLabs (tiene una skill `suggest-sfx`). MindStudio mezcla la música al ~20 % con `amix`. **[Sin datos]** sobre BPM o densidad de SFX.


---

## 3. Requisitos técnicos

### ElevenLabs
- **Endpoint:** `POST /v1/text-to-speech/{voice_id}/with-timestamps` ([docs](https://elevenlabs.io/docs/api-reference/text-to-speech/convert-with-timestamps)). Devuelve `audio_base64`, y además `alignment` y `normalized_alignment`, cada uno con `characters[]`, `character_start_times_seconds[]` y `character_end_times_seconds[]`. **Las palabras se agrupan uniendo caracteres hasta cada espacio.**
- **Parámetros útiles:**
  - `model_id`: por defecto `eleven_multilingual_v2`.
  - `voice_settings`: `stability` 0,5, `similarity_boost` 0,75, `style` 0, `use_speaker_boost` true y `speed` 1 (valores por defecto).
  - `seed`: sirve para repetir resultados.
  - `previous_text` / `next_text`: dan continuidad si se genera frase a frase.
  - `apply_text_normalization`.
  - `output_format`: por defecto `mp3_44100_128`.
  - **`language_code` no funciona con multilingual_v2.**
- **Modelos** ([docs](https://elevenlabs.io/docs/overview/models)):
  - `eleven_v4`: el más nuevo y el más expresivo, 90+ idiomas, 10 000 caracteres.
  - `eleven_v3`: generación anterior, 5 000 caracteres.
  - `eleven_multilingual_v2`: estable en narración y el que mejor normaliza números.
  - `eleven_flash_v2_5`: la mitad de precio, ~100 ms de latencia y **no normaliza números por defecto**.
- **Recomendación:** probar `eleven_v4` contra `multilingual_v2` con la misma voz castellana. Si v4 no devuelve `alignment`, usar v2 o pasar por **Forced Alignment** ([docs](https://elevenlabs.io/docs/capabilities/forced-alignment)), que recibe audio + texto y devuelve tiempos por palabra. Otra opción es Whisper en local, gratis.
- **Ajustes de partida para narración** (criterio propio, no documentado): stability 0,40–0,55, similarity 0,75, style 0–0,2, speed 1,0–1,1. Con más estabilidad la voz suena más plana, y `style` añade latencia.
- **Precio** ([pricing](https://elevenlabs.io/pricing/api)): v4, v3 y v2 cuestan $0,08 por 1 000 caracteres (~1 min); Flash $0,04. Planes: Starter $6/mes (75 k caracteres ≈ 75 min), Creator $22 (275 k), Pro $99 (1,24 M). **Un reel de 40 s ≈ 600–700 caracteres ≈ $0,05.**
- **Voces castellanas:** en la Voice Library hay que filtrar por acento «Spanish (Spain)». Catálogos de terceros citan *Aaron Abad*, *Abel*, *Adolfo Banderas* y *Borja* ([famulor](https://www.famulor.io/voices/elevenlabs/languages/es/accents/peninsular)). **[Sin ranking oficial]**. Otra opción es clonar tu propia voz, desde audio en español: clonar desde inglés deja acento ([javadex](https://www.javadex.es/blog/elevenlabs-ai-clonacion-voz-texto-audio-tutorial-guia-2026)).

### Vídeo y render
- **Formato:** 1080×1920. Hassan y MindStudio trabajan a 30 fps; este kit trabaja a 60 fps con motion blur, así que mejor mantener 60 en el máster.
- **Render:** Chrome headless con `window.seek(t)` o HyperFrames/Remotion, y después ffmpeg. Es lo mismo que ya usan las skills `carrusel-animado` y `hyperframes`.
- **Tiempos de render:** «varios minutos» para 60 s a 30 fps (MindStudio). Si un fotograma tarda más de ~10 s, hay que simplificar la escena. **[Sin benchmark en la 5080/5090]**.
- **Sincronizar cada animación con la palabra:** las palabras se convierten en un `timeline.json` (palabra, inicio, fin). En el storyboard, cada evento visual apunta a una palabra (`"at": "sifón"`), no a un segundo fijo. Así, si la voz cambia, todo se recoloca solo. anything2explainer avisa de que, cuando el guion está locutado, cambiar una palabra mueve todo; por eso conviene anclar a palabras y no a fotogramas fijos.
- **Comprobación de sincronía (Hassan):** antes del render completo, sacar fotogramas sueltos en el instante de cada frase clave y comprobar que lo que se nombra está en pantalla.

---

## 4. Errores típicos y cómo evitarlos

| Error | Cómo evitarlo |
|---|---|
| **Datos inventados o sesgo** (caso del vídeo viral de X) | Como en anything2explainer: cada cifra, año o nombre en pantalla o en la voz necesita una URL en `investigacion.md`. Lo que no se ha verificado no sale. |
| **«Una animación convincente no hace verdadera la explicación»** ([Michael Crist](https://michaelcrist.substack.com/p/make-ai-videos-with-claude)) | Revisión humana del guion antes de animar. Es más fácil corregir un párrafo que un vídeo hecho. |
| **Tono exagerado o cursi de Claude** (mismo autor) | Guion corto y seco, con tu tono. |
| **Voz acelerada o robótica** | Como máximo ~2,7 palabras/s (dato en inglés); nunca subir `speed` por encima de ~1,1. Normalizar los números en el texto si se usa Flash. |
| **Subtítulos desfasados** | Usar la `alignment` de la misma llamada, o forced alignment; nunca repartir el tiempo de forma uniforme. |
| **Animaciones genéricas** (iconos que flotan) | Cada plano tiene que enseñar el mecanismo concreto: agua dentro del sifón, carril roto. Si el plano no explica nada, se quita. |
| **Dibujos poco precisos** | Buscar referencias reales (esquema de fontanería, ficha técnica del tren) y dibujar por proporciones. Revisar con hojas de contacto. |
| **Fotogramas en blanco y fuentes que no cargan** | Esperar ~500 ms al cargar e incrustar las fuentes (MindStudio). |
| **Demasiado texto en pantalla** | Una idea por plano; el texto, solo las palabras clave. |
| **Temas sin «por qué»** | El gancho tiene que plantear un misterio que el mecanismo resuelva. |
| **Noticias de víctimas** (Adamuz: 41 fallecidos identificados, [Diario de León](https://www.diariodeleon.es/nacional/260121/2073063/ultimo-sobre-accidente-adamuz-nuevos-audios-funeral-41-fallecidos-identificados.html)) | Rótulo de «recreación»; decir la hipótesis como hipótesis («la CIAF apunta a una rotura del carril», [Diario de León](https://www.diariodeleon.es/nacional/260429/2083272/ciaf-remarca-hipotesis-rotura-carril-adamuz_amp.html)); nada de culpables ni de bulos (hubo muchas imágenes falsas, [Maldita](https://maldita.es/malditobulo/20260119/imagen-muestra-los-trenes-que-chocaron-en-adamuz-cordoba/)); sin morbo, sin SFX de impacto y sin gente dibujada; citar las fuentes en la leyenda. |

---

## 5. Checklist «para que salga bien»

- [ ] El tema tiene un **por qué / mecanismo** que se pueda enseñar en 2–4 pasos.
- [ ] `investigacion.md` con una URL por dato; si es noticia, fuentes oficiales (CIAF, Adif, Guardia Civil…) y fecha.
- [ ] Guion de 35–50 s, ≤ ~110 palabras: HOOK → SETUP → (QUIZ) → REVEAL 2–4 → TWIST → cierre/loop.
- [ ] Aprobación del guion por la persona antes de gastar créditos.
- [ ] Voz castellana elegida, `with-timestamps`, `seed` fijo, velocidad natural.
- [ ] Tiempos de palabra en `timeline.json`; storyboard con cada evento anclado a una palabra.
- [ ] Primer fotograma = imagen del resultado o del misterio, sin fundido ni logo.
- [ ] Un cambio visual cada 2–4 s; cámara que hace zoom al detalle; sección transversal cuando haya un «por dentro».
- [ ] Paleta: fondo oscuro, 1 acento y 1 color de alerta; curvas de velocidad variadas y motion blur (reglas del kit).
- [ ] Subtítulos palabra a palabra con palabra clave resaltada, en y≈1500 y fuera de 340 px abajo y 160 px a la derecha.
- [ ] SFX ligeros pegados a cada evento; música baja (~20 %) y bajada bajo la voz; máster a −14 LUFS.
- [ ] Comprobación de sincronía: un fotograma por frase clave antes del render completo.
- [ ] Revisión final: transcripción contra guion, búsqueda de negros y un agente que revise la exactitud de cada dato.
- [ ] Rótulo «recreación» y fuentes en la leyenda si es un hecho real; CTA según las normas de la marca.

## 6. Pipeline propuesto (skill `explicativo-animado`)

1. **Entrevista** (tema, si es noticia o no, duración, voz, estilo) y comprobación del equipo (Node, ffmpeg, Chrome y `ELEVENLABS_API_KEY`).
2. **Investigación** con un subagente → `investigacion.md` con una URL por dato y referencias visuales del objeto real.
3. **Guion** → `guion.md` con los beats y su duración estimada. **Punto de control 1: la persona lo aprueba.**
4. **Voz** → `voz.mp3` y `alignment.json` (with-timestamps) → `timeline.json` por palabra. **Punto de control 2: escuchar.**
5. **Storyboard** → `storyboard.json`: planos con `desde_palabra` y `hasta_palabra`, visual, cámara, SFX y texto clave.
6. **Piloto:** construir los primeros ~8 s en HTML/HyperFrames y sacar fotogramas sueltos. **Punto de control 3: aprobar el look.**
7. **Construcción** del resto de planos (en paralelo por grupos con subagentes) y componente de subtítulos que lee `timeline.json`.
8. **Audio:** SFX en cada evento, música con bajada bajo la voz, máster a −14 LUFS.
9. **Render:** previa 1080p y luego máster 1080×1920 a 60 fps (4K solo al aprobar), con ffmpeg.
10. **Control de calidad:** fotograma por frase clave, búsqueda de negros, diferencias entre transcripción y guion, agente de exactitud y zonas seguras. Corregir y volver a renderizar solo los planos afectados.
11. **Entrega:** MP4 y leyenda con fuentes (+ rótulo de recreación si aplica).
