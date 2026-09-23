# 🚀 INICIO RÁPIDO - Versión Web

## Paso 1: Abre Terminal/Símbolo del Sistema

En **Windows**: 
- Presiona `Windows + R`
- Escribe `cmd` y presiona Enter

En **Mac o Linux**:
- Abre Terminal

## Paso 2: Navega a la carpeta web

```bash
cd Study-the-Holocaust--/web
```

*(Reemplaza `Study-the-Holocaust--` con la ruta exacta donde clonaste el repositorio)*

## Paso 3: Instala las dependencias

```bash
npm install
```

Esto descargará todas las librerías necesarias. **Toma unos 2-3 minutos.**

## Paso 4: Inicia el servidor

```bash
npm run dev
```

## Paso 5: Abre en el navegador

Verás algo como:
```
➜  Local:   http://localhost:5173/
```

**Copia esa dirección y pégala en tu navegador.**

---

## ❌ Si hay errores...

### Error: "npm not found"
- Necesitas instalar Node.js: https://nodejs.org/
- Descarga la versión LTS
- Después de instalar, reinicia la terminal

### Error: "node_modules not found"
- Ejecuta: `npm install` (Paso 3)

### Error: "port 5173 already in use"
- Otra app está usando ese puerto
- Ejecuta: `npm run dev -- --port 5174`

### Error de compilación
- Cierra la terminal con `Ctrl+C`
- Ejecuta:
```bash
rm -rf node_modules package-lock.json
npm install
npm run dev
```

---

## 🎉 Listo!

Una vez que veas "ready in XXXms" en la terminal, abre tu navegador en:

**http://localhost:5173**

¡Disfruta la app!
