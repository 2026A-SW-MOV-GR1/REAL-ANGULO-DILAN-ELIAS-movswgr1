# YouTube Clone - Native UI Re-Engineering

Este proyecto es parte del taller "Native UI Re-Engineering & UX Analysis" de la Facultad de Ingeniería de Sistemas.

## Fase A: Selección y Análisis

### 1. Definición de Mercado
**Público Objetivo:** Usuarios de todas las edades (especialmente 15-45 años) que consumen contenido multimedia, tutoriales, entretenimiento y noticias. Usuarios móviles intensivos que valoran la rapidez de carga y la facilidad de navegación.

### 2. Psicología del Color
*   **Rojo (#FF0000):** Color principal de la marca. Evoca pasión, energía y urgencia. Es ideal para captar la atención inmediatamente sobre el logo y los botones de acción (como "Suscribirse").
*   **Negro/Gris Oscuro (#0F0F0F):** Utilizado en el modo oscuro para proporcionar un contraste alto que hace que las miniaturas de los videos resalten. Ayuda a reducir la fatiga visual y ahorra batería en pantallas OLED.
*   **Blanco (#FFFFFF):** Utilizado para texto y elementos de navegación sobre fondo oscuro, proporcionando claridad y una jerarquía visual limpia.

### 3. Auditoría de Componentes (Listas a clonar)
1.  **Feed Principal (Vertical):** Lista infinita de videos con miniaturas grandes, metadatos (título, vistas, tiempo) y menú de opciones.
2.  **Barra de Categorías (Horizontal):** Chips de filtrado que permiten al usuario navegar rápidamente entre temas (Música, Gaming, Noticias, etc.).
3.  **Sección de Shorts (Horizontal/Vertical):** Una lista dedicada para contenido corto con un formato visual distinto (vertical aspect ratio).

---

## Fase C: Crítica y Propuesta de Mejora

### Análisis Crítico
**Falla:** El acceso a la biblioteca y a los videos "Me gusta" a veces requiere demasiados clics o está enterrado en el perfil del usuario, especialmente en las versiones más recientes donde la pestaña "Biblioteca" fue reemplazada por "Tú".

### Propuesta de Mejora
**Solución:** Implementar un acceso rápido persistente o gestos laterales en el Feed para acceder a la lista de reproducción "Ver más tarde" o "Favoritos", mejorando la retención del usuario y la facilidad de acceso a su contenido guardado.
