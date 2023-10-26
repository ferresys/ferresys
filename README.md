## Prerequisites

- Node.js
- PostgreSQL 15

## Project Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/davidadarme/FerreSys.git
   ```

2. Configure localhost in the directory of the project:

   ```bash
   cd FerreSys
   ```

3. Initialize the project:

   ```bash
   npm init -y
   ```

4. Install the necessary packages:

    ```bash
   npm install express pg dotenv
    ```

    ```bash
   npm install @babel/node -g
   ```

   ```bash
   npm install @babel/cli @babel/core @babel/preset-env -D
   ```

   ```bash
   npm i nodemon -D
   ```

5. Configure package.json:

   ```bash
   {
   "name": "FerreSys",
   "version": "1.0.0",
   "description": "Sistema de Gestión de Inventarios y Ventas para Ferreterías en Node.js",
   "main": "index.js",
   "scripts": {
      "kraken": "nodemon BackendFerreSys/config/index.js --exec babel-node"
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
   ```

6. Create `.env` file:

   Create the .env file and enter the credentials of the postgres database

   ```bash
   DB_HOST=host_name 
   DB_USER=user_name
   DB_PASS=user_password
   DB_NAME=database_name
   DB_PORT=port
   ```

7. Configure the Babel file:

   ```bash
   {
   "presets": [
   "@babel/preset-env"
   ]
   }
   ```

8. Star the server

   ```bash
   npm run kraken
   ```

This will start the server and it will be listening on the specified path and port http://localhost/4000

## License

This project is under the MIT License. See the [LICENSE](LICENSE) file for more details.