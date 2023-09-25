**FerreSys** is an inventory management software. It empowers businesses to effortlessly record product details, maintain real-time inventory tracking, streamline procurement and sales operations, and proactively manage stock levels through automated alerts.

## Requisitos Previos

Asegúrate de tener instalados los siguientes requisitos previos antes de comenzar:

- Node.js y npm
- PostgreSQL

## Configuración del Proyecto

1. Clona este repositorio:

   ```bash
   git clone https://github.com/davidadarme/FerreSys.git
   ```
2. Navega al directorio del proyecto:

   ```bash
   cd FerreSys
   ```

3. Instala las dependencias:

   ```bash
   npm install
   ```

4. Iniciar un nuevo proyecto de `node.js`

   ```bash
   npm init -y
   ```

   La `-y` significa que se configure por default los datos que vaya a pedir. Si no queremos eso y queremos añadir datos adicionales
   entonces solo usamos `npm init`.

   Esto creará un archivo [`package.json`](Backend-FerreSys/package.json) con la configuración predeterminada

5. Instalar los paquetes necesarios
  
    ```bash
    npm install express pg dotenv @babel/core @babel/node @babel/preset-env
    ```

6. Crea un archivo `.env` en la raíz del proyecto para la conexión a la base de datos.

   ```
    DB_HOST=hostname
    DB_USER=username
    DB_PASS=password_user
    DB_NAME=database_name
   ```
   
7. Configurar babel y crear archivo `.babelrc`:
  
    ```/*
    {
      "presets": ["@babel/preset-env"]
    }
    */
    ```
    
8. Crear el archivo [`index.js`](Backend-FerreSys/index.js)

9. Crear conexión a la base de datos con [`conexion_db.js`](Backend-FerreSys/conexion_db.js)

10. Inicializar el servidor
    ```bash
    npx babel-node index.js
    ```

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.