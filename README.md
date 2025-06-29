
# 🎮 Trabajo Final SQL – Simulación de Steam

Este proyecto es el trabajo final de la cursada de SQL, donde se diseñó y desarrolló una base de datos relacional inspirada en la plataforma de distribución de videojuegos **Steam**.

## 📌 Objetivo

Simular el funcionamiento interno de una plataforma de videojuegos mediante una base de datos robusta que permita almacenar, gestionar y consultar información relacionada con juegos, usuarios, géneros, bibliotecas y reseñas.

---

## 🧱 Estructura del Proyecto

El repositorio contiene los siguientes archivos:

- `estructura.sql`: creación de tablas, claves primarias y foráneas.
- `insert_data.sql`: carga de datos simulados utilizando Mockaroo.
- `funciones_y_procedimientos.sql`: funciones, procedimientos almacenados y vistas relevantes.
- `triggers.sql`: definición de triggers para mantener la integridad y automatizar tareas.
- `consultas_avanzadas.sql`: consultas complejas para extracción de insights.
- `diagramas/`: carpeta con el DER (diagrama entidad-relación) y el modelo lógico.

---

## 🧮 Tablas principales

- `juegos`
- `usuarios`
- `generos`
- `bibliotecas`
- `reseñas`
- `juegos_generos`
- `juegos_bibliotecas`

---

## 🧠 Funcionalidades destacadas

- Cálculo automático del promedio de reseñas por juego.
- Trigger para actualizar la cantidad de juegos en la biblioteca de un usuario.
- Procedimiento para registrar una compra de juego por parte del usuario.
- Consulta de juegos más populares por género o por calificación.

---

## 🧪 Tecnologías y herramientas

- **MySQL**
- **Mockaroo** (para generación de datos)
- **DBeaver / MySQL Workbench** (para pruebas locales)
- **dbdiagram.io** (para modelos visuales)

---

## 📊 Ejemplo de consulta avanzada

```sql
-- Top 5 juegos mejor valorados con al menos 10 reseñas
SELECT j.nombre, AVG(r.puntaje) AS promedio
FROM juegos j
JOIN reseñas r ON j.id_juego = r.id_juego
GROUP BY j.id_juego
HAVING COUNT(r.id_resena) >= 10
ORDER BY promedio DESC
LIMIT 5;
```

---

## 🧑‍💻 Autor

Juan Mamelo  
🔗 [LinkedIn](https://www.linkedin.com/in/juanmamelo)  
📧 juanmamelo@gmail.com

---

## 📥 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.
