
GUIA PARA INICIAR EL PROYECTO EN NODEJS.

1. abre la consola windows y ejecuta el siguiente comando:

	npm init -y

	IMPORTANTE: recuerda estar posicionado en la carpeta del proyecto.

2. instala los paquetes necesarios:

	npm i express pg 


IMPORTANTE : EL PASO 3 Y 4 NO HAY NECESIDAD DE HACERLO SIEMPRE Y CUANDO REVISES EN EL ARCHIVO package.json QUE 
             YA ESTE LA DEPENDENCIA NODEMON JUNTO CON EL SCRIPT.

3. instala nodemon(el cual va a permitir que el servidor se reinice automaticamente)

	npm i nodemon -D

4. en package.json configura nodemon de la siguiente manera:

	{
  "name": "crudferresys",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "dev": "nodemon src/index.js" (esta parte es la que hay que establecer.)
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "dotenv": "^16.3.1",
    "express": "^4.18.2",
    "pg": "^8.11.3"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}


5. configura tu codigo, realiza los cambios necesarios y guarda. 

6. inicia el servidor de la siguiente manera:

	npm run dev (se hace de esta manera, ya que tenemos configurado nodemon).


LISTO! tu servidor esta ejecutandose correctamente a traves de la consola, recuerda que debes guardar los cambios que realices en el codigo y verificar constantemente la consola para ver que todo este correcto. posterior a ello, puedes ejecutar consultas atraves de POSTMAN; haciendo uso de la URL [http://localhost:4000/reciboMercancias].

IMPORTANTE: dependiendo de tu codigo debes establecer las rutas que indicaste alli.por ejemplo:
http://localhost:4000/reciboMercancias
http://localhost:4000/clientes
http://localhost:4000/marcas/1
y asi sucesivamente.

7. SUERTE! y recuerda: "No podemos controlar el viento, pero si ajustar las velas".