# Nivel Viegas · calidad visual y retención

El listón: que parezca una ilustración técnica de revista animada por un estudio, no un esquema de PowerPoint.
Cada escena tiene que poder ser una captura bonita por sí sola.

## Dibujo realista (obligatorio)
- **Materiales con textura y luz** (`motor/materiales.js`, `X.materiales(svg)`): cada objeto principal lleva su material.
  `m-madera` muebles y suelos · `m-metal` tuberías, piezas, chapa · `m-ceramica` lavabos, azulejos, platos · `m-hormigon`
  paredes, suelo, edificios · `m-organico` cuerpo humano, comida, plantas · `m-plastico` aparatos · `m-papel` · `m-cristal`
  ventanas, vasos · `m-tierra` terreno · `m-tela` ropa, cortinas. El color lo pone el `fill`; la textura y la luz se suman.
- **Formas con volumen:** nada de rectángulos planos. Bordes redondeados, perspectiva leve (3/4), grosor visible en los cortes
  (la pared de un tubo, la sección de un órgano), detalles pequeños que dan verdad (tornillos, juntas, vetas, poros, gotas).
- **Luz coherente desde arriba a la izquierda:** brillos especulares en metal, cristal y agua; sombra de contacto bajo cada
  objeto (`X.contacto`), oclusión en los rincones (`filter="url(#m-oclusion)"` en piezas encajadas), halo suave tras lo importante.
- **Fondo con lugar:** el sitio real donde ocurre (cocina, cielo, interior del cuerpo, carretera), con su textura, desenfocado
  con el zoom (`X.desenfoqueFondo`) y con parallax (`X.profundidad`). Nunca fondo vacío.
- **Profundidad:** 3 planos mínimo (fondo desenfocado · objeto nítido · primer plano que pasa, `X.primerPlano`).
- **Paleta:** fondo oscuro cálido, colores reales de los objetos un poco saturados, un acento de marca (#FF8A5B) solo en lo
  que hay que mirar. Colores con significado: agua azul, calor naranja/rojo, gas verde, electricidad cian/amarillo.
- **Grano y viñeta** siempre (`X.grano`).

## Recursos que llaman la atención (usa 3–5 por vídeo, variados)
- **Lupa** (`X.lupa`) que amplía el detalle clave de la escena real (la grieta, la válvula, la célula).
- **Corte que se abre:** el objeto entero se parte o se vuelve transparente y se ve por dentro (puertas, capas que se separan).
- **Onda de impacto** (`X.onda`) en el momento clave, **flecha curva** que se dibuja (`X.flecha`), **destello** en el
  titular (`X.destello`), **contador** de cifras (`X.contador`), comparación lado a lado, antes/después, escala (algo que
  crece hasta llenar la pantalla).
- **Inclinación 3D** de la cámara (`rx`/`ry`) al entrar en un detalle y **primer plano desenfocado** que cruza.

## Retención al máximo
- **Fotograma 0 = la imagen más llamativa del vídeo** (el problema ya visible: el humo saliendo, la grieta, el récord).
  Sin fundido, sin logo, sin «hola».
- **Gancho en 1,5 s** (pregunta o dato imposible) y **la primera sorpresa visual antes de los 3 s** (algo se abre, aparece la lupa…).
- **Cambio visual cada 2–3 s** (nuevo plano de cámara, algo se dibuja, un recurso nuevo). Nunca 4 s con la misma imagen quieta.
- **Interruptor de patrón a mitad** (entre el 45 % y el 60 %): el giro con un cambio de color, de escala o de plano muy marcado.
- **Barra de progreso** fina arriba y **subtítulos palabra a palabra** con la clave en acento.
- **Final que enlaza con el principio** (la última imagen recuerda a la primera: favorece el bucle y que lo vean dos veces).
- 30–45 s. Si un plano no explica nada, fuera.

## Revisión antes de renderizar (hoja de 18 fotogramas)
- [ ] ¿Cada fotograma podría ser una miniatura? ¿Se entiende qué está pasando sin sonido?
- [ ] Materiales en todos los objetos principales, sombra de contacto y fondo con lugar.
- [ ] Nada tapado por los subtítulos (y = 1470) ni pegado a los bordes; textos de etiquetas ≥ 40 px.
- [ ] 3–5 recursos llamativos distintos y un cambio visual cada 2–3 s.
- [ ] Cifras y nombres con su fuente en `fuentes.md`.
