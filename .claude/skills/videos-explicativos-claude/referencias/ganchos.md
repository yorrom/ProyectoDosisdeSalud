# Ganchos, primer fotograma y nivel de detalle

Lo que decide si alguien se queda pasa en los primeros 2 segundos. Esta guía es obligatoria en los pasos 3, 5 y 6.

## 1 · El gancho hablado (guion)
Escribe **3 ganchos distintos** (máx. 8 palabras cada uno) con fórmulas diferentes y enséñalos para que la persona elija:
- **Dato imposible:** «146 metros… y lo atrapa al vuelo».
- **Peligro inmediato:** «No eches agua a esta sartén».
- **Lo haces mal:** «Estás desempañando el coche al revés».
- **Cifra de la noticia:** «7 aviones. Un día. Cero bombas».
- **Pregunta con contradicción:** «Ya te vacunaste… ¿por qué otra vez?».
- **Resultado primero:** «Esta pantalla se dobla 200 000 veces».
Reglas: nada de «hoy te cuento», nada de saludo, la primera palabra ya es el tema. Cifras solo si están en `fuentes.md`.

## 2 · El primer fotograma (imagen imposible)
- **Fotograma 0 = el momento más fuerte del vídeo**, no su arranque: la bola de fuego, el cohete colgado de la torre,
  el mapa lleno de aviones en rojo. El vídeo luego explica cómo se llega ahí (o rebobina con un efecto rápido).
- **Titular grande** (`.titular`, Bricolage, 3–5 palabras, una en acento con `<em>`) visible desde 0 s hasta ~2 s, en la
  mitad superior (y ≈ 300–600), sin tapar el objeto principal. Ese fotograma sirve de miniatura.
- **Movimiento desde 0 s:** la cámara ya entra con un zoom rápido (z de 1,0 a 1,3 en 0,6 s), un golpe de sonido
  (`X.sonido(0, 'whoosh')`) y algo que cambia antes de 0,5 s. **Segundo cambio antes de 2 s.**
- Contraste máximo: fondo oscuro, el objeto en el centro con su acento, sin elementos pequeños alrededor.

## 3 · Nivel de detalle (cada escena cuenta la historia)
- Cada plano lleva **al menos 3 elementos** que respondan a **qué, dónde y quién**: no solo el objeto principal.
  Ej. cárcel → celda con barrotes **+ figura dentro + sello «provisional» + mazo del juzgado**.
- **Dibuja lo que dice el guion:** cada sustantivo importante de la frase (documentos, dinero, avión, ciudad, policía,
  pasajeros) tiene su dibujo representativo cuando se nombra.
- **Figuras humanas representativas, permitidas siempre que sean genéricas:** silueta o figura de dibujo plana, sin cara
  ni rasgos, sin ropa ni marcas reconocibles, que nunca se parezca a una persona real. En noticias, con el rótulo
  «Recreación». Siguen prohibidos: retratos de personas reales, heridos, sangre y violencia.
- Detalle secundario con vida: pequeños objetos que se mueven (papeles que caen, luces que parpadean, gente de fondo
  como siluetas), sombras de contacto y materiales.

## 4 · Tipografías
- **Subtítulos:** Figtree 700, blanco (lo que se dice).
- **Palabras clave y titulares:** Bricolage 700, más grande y en el color de acento (lo que importa).
Ya viene así en `motor/explica.css`; no uses una tercera fuente salvo la de marca de la persona.

## 5 · Comprobación del gancho (antes del render final)
`node <skill>/scripts/render.mjs <proyecto> gancho` → mira `resultados/gancho.jpg` (0 · 0,5 · 1 · 2 · 3 s) y responde:
- [ ] ¿Se entiende el tema sin sonido en el fotograma 0?
- [ ] ¿Hay titular grande con una palabra en acento?
- [ ] ¿Cambia algo visible antes de 0,5 s y otra vez antes de 2 s?
- [ ] ¿El fotograma 0 funcionaría como miniatura?
- [ ] ¿Cada fotograma tiene al menos 3 elementos que cuentan la historia?
Si falla alguna, corrige y repite. **No se renderiza el final sin pasarla.**

## 6 · Gancho de noticia: lo más fuerte del suceso, dibujado
En noticias, el fotograma 0 enseña **lo más llamativo e importante del hecho**, no un símbolo abstracto:
- Busca en `fuentes.md` la imagen que mejor resume la noticia (quién actúa y cómo) y dibújala en grande:
  ej. Blocus → varios «usuarios» con pasamontañas y el móvil iluminándoles + la bandera del país detrás.
- **Varias figuras genéricas** (grupo, multitud) dan más fuerza que una sola: 4–6 bustos a distintas alturas y tamaños,
  que entran uno a uno en los primeros 0,5 s, con luz de acento (pantallas, fuego, sirenas).
- **Contexto del lugar** con un símbolo reconocible: bandera, mapa, edificio o monumento (sin escudos oficiales).
- **Acciones del suceso** dibujadas en la escena que lo cuenta (barricadas ardiendo, contenedores empujados, bengalas,
  saqueos, policía con escudos), **solo si están en las fuentes**. Lo que no esté confirmado (p. ej. molotov, armas)
  no se dibuja: dilo a la persona y apúntalo en `fuentes.md` como «no confirmado».
- Sigue valiendo «Temas sensibles»: figuras sin cara ni parecido real, sin heridos ni sangre, rótulo «Recreación»,
  presunción de inocencia en el texto.
- El titular va sobre una placa oscura y el fondo se atenúa mientras se ve (que se lea en el móvil).
