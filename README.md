**FerreSys** is an inventory management software for hardware stores. It empowers businesses to effortlessly record product details, maintain real-time inventory tracking, streamline procurement and sales operations, and proactively manage stock levels through automated alerts. This sophisticated tool enhances day-to-day workflow efficiency and empowers informed decision-making by providing comprehensive data analytics and detailed performance reports. With its intuitive and user-friendly interface, FerreSys ensures rapid adoption among staff, consequently elevating competitiveness and productivity within the ever-evolving hardware store market.

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

   Esto creará un archivo `package.json` con la configuración predeterminada

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
    
8. Crear el archivo vscode-vfs://github%2B7b2276223a312c22726566223a7b2274797065223a352c226964223a22646f6373227d7d/davidadarme/FerreSys/Backend-FerreSys/conexion_db.js

9. Crear conexión a la base de datos con [conexion_db.js](Backend-FerreSys/conexion_db.js)

10. Inicializar el servidor
    ```bash
    npx babel-node index.js
    ```

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

## Terminología

`express`: es un framework y nos permite crear aplicaciones web en nodejs y con este creamos el servidor

`pg`: para conectar con la base de datos

`dotenv`: variables de entorno-para mantener los datos de conexion como contraseña, host,usuario en una carpeta oculta y que no se muestren en el codigo- esto se hace en un archivo `.env`

`@babel/core @babel/node @babel/preset-env`: Herramientas para usar el estándar ES6 en el servidor

ES6 ECMAScript (ES) es una especificación de lenguaje de programación que define los estándares para JavaScript. Es decir, ES es la especificación oficial que establece cómo debe comportarse el lenguaje JavaScript en diferentes versiones.
(instalamos todas las dependencias que necesitemos para poder trabajar en el proyecto)

# Contribución

**Contribución mediante Fork y Pull Requests**

1. **Fork del Repositorio:** Haz un fork de nuestro repositorio.

2. **Clona el Repositorio:** Clona tu repositorio fork en tu máquina local utilizando el comando `git clone`.

   ```bash
   git clone https://github.com/davidadarme/FerreSys.git
   ```

3. **Crea una Rama:** Crea una nueva rama para tu contribución.

   ```bash
   git checkout -b tu-nueva-funcion
   ```

4. **Realiza tus Cambios:** Realiza las modificaciones y mejoras que desees en tu rama local.

5. **Confirma tus Cambios:** Confirma tus cambios con mensajes descriptivos.

   ```bash
   git commit -m "Añadida nueva función: <nombre-de-la-funcion>"
   ```

6. **Push a tu Repositorio Fork:** Sube tus cambios a tu repositorio fork en GitHub.

   ```bash
   git push origin tu-nueva-funcion
   ```

7. **Crea un Pull Request:** Visita nuestro repositorio en GitHub y selecciona tu rama. Luego, haz clic en **"New Pull Request"** para crear una solicitud de extracción. Asegúrate de proporcionar información detallada sobre tus cambios.

8. **Revisión y Fusión:** Nuestro equipo revisará tu Pull Request y, si es aceptada, tus cambios se fusionarán con el repositorio principal.
