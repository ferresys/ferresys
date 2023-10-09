
# CONFIGURAR UN NUEVO PROYECTO NODEJS

1. **CREAMOS LA CARPETA DONDE ESTARA EL PROYECTO**

    - [x] FerreSys
------

2. **INICIAMOS UN NUEVO PROYECTO**

    - [x] npm init -y 

* la -y significa que se configure por default los datos que vaya a pedir. si no queremos eso y queremos añadir datos adicionales entonces solo usamos "npm init" *

*Esto creará un archivo package.json con la configuración predeterminada)*

------

3. **INSTALAMOS LOS PAQUETES NECESARIOS PARA EL PROYECTO.**

    - [x] npm install express pg dotenv 

*express: es un framework y nos permite crear aplicaciones web en nodejs y con este creamos el servidor.*

*pg: para conectar con la base de datos.*

*dotenv: variables de entorno-para mantener los datos de conexion como contraseña, host,usuario en una carpeta oculta y que no se muestren en el codigo- esto se hace en un archivo ".env".*

------

    - [X]npm install @babel/node -g

*Babel es una herramienta que se utiliza para transpilar (convertir) código JavaScript moderno (por ejemplo, 
 ECMAScript 6 y superiores) en código JavaScript compatible con versiones anteriores de navegadores.*

*babel para que compile el codigo con las ultimas actualizaciones ECMAScript ES6(2015), LA -g significa global*

------

   - [x]npm install @babel/cli @babel/core @babel/preset-env -D

-@babel/cli: Este paquete proporciona una interfaz de línea de comandos (CLI) para Babel. Te permite ejecutar Babel desde la línea de comandos para transpilar tu código JavaScript. Puedes usarlo para compilar tus archivos de origen con sintaxis moderna a una forma que sea compatible con navegadores y entornos más antiguos. La CLI es útil para tareas de compilación manual o en secuencias de comandos personalizadas.*

-@babel/core*: Este paquete contiene el núcleo de Babel, que es el motor principal que realiza la transformación del código JavaScript. Es esencial para cualquier configuración de Babel y se utiliza tanto en la CLI como en el entorno de desarrollo. También es necesario para configurar Babel en herramientas de construcción como Webpack.*

-@babel/preset-env*: Este es un conjunto de plugins de Babel que permite compilar código JavaScript moderno a versiones específicas de JavaScript basadas en el entorno objetivo que determines. Por ejemplo, puedes configurarlo para compilar tu código moderno a una versión específica de ECMAScript (como ES5) que sea compatible con la mayoría de los navegadores. Esto facilita la escritura de código moderno y su compatibilidad con múltiples entornos.*

**IMPORTANTE:**
-*ES6 ECMAScript (ES)* es una especificación de lenguaje de programación que define los estándares para JavaScript. Es decir, ES es la especificación oficial que establece cómo debe comportarse el lenguaje JavaScript en diferentes versiones.(la ultima version es la ES13 (2022) y la primera version es la ES1 lanzada en (1997)).

-*COMMONJS* es un sistema de módulos utilizado principalmente en entornos de servidor, como Node.js. Proporciona una forma de organizar y modularizar el código en módulos reutilizables. En CommonJS, se utilizan las palabras clave require para importar módulos y module.exports (o exports) para exportar valores desde un módulo. 


    - [X] npm i nodemon -D

*Te permite reiniciar automáticamente tu servidor de Node.js cada vez que detecta cambios en tus archivos de código fuente, lo que facilita el proceso de desarrollo y pruebas. La opción `-D` en `npm install` indica que `nodemon` se instala como una dependencia de desarrollo.*


4. **EN  package.json CONFIGURA NODEMON Y BABEL DE LA SIGUIENTE MANERA:**

  {
  "name": "backendferresyscrud",
  "version": "1.0.0",
  "description": "Sistema de Gestión de Inventarios y Ventas para Ferreterías en Node.js",
  "main": "index.js",
  "scripts": {
    "kraken": "nodemon src/index.js --exec babel-node" (ESTA PARTE ES LA QUE SE AGREGA PARA PODER CORRER NODEJS CON: npm run go)
  },
  "keywords": [
    "FerreSys"
  ],
  "author": "Yocser Chavez, David Adarme, Diego Largo",
  "license": "MIT",
  "dependencies": {
    "dotenv": "^16.3.1",
    "express": "^4.18.2",
    "pg": "^8.11.3"
  },
  "devDependencies": {
    "@babel/cli": "^7.23.0",
    "@babel/core": "^7.23.0",
    "@babel/preset-env": "^7.22.20",
    "nodemon": "^3.0.1"
  }
}

------

4. **CREAMOS EL ARCHIVO ".env"**

*crear un archivo ".env" e ingresar los datos o credenciales de la base de datos postgres*

DB_HOST=nombre_del_host 
DB_USER=nombre_del_usuario 
DB_PASS=contraseña_del_usuario 
DB_NAME=nombre_de_la_base_de_datos 
DB_PORT=puerto especificado

**ejemplo:**

DB_HOST=localhost
DB_USER=postgres
DB_PASS=Kraken123
DB_NAME=FerreSysDB
DB_PORT=5432
------------------------------------------------------------------------------------------------

5.**CONFIGURAMOS BABEL**

*crear archivo ".babelrc" y crear codigo:*



{
  "presets": [
  "@babel/preset-env"
  ]
}


------

6.**CREAR EL SERVIDOR app EXPRESS**

    -[X] crear el archivo index.js*
*Crea un archivo llamado index.js en la raíz de tu proyecto y agrega el código para configurar el servidor app Express*

------

7.**CREAR LA CONEXION A LA BASE DE DATOS**

    -[X] crear un archivo conectionDB.js
*este archivo lo ubicamos dentro de la carpeta config*
*en este archivo vamos a programar el codigo para la conexion con la base de datos.*

------

8.**CREAR LOS MIDDLEWARE**

    -[X] crear el archivo classError.js
    -[X] crear el archivo error.js

*para especificar los try catch de manejo de errores.*

9.**REAR LOS CONTROLADORES**

    -[X] crear un archivo crudController.js

*contendra todas las funciones de controlador*

10.**CREAR LAS RUTAS**

    -[X]crear archivo indexRoutes.js

*en este archivo creamos el codigo que contendra todas las rutas.*

------

10.**INICIAR EL SERVIDOR**

en la consola usamos el siguiente comando:

    -[X]npm run kraken

*esto iniciara el servidor y quedara escuchando en la ruta y el puerto especificado.*

PORT: - [X] http//localhost/4000







***glosario java script***

**palabra clave:** import- const- 
**variables:** contenedor de tipos de datos varchar ,numeric,
**instancias:** declaracion de una const para una clase ejemplo app(instancia)= express(clase)
**metodo:** get,post,put,patch,delete 
**ECMAScript (ES13):** estandar actualizado
**pg:** paquete o modulo para postgresql que contiene Pool de conexiones.




