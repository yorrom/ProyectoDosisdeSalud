# Investigación 2: voz humana y estética de explicativos animados (3-11-2026)

Leyenda de fiabilidad: **[OFICIAL]** documentación de ElevenLabs/librería · **[TERCERO]** blog o recopilación · **[PROPIO]** recomendación mía, sin fuente que dé ese número exacto.

---

## A) VOZ

### A1. Voces más usadas

**Inglés (oficial).** El centro de ayuda de ElevenLabs cita como las voces más populares en TikTok/YouTube/redes: Brian, Liam y Adam (hombre) y Jessica, Matilda y Sarah (mujer). [OFICIAL]
https://elevenlabs.io/docs/help-center/product/voices/voice-library/what-voices-are-popular-on-tik-tok-you-tube-and-social-media

IDs públicos de voces predefinidas (sacados de las URL de preview; recopilación de WaveSpeed) [TERCERO, IDs coinciden con los conocidos]:
https://wavespeed.ai/docs/docs-api/elevenlabs/elevenlabs-voice-id

| Voz | voice_id | Nota |
|---|---|---|
| Adam | `pNInz6obpgDQGcFmaJgB` | firme, asertivo (la voz «TikTok» clásica) |
| Brian | `nPczCjzI2devNBz1zQrb` | grave, resonante, narración/anuncios |
| Liam | `TX3LPaxmHKxFdv7VOQHJ` | joven, enérgico, «reels and shorts» |
| Jessica | `cgSgspJ2msm6clMCkdW9` | joven, juguetona |
| Matilda | `XrExE9yKIg1WjnnlVkGX` | alto profesional |
| Sarah | `EXAVITQu4vr4xnSDxMaL` | cálida, segura |
| Chris | `iP95p4xoKVk53GoZ742B` | natural, cercano |
| George | `JBFqnCBsd6RMkjVDRZzb` | cálido, narrador |
| Will | `bIHbv24MWmeRgasZH58o` | conversacional, relajado |

Antoni y Josh: no encontré fuente actual que los liste entre los populares (parecen voces antiguas retiradas o fuera de la lista actual). «The TikTok narrator» como voz concreta de ElevenLabs: no encontrado.

**Español de España (lista con uso real).** SANCANTIA publicó (dato a 3-9-2026) 24 voces peninsulares de la Voice Library con millones de caracteres generados en 12 meses y su ID. Hay 409 voces peninsulares (120 F, 284 M, 5 neutras). [TERCERO, cifras de la propia librería]
https://www.sancantia.com/blog/voces-elevenlabs-espanol-espana

Las relevantes para narración/explicativo:

| Voz | voice_id | Uso | M caracteres/12 m (tal cual en la fuente) |
|---|---|---|---|
| Brittney, Social Media Voice (F) | `kPzsL2i3teMYv0FxEYQ6` | redes | 15.156 |
| Jon, Warm & Grounded Storyteller (M) | `MFZUKuGQUsGJPQjTS4wC` | narración | 6.886 |
| Susi, Effortless and Confident (F) | `v3V1d2rk6528UrLKRuy8` | conversacional | 6.788 |
| Christopher, Gentle and Trustworthy (M) | `G17SuINrv2H9FC6nvetn` | narración | 6.581 |
| Johnny, Mocking, Sarcastic and Rich (M) | `HMCmDsbKeaSZp5LMOYKR` | personaje | 2.381 |
| David Martin, Confident and Balanced (M) | `Nh2zY9kknu6z4pZy6FhD` | narración | 1.913 |
| Carolina, Natural, Neutral and Clear (F) | `UOIqAnmS11Reiei1Ytkc` | conversacional | 1.860 |
| Laura López, Bright, Clear and Dynamic (F) | `yiWEefwu5z3DQCM79clN` | redes | 213 |
| Martin Osborne, Polished and Energetic (M) | `D7dkYvH17OKLgp4SLulf` | anuncios | 539 |

Avisos de esa fuente: probar con ≥300 palabras (muchas voces suenan bien en una frase y planas en un párrafo); en España el tono «anuncio agresivo» suena a teletienda; hay que **añadir la voz a «My Voices»** antes de llamarla por ID por API.

**Español latino.** No encontré ninguna lista fiable de «más usadas» con IDs. La librería tiene «cientos» de voces latinas (https://elevenlabs.io/voice-library/latin). JSON2Video tiene un ranking «most popular» sin metodología (https://json2video.com/ai-voices/languages/spanish/). Recomendación: filtrar en la Voice Library por Spanish + acento + «Narrative/Social media» y ordenar por uso.

### A2. Modelos (estado a noviembre 2026) [OFICIAL]
https://elevenlabs.io/docs/overview/capabilities/text-to-speech

- **Eleven v4** (salió el 28-9-2026, según terceros): el más expresivo, 90+ idiomas, 10 000 caracteres, etiquetas de audio. La doc dice que es «a net upgrade over Eleven v3» y recomienda cambiarse. **No tiene sliders de Style ni Speed y no admite SSML/`<break>`.**
- **Eleven v3**: muy dramático, 70+ idiomas, 5 000 caracteres, etiquetas. Sin Speed, Similarity ni Speaker Boost en la UI. **Sin request stitching** (no sirve previous_text/request_ids).
- **Multilingual v2** (`eleven_multilingual_v2`, modelo por defecto de la API): el más estable en textos largos, 29 idiomas (incluye español de España y México), admite `<break time="1.0s"/>` (≤3 s) y `previous_text/next_text`. No admite `language_code`.
- Flash v2.5: barato y rápido, peor con números.

Cuál usar para un explicativo de 35–50 s en español: **v4 para la toma «con alma»** (etiquetas + puntuación), **multilingual v2** si necesitas pausas exactas con `<break>` o coser por frases con contexto. Si con v4 necesitas pausas exactas, la doc/terceros dicen: ponlas después en edición (cortar el WAV y meter silencio).

### A3. Ajustes [OFICIAL]
https://elevenlabs.io/docs/api-reference/text-to-speech/convert · https://elevenlabs.io/docs/eleven-creative/playground/text-to-speech

- Valores por defecto API: `stability 0.5`, `similarity_boost 0.75`, `style 0`, `use_speaker_boost true`, `speed 1.0` (rango 0.7–1.2).
- Doc: «The most common setting is stability around 50, similarity around 75, and keeping style at 0». Style: «we recommend keeping this setting at 0 at all times» (sube inestabilidad).
- Stability más baja = más rango emocional; más alta = más monótono.
- **v3/v4: stability con 3 modos** — Creative (más emoción, alucina), Natural (equilibrado, fiel a la voz), Robust (estable pero ignora etiquetas, como v2). Para etiquetas: Creative o Natural. Textos de **>250 caracteres** (los cortos dan resultados inconsistentes). https://elevenlabs.io/docs/best-practices/prompting
- `seed` (0–4294967295): determinismo «best effort», no garantizado.
- `apply_text_normalization`: auto/on/off.

Punto de partida [PROPIO, a partir de lo anterior]: multilingual v2 → stability 0.40–0.50, similarity 0.75, style 0–0.15, speaker boost on, speed 1.0–1.05 (los explicativos virales van algo rápidos; >1.1 empieza a sonar artificial). v4 → modo Natural, etiquetas sueltas.

### A4. Trucos de guion
Oficial (prompting / best practices):
- Puntos suspensivos = pausa y peso; MAYÚSCULAS = énfasis; comas = respiración; guiones = pausa corta (menos fiables).
- Etiquetas (v3/v4) en línea donde cambia la entrega: `[curious]`, `[excited]`, `[whispers]`, `[sighs]`, `[exhales]`, `[laughs]`, `[chuckles]`, `[pause]`, `[slowly]`, `[rushed]`, `[awe]`. Las etiquetas son texto libre en v4. Que encajen con la voz: una voz suave con muchos `[shouts]` puede leer la etiqueta en voz alta. https://elevenlabs.io/blog/v3-audiotags
- Demasiados `<break>` en una generación → inestabilidad.
- Escribir números, fechas, unidades y siglas **en letra** (la normalización falla en teléfonos, monedas, horas, URLs, unidades).
- Generar varias tomas y quedarse con la mejor (la salida no es determinista).
- Coser por frases: `previous_text`/`next_text` o `previous_request_ids` (máx. 3, <2 h, mismo modelo) en multilingual v2/v4; **no en v3**. https://elevenlabs.io/docs/eleven-api/guides/how-to/text-to-speech/request-stitching

Errores que suenan a IA (terceros + propio): frases largas y subordinadas de texto escrito; ritmo idéntico frase tras frase; generar cada frase sin contexto (cada una arranca con la misma entonación «de inicio»); speed al máximo; style alto; texto <250 caracteres en v3/v4; palabras en inglés sin adaptar (un desarrollador reporta que el español se lee a veces «a la inglesa» en ll/h/g/qu — https://support.vapi.ai/t/18888573/spanish-language-pronunciation).
Muletillas («vale», «o sea», «fíjate») y respiraciones: no encontré fuente que mida su efecto; recomendación propia: 1–2 por vídeo como máximo, y preferir `[exhales]`/`[sighs]` en v4 a escribirlas.

### A5. Post-procesado
Fuentes flojas (blogs). Orden respaldado: EQ correctivo → compresión suave → reverb/delay sutil al final (Sonarworks). Valores orientativos de un flujo de clonación: HPF ~80 Hz, de-esser 5–8 kHz antes del compresor, compresor ~3:1, +presencia ~3 kHz, limitador.
https://www.sonarworks.com/blog/wp-json/wp/v2/posts/11350 · https://claudeskills.info/ja/skills/curiositech/some_claude_skills/voice-audio-engineer/

Cadena propuesta con ffmpeg [PROPIO, no verificada en fuente]:
`highpass=f=70, equalizer=f=200:t=q:w=1:g=1.5, equalizer=f=3000:t=q:w=1.2:g=1.5, deesser=i=0.4, acompressor=threshold=-18dB:ratio=3:attack=10:release=120, aecho=0.8:0.5:18|32:0.08|0.05` (sala muy corta, casi imperceptible) + room tone a ~−60 dBFS bajo toda la pista (rellena los silencios digitales absolutos, que delatan la IA) + máster −14 LUFS. No aplicar reductor de ruido.

---

## B) ESTÉTICA Y MOVIMIENTO

### B1. Lo que se sabe de los referentes
- **Kurzgesagt**: After Effects a **60 fps**, personajes en archivos de Illustrator separados, *rigging* y expresión `wiggle` para movimiento orgánico; color rico y saturado; look de «vector plano con brillo» (glow). https://www.skillshare.com/en/classes/motion-graphics-with-kurzgesagt-part-1/631970755 · https://artsatmichigan.umich.edu/ink/2019/09/27/simple-bright-beautiful-the-work-of-kurzgesagt — No encontré desglose oficial de su paleta ni de su iluminación.
- **Zack D. Films**: hecho en **Blender**, clips de **20–45 s**, cámara rápida «caótica» y barridos, cámara lenta en el clímax, iluminación cinematográfica, realismo con físicas (ofertas de empleo y freelancers, no fuente oficial). https://zackdfilms.recruitee.com/o/3d-generalist
- Lemmino, TED-Ed, «How it works»: no encontré datos técnicos verificables.

### B2. Ritmo
No hay estudios serios. Lo más repetido en blogs: **un cambio visual cada 2–4 s** (corte, zoom, texto); por debajo de ~1,2 s se percibe como ruido; primeros 3 s retienen ~80 % en Shorts buenos. https://opus.pro/blog/ideal-youtube-shorts-length-format-retention · https://aibrify.com/en/blog/youtube-shorts-retention-curve-playbook

### B3. Física y curvas
- **Muelles (Remotion `spring`)**: por defecto mass 1, damping 10, stiffness 100, overshootClamping false; depende solo de frame y fps → determinista. https://www.remotion.dev/docs/spring
- **Muelle de Apple (damping ratio + response)**: stiffness = (2π/response)², damping = 4π·ζ/response, mass 1. Valores atribuidos a Apple (sin confirmar en la charla): ζ 1.0/resp 0.4 s para mover; ζ 0.8/resp 0.4 rotación; ζ 0.8/resp 0.3 paneles. https://medium.com/@nathangitter/building-fluid-interfaces-ios-swift-9732bb934bf5
- Material 3 easing: la página no se pudo leer; no lo cito.

### B4. Motion blur por acumulación
Técnica estándar (Unity Recorder la documenta): renderizar N subfotogramas dentro del intervalo de obturación y promediarlos. Obturador 180° = 0,5 del intervalo entre fotogramas. https://docs.unity3d.com/Packages/com.unity.recorder@4.0/manual/RecorderAccumulationProperties.html
Aplicado [PROPIO]: a 60 fps, 8–16 subfotogramas repartidos en t ∈ [t0, t0 + 0,5/60], media en float; en three.js con WebGLRenderTarget float + pase de mezcla; en SVG/Chrome, capturar N PNG y promediar con ffmpeg `tmix` (o en JS).

### B5. SVG/Canvas: textura y agua
- `feTurbulence`: baseFrequency bajo (0.001) = manchas grandes; ≥0.5 = grano fino; numOctaves por defecto 1, a partir de 5 ya no se nota. https://tympanus.net/codrops/2019/02/19/svg-filter-effects-creating-texture-with-feturbulence/
- Ondulación de agua/calor: feTurbulence (baseFrequency 0.05, numOctaves 3) → `feDisplacementMap` scale 50 (ejemplo MDN); bajar scale a 4–12 para algo sutil [PROPIO]; animar `seed` o baseFrequency por fotograma.
- Grano de película [PROPIO]: capa de feTurbulence fractalNoise baseFrequency 0.8–1.0, opacidad 4–8 %, modo overlay, seed distinto cada fotograma.

### B6. Herramientas
- **Motion Canvas**: canvas, generadores, código/LaTeX, open source, pensado para animación vectorial informativa.
- **Remotion**: React/DOM, `spring`, `interpolate`, licencia para empresas.
- **Theatre.js**: editor de timeline para JS; no exporta MP4 por sí solo; Studio AGPL.
https://www.remotion.dev/docs/compare/motion-canvas · https://beginnersinai.org/remotion-vs-motion-canvas-vs-manim/

### B7. Principios para que no parezca mecánico [PROPIO, basado en los 12 principios de Disney + lo anterior]
Nada entra sin anticipación (2–4 fotogramas de retroceso de 3–8 %); entradas con muelle ζ≈0.6–0.8 (un rebote), salidas con ease-in acelerado; cada elemento con su curva y retardo escalonado de 40–80 ms; follow-through en partes sueltas (antenas, cables, líquido) 3–6 fotogramas más tarde; cámara siempre moviéndose (deriva lenta 1–2 %/s) con inercia (muelle, no lineal); 3–4 capas de parallax (fondo 0.2×, medio 0.5×, primer plano 1.2×) con desenfoque en el fondo; luz: degradado suave en cada forma + sombra de contacto + borde de luz (rim) del color de la luz principal; viñeta y grano.

---

## Aplicar ya (priorizado)
1. Cambiar a **Eleven v4** (modo Natural) para la toma completa en un solo bloque de >250 caracteres; generar 3 tomas y elegir.
2. Probar en castellano **Jon** `MFZUKuGQUsGJPQjTS4wC`, **Christopher** `G17SuINrv2H9FC6nvetn`, **David Martin** `Nh2zY9kknu6z4pZy6FhD` y **Brittney** `kPzsL2i3teMYv0FxEYQ6` con el mismo guion (≥300 palabras de prueba).
3. Si se usa multilingual v2: stability 0.45, similarity 0.75, style 0, speaker boost on, speed 1.0–1.05; coser frases con `previous_text/next_text`.
4. Reescribir el guion «para el oído»: frases de 6–12 palabras, números en letra, una pregunta retórica, «…» antes del dato clave, una MAYÚSCULA de énfasis por frase importante como mucho.
5. 2–4 etiquetas por vídeo (`[curious]`, `[exhales]`, `[excited]`, `[slowly]`), nunca seguidas.
6. Post: HPF 70 Hz, compresión 3:1, de-esser suave, sala muy corta, room tone −60 dBFS, −14 LUFS; sin reductor.
7. Sustituir easings uniformes por muelles deterministas (ζ 0.6–0.8 para entradas, 1.0 para movimientos de cámara).
8. Escalonar todo: 40–80 ms entre elementos hermanos, curvas distintas por elemento.
9. Anticipación + overshoot + follow-through en cada objeto que se mueve.
10. Motion blur por acumulación (8–16 subfotogramas, obturador 180°) en lugar de blur fijo.
11. Cámara viva: deriva continua + zoom con inercia hacia el detalle; un cambio visual cada 2–4 s; gancho visual en los primeros 3 s.
12. Profundidad: 3–4 capas de parallax y desenfoque del fondo.
13. Iluminación: degradados por forma, sombra de contacto blanda, rim light, viñeta; paleta saturada estilo Kurzgesagt.
14. Textura: grano de película 4–8 % animado y feDisplacementMap sutil para agua/calor.
15. Agua/gas: superficie con ondas sumadas (2–3 senoides de distinta frecuencia) + burbujas/humo con partículas blandas (círculos con blur y opacidad que decae) — técnica propia, sin fuente específica.

## Lo que NO encontré
Ranking verificable de voces en español latino; voice_id de Antoni/Josh actuales; datos técnicos oficiales de Kurzgesagt, Lemmino, TED-Ed o Zack D. Films (curvas, duraciones); estudios serios sobre ritmo de cortes; valores oficiales de EQ para voz IA.
