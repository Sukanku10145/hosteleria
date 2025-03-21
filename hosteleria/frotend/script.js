// Función para cargar las categorías desde la API
async function cargarCategorias() {
    try {
      const response = await fetch("http://localhost:3000/categorias");
      const categorias = await response.json();
      const categoriaSelect = document.getElementById("categoria");
  
      // Añadir las categorías al select
      categorias.forEach(categoria => {
        const option = document.createElement("option");
        option.value = categoria.nombre;
        option.textContent = categoria.nombre;
        categoriaSelect.appendChild(option);
      });
    } catch (error) {
      console.error("Error al cargar las categorías:", error);
    }
  }
  
 async function cargarPlatos(categoria = "") {
  try {
    const url = categoria ? `http://localhost:3000/platos?categoria=${categoria}` : "http://localhost:3000/platos";
    const response = await fetch(url);
    const platos = await response.json();
    console.log(platos); // Ver los platos que se están recibiendo desde la API

    const productosDiv = document.getElementById("productos");

    // Limpiar productos anteriores
    productosDiv.innerHTML = "";

    // Mostrar los platos
    platos.forEach(plato => {
      const divProducto = document.createElement("div");
      divProducto.classList.add("producto");

      divProducto.innerHTML = `
        <img src="${plato.imagen}" alt="${plato.nombre}">
        <h3>${plato.nombre}</h3>
        <p>${plato.descripcion}</p>
        <p>Precio: $${plato.precio}</p>
      `;

      productosDiv.appendChild(divProducto);
    });
  } catch (error) {
    console.error("Error al cargar los platos:", error);
  }
}

  
  // Función para filtrar platos por categoría
  function filtrarPorCategoria() {
    const categoria = document.getElementById("categoria").value;
    cargarPlatos(categoria);
  }
  
  // Llamadas iniciales
  cargarCategorias();
  cargarPlatos();
  