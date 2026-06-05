# 📱 RESULTADOS VISUALES ESPERADOS - Persistencia Dual

## PANTALLA 1: AL INICIAR (SQLite por defecto)

```
┌─────────────────────────────────────────┐
│          Persistencia Dual              │
├─────────────────────────────────────────┤
│                                         │
│  Motor de Base de Datos                 │
│  ┌────────────────────────────────────┐ │
│  │          SQLite Activo              │ │
│  └────────────────────────────────────┘ │
│                          │ SQL │ NoSQL │ │
│                                         │
├─────────────────────────────────────────┤
│                                         │
│         📭 No hay usuarios              │
│      registrados                        │
│                                         │
│   Agrega el primer usuario usando       │
│         el botón "+"                    │
│                                         │
│                                         │
│                                         │
├─────────────────────────────────────────┤
│                                     [+] │
└─────────────────────────────────────────┘

LOGS ESPERADOS:
[14:09:19] [INFO] Inicializando aplicación...
[14:09:19] [INFO] Inicializando Hive...
[14:09:19] [INFO] SQLite inicializado correctamente
[14:09:19] [INFO] Aplicación lista
[14:09:20] [INFO] SQLite: Se obtuvieron 0 usuarios
```

---

## PANTALLA 2: FORMULARIO DE AGREGAR USUARIO

```
┌─────────────────────────────────┐
│    Dialog: Agregar Usuario      │
├─────────────────────────────────┤
│                                 │
│  Nombre                         │
│  ┌───────────────────────────┐  │
│  │ Juan Pérez              │  │
│  └───────────────────────────┘  │
│                                 │
│  Email                          │
│  ┌───────────────────────────┐  │
│  │ juan@example.com        │  │
│  └───────────────────────────┘  │
│                                 │
│          [Cancelar]  [Agregar]  │
│                                 │
└─────────────────────────────────┘
```

---

## PANTALLA 3: DESPUÉS DE AGREGAR (SQLite)

```
┌─────────────────────────────────────────┐
│          Persistencia Dual              │
├─────────────────────────────────────────┤
│                                         │
│  Motor de Base de Datos                 │
│  ┌────────────────────────────────────┐ │
│  │          SQLite Activo              │ │
│  └────────────────────────────────────┘ │
│                          │ SQL │ NoSQL │ │
│                                         │
├─────────────────────────────────────────┤
│  ┌──────────────────────────────────┐   │
│  │ J  │ Juan Pérez                  │   │
│  │    │ juan@example.com            │   │
│  │    │              ✏️ 🗑            │   │
│  └──────────────────────────────────┘   │
│                                         │
│  ┌──────────────────────────────────┐   │
│  │ M  │ María López                 │   │
│  │    │ maria@example.com           │   │
│  │    │              ✏️ 🗑            │   │
│  └──────────────────────────────────┘   │
│                                         │
│  ┌──────────────────────────────────┐   │
│  │ C  │ Carlos García               │   │
│  │    │ carlos@example.com          │   │
│  │    │              ✏️ 🗑            │   │
│  └──────────────────────────────────┘   │
│                                         │
├─────────────────────────────────────────┤
│                                     [+] │
└─────────────────────────────────────────┘

LOGS ESPERADOS:
[14:09:21] [INFO] Usuario agregado en SQLITE: Juan Pérez
[14:09:21] [DEBUG] Regenerados 1 usuarios de SQLITE
[14:09:22] [INFO] Usuario agregado en SQLITE: María López
[14:09:22] [DEBUG] Regenerados 2 usuarios de SQLITE
[14:09:23] [INFO] Usuario agregado en SQLITE: Carlos García
[14:09:23] [DEBUG] Regenerados 3 usuarios de SQLITE

SNACKBAR:
✅ "Usuario agregado correctamente" (verde)
```

---

## PANTALLA 4: CAMBIAR A HIVE (NoSQL)

```
┌─────────────────────────────────────────┐
│          Persistencia Dual              │
├─────────────────────────────────────────┤
│                                         │
│  Motor de Base de Datos                 │
│  ┌────────────────────────────────────┐ │
│  │           Hive Activo               │ │
│  └────────────────────────────────────┘ │
│                          │ SQL │ NoSQL │ │
│                                         │
├─────────────────────────────────────────┤
│                                         │
│         📭 No hay usuarios              │
│      registrados                        │
│                                         │
│    Los datos de Hive están              │
│         separados                       │
│                                         │
│                                         │
│                                         │
├─────────────────────────────────────────┤
│                                     [+] │
└─────────────────────────────────────────┘

LOGS ESPERADOS:
[14:09:24] [DEBUG] Cambiando de BD a: DatabaseType.hive
[14:09:24] [INFO] Hive: Se obtuvieron 0 usuarios
[14:09:24] [DEBUG] Regenerados 0 usuarios de HIVE
[14:09:24] [INFO] BD cambiada correctamente a: DatabaseType.hive

✅ Botón NoSQL se destaca en NARANJA
✅ Lista está VACÍA (datos separados)
✅ App NO se reinicia
```

---

## PANTALLA 5: AGREGAR USUARIOS A HIVE

```
┌─────────────────────────────────────────┐
│          Persistencia Dual              │
├─────────────────────────────────────────┤
│                                         │
│  Motor de Base de Datos                 │
│  ┌────────────────────────────────────┐ │
│  │           Hive Activo               │ │
│  └────────────────────────────────────┘ │
│                          │ SQL │ NoSQL │ │
│                                         │
├─────────────────────────────────────────┤
│  ┌──────────────────────────────────┐   │
│  │ L  │ Luis                        │   │
│  │    │ luis@example.com            │   │
│  │    │              ✏️ 🗑            │   │
│  └──────────────────────────────────┘   │
│                                         │
│  ┌──────────────────────────────────┐   │
│  │ A  │ Ana Martínez                │   │
│  │    │ ana@example.com             │   │
│  │    │              ✏️ 🗑            │   │
│  └──────────────────────────────────┘   │
│                                         │
│                                         │
│                                         │
│                                         │
├─────────────────────────────────────────┤
│                                     [+] │
└─────────────────────────────────────────┘

LOGS ESPERADOS:
[14:09:25] [INFO] Usuario agregado en HIVE: Luis
[14:09:25] [DEBUG] Regenerados 1 usuarios de HIVE
[14:09:26] [INFO] Usuario agregado en HIVE: Ana Martínez
[14:09:26] [DEBUG] Regenerados 2 usuarios de HIVE

✅ Solo aparecen usuarios de HIVE
✅ Usuarios de SQLite no se muestran
✅ Datos PERMANECEN SEPARADOS
```

---

## PANTALLA 6: VOLVER A SQLITE - DATOS SEPARADOS CONFIRMADOS

```
┌─────────────────────────────────────────┐
│          Persistencia Dual              │
├─────────────────────────────────────────┤
│                                         │
│  Motor de Base de Datos                 │
│  ┌────────────────────────────────────┐ │
│  │          SQLite Activo              │ │
│  └────────────────────────────────────┘ │
│                          │ SQL │ NoSQL │ │
│                                         │
├─────────────────────────────────────────┤
│  ┌──────────────────────────────────┐   │
│  │ J  │ Juan Pérez                  │   │
│  │    │ juan@example.com            │   │
│  │    │              ✏️ 🗑            │   │
│  └──────────────────────────────────┘   │
│                                         │
│  ┌──────────────────────────────────┐   │
│  │ M  │ María López                 │   │
│  │    │ maria@example.com           │   │
│  │    │              ✏️ 🗑            │   │
│  └──────────────────────────────────┘   │
│                                         │
│  ┌──────────────────────────────────┐   │
│  │ C  │ Carlos García               │   │
│  │    │ carlos@example.com          │   │
│  │    │              ✏️ 🗑            │   │
│  └──────────────────────────────────┘   │
│                                         │
├─────────────────────────────────────────┤
│                                     [+] │
└─────────────────────────────────────────┘

✅ Botón SQL se destaca en AZUL
✅ Vuelven a aparecer los 3 usuarios de SQLite
✅ NO aparecen Luis ni Ana (están en Hive)
✅ DATOS COMPLETAMENTE SEPARADOS CONFIRMADO
```

---

## PANTALLA 7: EDITAR USUARIO

```
┌─────────────────────────────────┐
│    Dialog: Editar Usuario       │
├─────────────────────────────────┤
│                                 │
│  Nombre                         │
│  ┌───────────────────────────┐  │
│  │ Juan Carlos Pérez      │  │
│  └───────────────────────────┘  │
│                                 │
│  Email                          │
│  ┌───────────────────────────┐  │
│  │ juan@example.com        │  │
│  └───────────────────────────┘  │
│                                 │
│        [Cancelar]  [Actualizar] │
│                                 │
└─────────────────────────────────┘

LOGS ESPERADOS:
[14:09:27] [INFO] Usuario actualizado en SQLITE: Juan Carlos Pérez
[14:09:27] [DEBUG] Regenerados 3 usuarios de SQLITE

SNACKBAR:
✅ "Usuario actualizado correctamente" (verde)

RESULTADO EN LISTA:
J  │ Juan Carlos Pérez
   │ juan@example.com
```

---

## PANTALLA 8: ELIMINAR USUARIO (Confirmación)

```
┌────────────────────────────────────┐
│   Dialog: Confirmar Eliminación    │
├────────────────────────────────────┤
│                                    │
│  ¿Está seguro de que desea         │
│  eliminar a María López?           │
│                                    │
│          [Cancelar]  [Eliminar]    │
│                                    │
└────────────────────────────────────┘

LOGS ESPERADOS:
[14:09:28] [INFO] Usuario eliminado de SQLITE con ID: 2
[14:09:28] [DEBUG] Regenerados 2 usuarios de SQLITE

SNACKBAR:
✅ "Usuario eliminado correctamente" (verde)

RESULTADO EN LISTA:
(Desaparece María López, quedan Juan y Carlos)
```

---

## PANTALLA 9: VALIDACIÓN DE FORMULARIO - ERROR DE NOMBRE

```
┌─────────────────────────────────┐
│    Dialog: Agregar Usuario      │
├─────────────────────────────────┤
│                                 │
│  Nombre                         │
│  ┌───────────────────────────┐  │
│  │ A                        │  │
│  │ ❌ El nombre debe tener  │  │
│  │    al menos 2 caracteres │  │
│  └───────────────────────────┘  │
│                                 │
│  Email                          │
│  ┌───────────────────────────┐  │
│  │ test@example.com        │  │
│  └───────────────────────────┘  │
│                                 │
│          [Cancelar]  [Agregar]  │
│   (botón deshabilitado)         │
│                                 │
└─────────────────────────────────┘
```

---

## PANTALLA 10: VALIDACIÓN DE FORMULARIO - ERROR DE EMAIL

```
┌─────────────────────────────────┐
│    Dialog: Agregar Usuario      │
├─────────────────────────────────┤
│                                 │
│  Nombre                         │
│  ┌───────────────────────────┐  │
│  │ Test User               │  │
│  └───────────────────────────┘  │
│                                 │
│  Email                          │
│  ┌───────────────────────────┐  │
│  │ notanemail              │  │
│  │ ❌ Ingrese un email     │  │
│  │    válido                │  │
│  └───────────────────────────┘  │
│                                 │
│          [Cancelar]  [Agregar]  │
│   (botón deshabilitado)         │
│                                 │
└─────────────────────────────────┘
```

---

## COMPARACIÓN: SQLITE vs HIVE (Datos Separados)

```
╔════════════════════════════════════════════════════════════════╗
║                    PERSISTENCIA DUAL                          ║
╠════════════════════════════════════════════════════════════════╣
║                                                                ║
║  SQLITE (SQL)                    HIVE (NoSQL)                ║
║  ─────────────────────────        ──────────────────────     ║
║  ├─ Juan Pérez                    ├─ Luis                   ║
║  │  juan@example.com              │  luis@example.com       ║
║  │                                │                         ║
║  ├─ Carlos García                 ├─ Ana Martínez          ║
║  │  carlos@example.com            │  ana@example.com       ║
║  │                                │                         ║
║  ├─ Otros usuarios...             ├─ Otros usuarios...      ║
║  │                                │                         ║
║  Almacenado en:                   Almacenado en:           ║
║  /data/users_sqlite.db            /data/hive_box.hive      ║
║                                                                ║
║  ✅ Datos COMPLETAMENTE INDEPENDIENTES                        ║
║  ✅ Cambio de motor SIN reinicio                             ║
║  ✅ Cada motor mantiene su propia información                ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
```

---

## FLUJO DE CAMBIO DINÁMICO (Sin Reinicio)

```
USUARIO ESTÁ VIENDO SQLITE
│
├─ Usuarios: Juan, María, Carlos
├─ Motor: SQL (azul)
│
└─ [USUARIO HACE CLICK EN "NoSQL"]
   │
   ├─ Provider.switchDatabase(DatabaseType.hive)
   │
   ├─ Cambiar _activeRepository
   │
   ├─ loadUsers() desde Hive
   │
   ├─ notifyListeners()
   │
   └─ ✅ UI SE ACTUALIZA (NO REINICIA)
      │
      └─ AHORA MOSTRANDO HIVE
         ├─ Usuarios: Luis, Ana
         ├─ Motor: NoSQL (naranja)
         └─ ⏱️ Tiempo total: < 1 segundo
```

---

## ESTADO DE CARGA (Loading Spinner)

```
┌─────────────────────────────────────────┐
│          Persistencia Dual              │
├─────────────────────────────────────────┤
│  Motor de Base de Datos                 │
│  ┌────────────────────────────────────┐ │
│  │          SQLite Activo              │ │
│  └────────────────────────────────────┘ │
│                          │ SQL │ NoSQL │ │
├─────────────────────────────────────────┤
│                                         │
│                   ⏳                    │
│                 (cargando)              │
│                                         │
│           Actualizando datos...         │
│                                         │
│                                         │
│                                         │
├─────────────────────────────────────────┤
│                                     [+] │
└─────────────────────────────────────────┘
```

---

## RESUMEN DE COMPORTAMIENTO ESPERADO

```
✅ REQUISITO 1: CRUD COMPLETO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Create  → ✅ Botón "+" abre formulario, agrega usuario
Read    → ✅ Lista muestra usuarios del motor activo
Update  → ✅ Lápiz edita usuario existente
Delete  → ✅ Basura elimina con confirmación

---

✅ REQUISITO 2: PERSISTENCIA DUAL
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SQLite  → ✅ Datos en /data/users_sqlite.db
Hive    → ✅ Datos en /data/hive_box.hive
Cambio  → ✅ Switch SQL/NoSQL cambia motor
Datos   → ✅ Cada motor muestra SOLO sus datos

---

✅ REQUISITO 3: CAMBIO DINÁMICO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Sin Reinicio  → ✅ App sigue corriendo
Transición    → ✅ < 1 segundo
UI Reactiva   → ✅ Se actualiza automáticamente
Motor Activo  → ✅ Botón se destaca

---

✅ REQUISITO 4: VALIDACIÓN
━━━━━━━━━━━━━━━━━━━━━━━━━
Nombre  → ✅ Min 2 caracteres
Email   → ✅ Formato válido (RFC)
Errores → ✅ Se muestran en formulario

---

✅ REQUISITO 5: LOGS ESTRUCTURADOS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[INFO]    → ✅ Eventos importantes
[DEBUG]   → ✅ Información interna
[WARNING] → ✅ Situaciones inesperadas
[ERROR]   → ✅ Errores con stack trace

---

✅ REQUISITO 6: VISUALMENTE CLARO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
AppBar        → ✅ "Persistencia Dual"
Indicador BD  → ✅ "SQLite Activo" / "Hive Activo"
Motor Activo  → ✅ Botón destacado (azul/naranja)
Lista         → ✅ Clara y organizada
Feedback      → ✅ SnackBars con mensajes
```

---

## CONCLUSIÓN

La aplicación debe funcionar exactamente como se muestra arriba:

✅ **4 usuarios en SQLite** (Juan, María, Carlos + editar/eliminar)  
✅ **2 usuarios en Hive** (Luis, Ana)  
✅ **Datos completamente separados**  
✅ **Cambio instantáneo entre motores**  
✅ **Sin reinicio ni lag**  
✅ **UI moderna y responsiva**  
✅ **Validaciones funcionando**  
✅ **Logs en consola**  

**LISTA PARA EVALUACIÓN** ✅

