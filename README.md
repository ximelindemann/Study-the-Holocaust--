Study the Holocaust — Vocero Digital LENA
Ejercicio Práctico: Creación de Voceros Digitales Personalizados
Módulo 3 · Identidad Sonora y Avatar Conversacional
Coderhouse AI Content Creation · Junio 2026
Autora: Ximena Basualdo
---
Estructura del Repositorio
```
/
├── Lena_Look.png                        # Imagen del personaje — Character Sheet pose 1
├── Elevenlabs_Manifiesto_STH.mp3        # Audio del manifiesto narrado con voz clonada
└── README.md                            # Este documento

/output (Google Drive — ver enlace al final)
└── AVATAR_Sth.mp4                       # Video final — LENA narrando el manifiesto con música de marca
```
---
Descripción del Proyecto
Este ejercicio consolida el workflow de producción multimedia de Study the Holocaust unificando los activos de identidad visual (Módulo 2), identidad sonora (Módulo 3) y avatar conversacional (HeyGen) en una pieza de video-marketing profesional.
Study the Holocaust es una marca educativa dedicada a la enseñanza de la historia de la Shoah y la Alemania nazi en plataformas digitales. Su filosofía editorial: habitar en la conciencia de las personas para la empatía, no para la política; para el entendimiento, no para la polémica.
---
Guion del Manifiesto
El siguiente guion fue desarrollado específicamente para el avatar conversacional LENA y narrado mediante voz clonada generada en ElevenLabs Studio:
---
> La historia de la Shoah no se puede simplificar.
> No se puede dramatizar. Se enseña con rigor, con fuentes, con nombres.
>
> Study the Holocaust nació de esa convicción. De años trabajando con historiografía académica,
> con fuentes primarias, con los testimonios de quienes sobrevivieron.
> De entender que detrás de cada cifra hay una persona.
> Una historia interrumpida que merece ser contada con la seriedad que exige.
>
> El olvido no es neutral.
> La verdad histórica no se negocia.
> Y la memoria es lo que decidimos hacer con el pasado.
>
> *Remember. Learn. Never again.*
---
Duración del guion narrado: 40 segundos
Estructura narrativa: manifiesto de marca en primera persona editorial. El tono es sobrio, pedagógico y memorial — sin dramatismo artificial, sin recursos de impacto emocional, sin sensacionalismo. El impacto proviene del peso histórico de las palabras, no de la forma en que se presentan.
---
Descripción de la Voz — ElevenLabs Studio
Parámetro	Valor
Modelo	Eleven Multilingual v2
Tipo de voz	Clon vocal de Ximena Basualdo
Stability	35
Similarity Boost	75
Style Exaggeration	35
Velocidad	0.96
Archivo generado	Elevenlabs_Manifiesto_STH.mp3
La voz clonada replica el acento, la cadencia y el registro vocal de la autora de la marca. Los parámetros fueron calibrados para maximizar la naturalidad de la dicción en el contexto memorial — evitando la sobreactuación emocional característica de las voces sintéticas sin calibración previa.
---
Descripción del Avatar — HeyGen
Parámetro	Valor
Plataforma	HeyGen
Tipo de avatar	Photo Avatar
Imagen de referencia	Lena_Look.png
Nombre del personaje	LENA
Apariencia	Mujer joven, cabello rubio lacio, ojos azules, pecas sutiles
Vestimenta	Cuello de tortuga negro, blazer azul marino oscuro
Entorno	Biblioteca académica histórica, iluminación cálida
Encuadre	Plano medio
Método de audio	Upload Audio — audio externo de ElevenLabs
Sincronización labial	Automática por análisis de visemas
Nota metodológica: Se utilizó la opción "Upload Audio" de HeyGen en lugar de la voz por defecto de la plataforma para mantener el control total sobre el tono, la cadencia y el registro vocal del personaje. Esta decisión garantiza la coherencia entre la voz clonada de ElevenLabs y el avatar visual — un principio fundamental del sistema de identidad sonora desarrollado en el Módulo 3.
---
Proceso de Sincronización Labial
Paso 1 — Preparación del audio:
El archivo `Elevenlabs_Manifiesto_STH.mp3` fue generado con pausas naturales entre oraciones para facilitar la animación automática de visemas. Las pausas permiten que el avatar parpadee y realice microgestos entre frases, evitando el efecto de continuidad artificial que se produce cuando el personaje narra sin interrupciones.
Paso 2 — Carga en HeyGen:
El audio fue subido mediante la función "Upload Audio" en la línea de tiempo de HeyGen. La plataforma analizó el espectro de frecuencias del audio y generó automáticamente la sincronización labial cuadro por cuadro.
Paso 3 — Verificación:
Se revisó la coherencia entre los movimientos de labios y la dicción en los segmentos de mayor velocidad de habla — particularmente en las frases "con rigor, con fuentes, con nombres" y "Remember. Learn. Never again."
---
Post-producción — Música de Marca (CapCut Web)
Parámetro	Valor
Software	CapCut Web (plan Pro)
Pista de música	echoes_of_remembrance_musica_sth_entrega.mp3
Volumen de música	-8 dB (aproximadamente 15-20% del volumen original)
Fundido de entrada	1 segundo
Fundido de salida	1 segundo
Reducción de ruido	Aplicada
Resolución de exportación	1080p
Formato	MP4
FPS	30
La música de marca fue generada en ElevenLabs Music (Módulo 3): violín solista en Re menor, 65 BPM, carácter memorial y sobrio. El volumen fue nivelado a -8 dB para que la música funcione como identidad sonora de fondo sin opacar la locución del avatar.
---
Coherencia con el Manual de Identidad Visual (Módulo 2)
Elemento	Especificación
Paleta cromática	#0A0A0A (negro) · #C9A84C (dorado) · #F7F3EC (crema)
Entorno del avatar	Biblioteca académica histórica — coherente con moodboard M2
Vestimenta de LENA	Cuello de tortuga negro + blazer oscuro — definida en Character Sheet M2
Tono comunicacional	Sobrio, pedagógico, memorial — sin sensacionalismo
Música	Memorial, instrumental, Re menor — definida en Identidad Sonora M3
---
Stack Tecnológico
Herramienta	Función
ElevenLabs Studio	Clonación de voz y generación del audio del manifiesto
HeyGen	Generación del avatar con sincronización labial
Leonardo.ai	Generación de la imagen de referencia del personaje (Lena_Look.png)
CapCut Web	Post-producción: integración de música, ajuste de volumen y exportación
---
Video Final — Enlace de Acceso
El archivo `AVATAR_Sth.mp4` supera el límite de 25 MB permitido por GitHub para subida directa. El video final está disponible en Google Drive con acceso público:
Ver video — AVATAR_Sth.mp4
Especificaciones técnicas del video final:
Parámetro	Valor
Duración	40 segundos
Resolución	1080p
Formato	MP4
FPS	30
Contenido	LENA narrando el manifiesto de Study the Holocaust con música de marca integrada
---
Study the Holocaust · Remember. Learn. Never Again.
Autora: Ximena Basualdo · @studytheholocaust
