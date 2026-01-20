# Explicación Técnica: Cómo manejamos los Ambientes en Flutter

Aquí te explico **qué** hicimos para manejar los entornos (Dev, QA, Prod), **por qué** elegimos este camino y **cómo** funciona por debajo.

## 1. ¿Por qué `dart-define-from-file`?

Para este proyecto, decidimos **NO** complicarnos con los "Flavors" de Android ni los "Schemes" de iOS.

**¿La razón?**

- **Es complejo:** Configurar flavors nativos implica tocar archivos delicados como `build.gradle` o `Info.plist`. Si no eres experto en nativo, es fácil romper algo.
- **Es tedioso:** Tienes que mantener configuraciones separadas para cada sistema operativo.

**La solución moderna:**
Usamos **`--dart-define-from-file`**, una herramienta nativa que Flutter sacó hace poco (versión 3.7+).

**Ventajas clave:**

- **Todo es Dart:** Funciona igual en Android, iOS, Web y hasta en Escritorio.
- **Es seguro:** Inyectamos las claves secretas al compilar, así que no quedan escritas en el código.
- **Es limpio:** No ensuciamos el proyecto con configuraciones nativas extrañas.

---

## 2. ¿Cómo funciona la solución?

Lo armamos en tres partes: Archivos, IDE y Código.

### A. Los Archivos (`.env`)

Creamos tres archivos en la raíz. Son nuestra "fuente de verdad".

| Archivo     | Entorno    | ¿Para qué sirve?                                                     |
| :---------- | :--------- | :------------------------------------------------------------------- |
| `.env.dev`  | Desarrollo | Para probar en local mientras codeas. Logs activados, API inestable. |
| `.env.qa`   | Calidad    | Para que QA pruebe. Es un espejo de producción.                      |
| `.env.prod` | Producción | La app real que usan los clientes. Cero logs de debug.               |

> **Nota importante:** Estos archivos están en el `.gitignore`. Nunca se suben al repo. Cada desarrollador debe tener su copia local.

### B. El IDE (`.vscode/launch.json`)

Para no tener que escribir comandos largos en la consola cada vez que quieras correr la app, automatizamos todo en VS Code.

Creamos unos "Perfiles de Lanzamiento". Cuando le das Play a **"demo_valorant (Dev)"**, VS Code hace esto por ti:

```bash
flutter run --dart-define-from-file=.env.dev
```

Básicamente, lee el archivo `.env.dev` y se lo pasa a Flutter.

### C. El Código (`EnvConfig`)

Creamos una clase `EnvConfig` en `lib/core/config/env_config.dart`. Es el puente entre el archivo `.env` y tu código Dart.

**El truco técnico:**
Usamos `String.fromEnvironment()`.

```dart
static const String apiUrl = String.fromEnvironment('API_URL');
```

Como usamos `const`, Flutter aplica algo llamado **"Tree Shaking"**.
Por ejemplo: si en producción `DEBUG_MODE` es `false`, Flutter es tan inteligente que **borra** cualquier bloque `if (DEBUG_MODE)` del ejecutable final. Eso hace que la app sea más ligera y rápida.

---

## Resumen

1.  **Seleccionas** "Dev" en VS Code.
2.  VS Code **toma** el archivo `.env.dev`.
3.  Flutter **compila** la app "quemando" esos valores dentro.
4.  La app **arranca** y sabe que tiene que conectarse a la API de desarrollo.
