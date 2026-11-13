# Requisitos para que un vídeo explicativo funcione

Resumen práctico de la investigación (`investigacion.md`, 03-11-2026, con fuentes) y de los vídeos que ya han funcionado.

## El tema
- Tiene un **«por qué» que se puede enseñar** en 2–4 pasos de un mecanismo real: un objeto por dentro (sifón, motor,
  oído), una causa física (presión, calor, fricción) o una secuencia de hechos (un accidente, un récord).
- Se puede **dibujar en sección** (corte transversal) o como esquema: si no se puede enseñar, no sirve en este formato.
- Despierta curiosidad cotidiana («¿por qué huele a alcantarilla?») o es actualidad que todos comentan.

## El guion (`voz.txt`)
- **35–50 s · 90–120 palabras.** Ritmo de 2,4–3,0 palabras por segundo con la voz elegida (el script lo mide).
- Estructura:
  1. **Gancho (0–3 s):** la pregunta o el resultado. El primer fotograma ya lo enseña, sin fundido ni logo.
  2. **Contexto (hasta los 10 s):** dónde está el problema («no es el lavabo, es lo que hay debajo»).
  3. **Mecanismo en 2–4 pasos:** cada paso nombra una cosa que aparece en ese momento.
  4. **Giro:** lo que lo rompe o lo sorprendente («si no lo usas, el agua se evapora»).
  5. **Solución o cierre:** que vuelva al principio. El CTA, si lo hay, corto.
- Frases de 6–12 palabras. Sin relleno («hoy te voy a contar…»). Un dato con número y fuente vale más que tres adjetivos.

## Lo visual
- **Un cambio visual cada 2–4 s** (12–20 planos en 40 s): zoom de cámara, algo que se dibuja, algo que fluye.
- **El objeto real, dibujado con precisión:** forma correcta, proporciones creíbles y colores con significado
  (agua azul, gas o suciedad verde/marrón, peligro rojo, bien verde, acento para lo que importa).
- **Sección transversal + cámara que entra al detalle**, y vuelve a abrir en el giro.
- **Cada idea, en su palabra:** la animación entra cuando la voz lo nombra (anclas, nunca segundos a ojo).
- Movimiento: entrada rápida con frenada suave, salida inversa y desenfoque de movimiento. La cámara nunca se para del todo.
- Etiquetas de 1–3 palabras. Nada de párrafos en pantalla.
- Fondo oscuro con un acento: se ve bien en el móvil y los colores de significado destacan.

## Voz (ElevenLabs) · que suene a persona (detalle y fuentes en `investigacion-voz-y-estetica.md`)
- **Lo que más humaniza: una voz clonada de una persona real** (la tuya) o una voz de la librería muy usada en narración.
- Voces populares (ElevenLabs, ayuda oficial): en inglés Brian `nPczCjzI2devNBz1zQrb`, Adam `pNInz6obpgDQGcFmaJgB`, Liam
  `TX3LPaxmHKxFdv7VOQHJ`, Jessica `cgSgspJ2msm6clMCkdW9`, Matilda `XrExE9yKIg1WjnnlVkGX`, Sarah `EXAVITQu4vr4xnSDxMaL`.
  En español de España (librería, por uso): Jon `MFZUKuGQUsGJPQjTS4wC` (narrador cálido), Christopher `G17SuINrv2H9FC6nvetn`,
  David Martin `Nh2zY9kknu6z4pZy6FhD`, Brittney `kPzsL2i3teMYv0FxEYQ6` (redes), Susi `v3V1d2rk6528UrLKRuy8`, Carolina `UOIqAnmS11Reiei1Ytkc`.
  Para usarlas por API o conector, primero añádelas a «My Voices». Pruébalas con un párrafo largo (en una frase todas suenan bien).
- Modelo: **Eleven v4** (el más natural, con etiquetas de audio; sin Style ni Speed) o **multilingual v2** (el más estable):
  estabilidad 0,45 · parecido 0,75 · estilo 0 · speaker boost sí · velocidad 1,0–1,05. Genera el guion entero de una vez
  (más de 250 caracteres: con menos sale irregular), saca 3 tomas y elige.
- **Guion para el oído:** frases de 6–12 palabras, «…» antes del dato clave, comas donde se respira, números y unidades en
  letra, como mucho una palabra en MAYÚSCULAS por frase importante. En v3/v4, 2–4 etiquetas por vídeo ([curious], [pause],
  [exhales]), nunca seguidas.
- Siempre **con tiempos** (with-timestamps / alignment) o alineada con Whisper. Nunca repartir el tiempo a ojo.
- Tratamiento (`mezcla.py`, `"voz_fx": "natural"`): paso alto 70 Hz, de-esser suave, compresión 3:1, sala muy corta y tono de
  sala a −60 dBFS (sin silencios digitales). Sin reductor de ruido.
- Precio orientativo: un reel de 40 s ronda 600–700 caracteres (≈ 0,05 $ por API; ≈ 3 créditos por Higgsfield).

## Movimiento natural (lo que quita el aspecto «mecánico»)
- **Muelles en vez de curvas fijas:** todo entra con física (`X.C.natural` ζ 0,74 por defecto, `blando` 0,55 para cosas ligeras,
  `firme` 0,9 para tarjetas y texto): llega, se pasa un poco y se asienta.
- **Cámara con peso** (`X.camara`): un muelle la lleva a cada clave con inercia y anticipación, con un pulso de «cámara en mano»
  y un poco de giro. Nunca cortes secos ni movimientos lineales.
- **Escalonado:** 40–80 ms entre elementos que entran juntos, cada uno con su curva.
- **Algo se mueve siempre:** agua con olas (`X.ola`), humo que respira (`X.humo`), nubes que pasan, suciedad que tiembla.
- **Desenfoque de movimiento real:** el render final promedia 6 subfotogramas por fotograma (obturador de 180°, `--mb 3`).

## 3D y profundidad de campo (en algunas escenas, no en todas)
- **Inclinación 3D:** las claves de cámara aceptan `rx` / `ry` (grados, 4–16): el mundo gira en perspectiva con la misma
  inercia que la cámara. Úsalo al entrar a un detalle o al cambiar de plano; vuelve a 0 en los planos de lectura.
- **Profundidad de campo:** `X.desenfoqueFondo(capaDeFondo)` desenfoca el fondo más cuanto más zoom hay.
- **Primer plano que pasa por delante:** `X.primerPlano(lienzo, { tipo: 'bokeh' | 'polvo' | función, … })`: objetos muy cerca
  de la cámara, muy desenfocados, que cruzan al moverse (discos de luz, gotas, un tubo, nubes). 4–9 piezas, opacidad baja:
  dan profundidad sin tapar la explicación. Si solo encajan en un tipo de plano (nubes en el cielo), apágalos en los demás.

## Estética (lo que quita el aspecto «vector plano»)
- Volumen y luz en cada pieza: degradados (`X.defs`: cerámica, cromo, agua, madera, luz), sombra de contacto blanda
  (`f-sombra`), brillo en lo importante (`f-brillo`).
- Profundidad: fondo con textura real del sitio (azulejos, cielo con nubes), que se mueve menos que la cámara (`X.profundidad`).
- Grano de película animado y viñeta (`X.grano`, 6–8 %).
- Cuenta la historia con el objeto: si está escondido, se descubre (las puertas del mueble se abren al decir «debajo»).

## Subtítulos y sonido
- Palabra a palabra, 1–3 palabras por bloque, la palabra clave en el color de acento, grandes (≥ 80 px) y con sombra.
- Fuera de las zonas de la interfaz: ni en los 340 px de abajo ni en los 160 px de la derecha. Por defecto, y = 1470.
- Un efecto de sonido en cada cambio (whoosh en la cámara, pop en las etiquetas) y música baja que se aparta sola de la voz.
- Máster a −14 LUFS.

## Temas sensibles (accidentes, víctimas, salud, noticias)
- Rótulo **«Recreación»** visible y fuentes oficiales en la leyenda (informe del organismo, prensa seria).
- Las hipótesis se dicen como hipótesis («la investigación apunta a…»). Nada de culpables, cifras sin confirmar ni rumores.
- Figuras humanas sí, pero genéricas (silueta o dibujo plano sin cara ni parecido con nadie real) para que se entienda
  la historia (alguien dentro de la celda, pasajeros bajando). Nunca retratos de personas reales.
- Sin morbo: no se dibujan personas heridas, ni sangre, ni impactos con efectos espectaculares. Se explica el mecanismo.
- Si el hecho es muy reciente o hay víctimas, se avisa y se pide confirmación antes de publicar.

## Antes de entregar (checklist)
- [ ] Cada dato tiene su URL en `fuentes.md`.
- [ ] El guion está aprobado y la voz escuchada.
- [ ] `render.mjs comprobar` → 0 anclas perdidas.
- [ ] En `hoja.jpg`, en cada momento se ve lo que se dice y nada queda tapado por los subtítulos.
- [ ] `render.mjs gancho` pasa la lista de `ganchos.md` (titular, movimiento antes de 0,5 s, se entiende sin sonido).
- [ ] Al menos 3 elementos por plano y un cambio cada 2–4 s.
- [ ] El vídeo final tiene todos sus fotogramas, a −14 LUFS y sin negros.
- [ ] La leyenda lleva gancho, 2 frases y fuentes (si es un hecho real).
