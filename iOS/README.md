# Study the Holocaust - App iOS

Plataforma educativa móvil dedicada a la enseñanza rigurosa de la historia de la Shoah y la Alemania nazi.

## 📱 Descripción

App nativa para iPhone desarrollada en **Swift** con **SwiftUI**. Proporciona acceso educativo a:
- Biografías de perpetradores nazis
- Cronología de leyes discriminatorias (1933-1945)
- Búsqueda y filtrado avanzado
- Sistema de marcadores personales
- Acceso offline

## 🏗️ Arquitectura

### Estructura del Proyecto

```
StudyTheHolocaust/
├── App/
│   └── StudyTheHolocaustApp.swift          # Entry point
├── Models/
│   ├── Perpetrator.swift                   # Perpetradores nazis
│   ├── Legislation.swift                   # Leyes nazi
│   └── Article.swift                       # Artículos educativos
├── ViewModels/
│   ├── PerpetratorsViewModel.swift
│   ├── LegislationViewModel.swift
│   └── BookmarksViewModel.swift
├── Views/
│   ├── ContentView.swift                   # Tab navigation principal
│   ├── HomeView.swift                      # Pantalla de inicio
│   ├── PerpetratorsListView.swift
│   ├── PerpetratorsDetailView.swift
│   ├── LegislationView.swift
│   ├── LegislationDetailView.swift
│   ├── BookmarksView.swift
│   └── SearchView.swift
├── Services/
│   ├── DataManager.swift                   # Gestión de datos y persistencia
│   └── SearchService.swift                 # Lógica de búsqueda y filtrado
└── Resources/
    └── data.json                           # Datos de ejemplo (reemplazar con API)
```

## ✨ Características Actuales (MVP)

### ✅ Implementadas
- [x] Navegación por tabs
- [x] Lista de perpetradores con búsqueda
- [x] Vista detallada de perpetrador
- [x] Cronología de legislación nazi (1933-1945)
- [x] Filtrado por período de tiempo
- [x] Sistema de marcadores (persistencia con UserDefaults)
- [x] Búsqueda global
- [x] Datos de ejemplo en JSON

### 📋 Próximas Fases
- [ ] Integración con API/CMS cuando la web esté completa
- [ ] Imágenes de perpetradores
- [ ] Módulo de testimonios
- [ ] Mapas interactivos
- [ ] Timeline visual
- [ ] Podcasts integrados
- [ ] Modo offline mejorado (Core Data)
- [ ] Sincronización iCloud

## 🚀 Requisitos de Desarrollo

- Xcode 15.0+
- iOS 15.0+
- Swift 5.9+
- macOS 13.0+ (para desarrollo)

## 📦 Instalación

1. Abrir proyecto en Xcode:
```bash
open StudyTheHolocaust.xcodeproj
```

2. Seleccionar simulador o dispositivo
3. Presionar ▶️ Play para compilar y ejecutar

## 🔗 Integración de Datos

### Reemplazar datos de ejemplo

Actualmente la app carga datos desde `Resources/data.json`. Cuando la web esté completa:

1. **Opción 1: API REST**
   - Modificar `DataManager.swift` para consumir API
   - Usar URLSession para requests HTTP
   - Implementar caché con Core Data

2. **Opción 2: Extracción de web estática**
   - Parsear HTML de studytheholocaust.org
   - Estructurar a JSON
   - Distribuir con la app

3. **Opción 3: Backend centralizado**
   - Migrar datos a Firebase/Supabase
   - Sincronización en tiempo real
   - Escalable para múltiples apps

## 🎯 Patrones y Estándares

- **MVVM**: Model-View-ViewModel
- **SwiftUI**: Framework declarativo moderno
- **Combine**: Reactive programming
- **ObservableObject**: State management

## 🔍 Búsqueda y Filtrado

`SearchService` proporciona métodos para:
- Búsqueda por texto en perpetradores
- Búsqueda por texto en legislación
- Filtrado por rango de años
- Filtrado por organización

## 💾 Persistencia

- **Marcadores**: `UserDefaults` (JSON encoding)
- **Datos locales**: JSON embebido
- **Futuro**: `Core Data` para sincronización avanzada

## 📱 Respuesta Adaptativa

App diseñada para funcionar en:
- iPhone SE (2ª gen) - 4.7"
- iPhone 14/15 - 6.1"
- iPhone 14/15 Plus - 6.7"
- iPhone 16 Pro Max - 6.9"

## 🛠️ Debugging

Habilitar logs en `DataManager`:
```swift
print("Cargando datos...")
print("Perpetradores: \(perpetrators.count)")
print("Legislación: \(legislation.count)")
```

## 📄 Licencia

Proyecto educativo de Study the Holocaust
Rigurosa, sin dramatismo, basada en fuentes primarias.

---

**Lema:** Remember. Learn. Never Again.
