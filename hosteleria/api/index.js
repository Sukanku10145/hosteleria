const express = require("express");
const { Pool } = require("pg");
const cors = require("cors");
require("dotenv").config();

const app = express();
app.use(express.json());
app.use(cors());

// Conexión a PostgreSQL usando pool
const pool = new Pool({
  user: process.env.PG_USER,
  host: process.env.PG_HOST,
  database: process.env.PG_DATABASE,
  password: process.env.PG_PASSWORD,
  port: process.env.PG_PORT || 5432,
});

// Endpoint para obtener todos los platos
app.get("/platos", async (req, res) => {
  try {
    const { categoria } = req.query; // Obtiene la categoría si se pasa como parámetro
    let query = `
      SELECT p.id, p.nombre, p.descripcion, p.precio, p.fecha_creacion, p.imagen
      FROM Platos p
      LEFT JOIN AsociacionPlatoCategoria apc ON p.id = apc.plato_id
      LEFT JOIN CategoriasPlato c ON apc.categoria_id = c.id
    `;
    
    // Si se pasa una categoría, añade un filtro a la consulta
    if (categoria) {
      query += " WHERE c.nombre = $1";
    }

    const result = await pool.query(query, categoria ? [categoria] : []);
    res.json(result.rows); // Devuelve los platos como JSON
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint para obtener un plato por ID
app.get("/platos/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query("SELECT * FROM Platos WHERE id = $1", [id]);
    if (result.rows.length > 0) {
      res.json(result.rows[0]); // Devuelve el plato encontrado
    } else {
      res.status(404).json({ message: "Plato no encontrado" });
    }
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint para obtener las categorías
app.get("/categorias", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM CategoriasPlato");
    res.json(result.rows); // Devuelve las categorías como JSON
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint para agregar un nuevo plato
app.post("/platos", async (req, res) => {
  const { nombre, descripcion, precio, imagen, categorias } = req.body;
  try {
    // Insertar el plato
    const insertPlato = await pool.query(
      "INSERT INTO Platos (nombre, descripcion, precio, imagen) VALUES ($1, $2, $3, $4) RETURNING id",
      [nombre, descripcion, precio, imagen]
    );

    const platoId = insertPlato.rows[0].id;

    // Insertar las asociaciones de categoría (si se proporcionan)
    if (categorias && categorias.length > 0) {
      const associations = categorias.map((categoriaId) => {
        return pool.query(
          "INSERT INTO AsociacionPlatoCategoria (plato_id, categoria_id) VALUES ($1, $2)",
          [platoId, categoriaId]
        );
      });

      await Promise.all(associations);
    }

    res.status(201).json({ message: "Plato creado", platoId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint para agregar una nueva categoría
app.post("/categorias", async (req, res) => {
  const { nombre, tipo } = req.body; // tipo puede ser 'comida', 'bebida' o 'otros'
  try {
    const result = await pool.query(
      "INSERT INTO CategoriasPlato (nombre, tipo) VALUES ($1, $2) RETURNING id",
      [nombre, tipo]
    );
    res.status(201).json({ message: "Categoría creada", categoriaId: result.rows[0].id });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Iniciar el servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
