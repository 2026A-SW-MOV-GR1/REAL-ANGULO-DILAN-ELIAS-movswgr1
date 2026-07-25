# Taller: La Batalla del Estado - Ciclo de Vida y Persistencia

Este proyecto implementa el desafío del contador para analizar el ciclo de vida y la persistencia de datos en **Flutter**.

## 1. El Experimento: Resultados

### Pruebas de Persistencia
*   **Rotación:** Al aumentar el contador a 10 y girar el celular, **el contador se mantiene**. 
    *   **¿Por qué?** A diferencia de Android Nativo, Flutter no destruye el estado de los widgets (`State`) durante un cambio de configuración (como la rotación). El motor de Flutter permanece vivo y simplemente vuelve a ejecutar el método `build` con las nuevas dimensiones de pantalla.
*   **Multitarea:** Al salir al "Home" y volver, el contador se mantiene intacto.

### Logs de Ciclo de Vida (Secuencia capturada)
Al realizar las acciones, se observan los siguientes logs en consola:

1.  **Inicio de la App:**
    *   `LIFECYCLE: onCreate / initState`
    *   `LIFECYCLE: build`
2.  **Salir al Home (Minimizar):**
    *   `LIFECYCLE: onPause / inactive`
    *   `LIFECYCLE: onStop / paused`
3.  **Volver a la App:**
    *   `LIFECYCLE: onResume / resumed`
4.  **Rotación de Pantalla:**
    *   `LIFECYCLE: build`
    *   *(Nota: No se disparan onDestroy ni onCreate en Flutter durante la rotación, lo que demuestra su eficiencia frente al nativo)*.

## 2. Persistencia de Instancia en Flutter

En **Android Nativo**, se usan `onSaveInstanceState`. En **Flutter**, la persistencia durante la rotación es **automática** dentro del objeto `State`. 

Sin embargo, si quisiéramos persistir los datos incluso si el Sistema Operativo mata la app por falta de memoria (Persistent Storage), usaríamos:
*   `shared_preferences` para datos simples.
*   `sqflite` para bases de datos.

## 3. Explicación Técnica (Entregable)
Para este taller, se utilizó el mixin `WidgetsBindingObserver` para suscribirse a los eventos del sistema operativo. 

**Funciones Clave:**
*   `initState()`: Inicialización del estado (Equivalente a `onCreate`).
*   `didChangeAppLifecycleState()`: Captura los cambios de estado (resumed, inactive, paused).
*   `setState()`: Notifica al framework que el estado interno ha cambiado y debe redibujar, manteniendo la variable `_counter` en memoria RAM durante toda la vida del proceso de la app.
