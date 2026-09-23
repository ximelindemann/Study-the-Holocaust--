# Estudiando el Holocausto - Web Version

Una versión web completamente funcional de la aplicación educativa sobre el Holocausto y la Segunda Guerra Mundial.

## 🚀 Inicio Rápido

### Requisitos
- Node.js 16+ 
- npm o yarn

### Instalación

```bash
cd web
npm install
```

### Desarrollo

```bash
npm run dev
```

La aplicación se abrirá en `http://localhost:5173`

### Build para Producción

```bash
npm run build
```

Los archivos compilados estarán en la carpeta `dist/`

## 📱 Características

### Módulos Principales

✅ **Inicio** - Página principal con descripción de la app
✅ **Artículos** - Ensayos y artículos educativos (8 artículos)
✅ **Documentales** - Películas y documentales seleccionados (7 documentales)
✅ **Perfiles** - Historias de sobrevivientes, rescatadores, perpetradores y líderes (7 perfiles)
✅ **Campos** - Base de datos completa de campos (22 campos)
  - 12 Campos de Concentración
  - 7 Campos de Exterminio
  - 2 Campos de Tránsito
  - 1 Campo de Trabajo Forzado
✅ **Perpetradores** - Base de datos de perpetradores nazis (46 personas)
✅ **Legislación** - Documentos legales y leyes nazis
✅ **Mapa** - Visualización geográfica de campos
✅ **Timeline** - Línea de tiempo de eventos
✅ **Quiz** - Cuestionario educativo
✅ **Estadísticas** - Datos y análisis
✅ **Marcadores** - Sistema de guardado personal
✅ **Buscar** - Búsqueda global de contenido

### Funcionalidades Técnicas

- ✅ **Navegación con Pestañas** - Interfaz similar a la versión iOS
- ✅ **Búsqueda y Filtrado** - En múltiples módulos
- ✅ **Marcadores Persistentes** - Guardados en localStorage
- ✅ **Modo Oscuro** - Automático según preferencias del sistema
- ✅ **Responsivo** - Funciona en desktop, tablet y móvil
- ✅ **Sin Dependencias Externas** - Solo React, Vite y Tailwind

## 🏢 Base de Datos de Campos (Nuevos)

### Campos de Exterminio (7)
- **Auschwitz-Birkenau** - ~1.1 millones de muertes (Polonia)
- **Treblinka** - ~900,000 muertes (Polonia)
- **Sobibor** - ~250,000 muertes (Polonia)
- **Belzec** - ~600,000 muertes (Polonia)
- **Chelmno** - ~320,000 muertes (Polonia)
- **Majdanek** - ~360,000 muertes (Polonia)
- **Jasenovac** - ~100,000 muertes (Croacia/Yugoslavia)

### Campos de Concentración (12)
- Dachau, Buchenwald, Ravensbrück, Mauthausen, Bergen-Belsen, Sachsenhausen, Flössenburg, Stutthof, Groß-Rosen, Neuengamme, Theresienstadt, y más

### Información por Campo
- Tipo de campo
- Territorio/País
- Ubicación específica
- Fechas de establecimiento y liberación
- Estimación y cifras documentadas de muertes
- Descripción detallada
- Significancia histórica
- Operadores/comandantes
- Fuentes bibliográficas

## 📊 Estadísticas

**Total de Campos: 22**
- Por territorio: Polonia (7), Alemania (8), Austria (1), Checoslovaquia (1), Yugoslavia (1), Francia (2), Países Bajos (1)
- Muertes documentadas: 4,366,750

## 🛠️ Tecnología

- **Frontend**: React 18
- **Build Tool**: Vite
- **Styling**: Tailwind CSS
- **Gestor de Estado**: React Hooks
- **Persistencia**: localStorage
- **Data**: JSON

## 📁 Estructura del Proyecto

```
web/
├── src/
│   ├── App.jsx              # Componente principal con navegación
│   ├── main.jsx             # Punto de entrada
│   ├── index.css            # Estilos Tailwind
│   └── views/               # Vistas principales
│       ├── HomeView.jsx
│       ├── CampsView.jsx    # ⭐ Nueva vista de campos
│       ├── CampDetailView.jsx # ⭐ Detalle de campos
│       ├── ArticlesView.jsx
│       ├── DocumentariesView.jsx
│       ├── ProfilesView.jsx
│       └── ...
├── public/
│   └── data.json            # Base de datos compartida con iOS
├── index.html
├── package.json
├── tailwind.config.js
└── vite.config.js
```

## 🌐 Cómo Usar

### Navegación
1. **Pestañas Inferiores** - Cambia entre módulos con los botones inferiores
2. **Búsqueda** - Usa la barra de búsqueda en cada módulo
3. **Filtros** - En Campos y otros módulos, filtra por tipo y territorio
4. **Marcadores** - Guarda contenido favorito haciendo clic en el ícono 📌

### Ejemplo: Explorar Campos

1. Haz clic en la pestaña **"Campos"** (ícono 🏢)
2. Usa los filtros de **tipo** (Exterminio, Concentración, etc.)
3. Filtra por **territorio** (Polonia, Alemania, etc.)
4. Busca un campo específico en la barra de búsqueda
5. Haz clic en un campo para ver detalles completos
6. Guarda campos importantes con el botón 🔖

## 🔄 Sincronización iOS ↔️ Web

La versión web comparte el mismo archivo `data.json` con la app iOS. Esto significa:
- La misma base de datos en ambas versiones
- Fácil mantener consistencia de contenido
- Posibilidad futura de sincronizar marcadores

## 📈 Próximas Mejoras

- [ ] Implementar módulos de Perpetradores con búsqueda avanzada
- [ ] Agregar mapas interactivos
- [ ] Implementar cuestionario educativo
- [ ] Crear dashboard de estadísticas
- [ ] Sincronización de bookmarks entre web e iOS
- [ ] Modo offline con service workers

## 📝 Datos de Referencia

### Campos Cubiertos
- **22 campos históricos** documentados
- Cobertura de **8 territorios** diferentes
- Desde 1933 (Dachau) hasta 1945
- Información sobre operadores y significancia histórica

### Otros Módulos (compartidos con iOS)
- 46 perpetradores nazis
- 8 artículos educativos
- 7 documentales/películas
- 7 perfiles históricos

## 📚 Referencias

- Archivos de Auschwitz
- Yad Vashem
- Documentos de Núremberg
- Testimonios de sobrevivientes
- Investigaciones historiográficas

## ⚙️ Variables de Entorno

No requiere variables de entorno. La aplicación funciona completamente de forma local.

## 📄 Licencia

Esta es una aplicación educativa sin fines de lucro.

---

**¿Preguntas o sugerencias?** Contacta al desarrollador.
