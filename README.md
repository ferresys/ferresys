## Prerequisites

- Node.js 18
- PostgreSQL 15

## Project Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/davidadarme/FerreSys.git
   cd BackendFerreSys/ #Directory to setup
   ```

2. Initialize the project:

   ```bash
   npm install
   ```
   
4. Configure package.json:

   ```bash
   {
     "name": "backendferresys",
     "version": "1.0.0",
     "description": "",
     "main": "index.js",
     "scripts": {
       "dev": "nodemon config/index.js --exec babel-node"
     },
     "keywords": [],
     "author": "",
     "license": "ISC",
     "dependencies": {
       "cors": "^2.8.5",
       "dotenv": "^16.3.1",
       "express": "^4.18.2",
       "pg": "^8.11.3"
     },
     "devDependencies": {
       "@babel/cli": "^7.23.0",
       "@babel/core": "^7.23.2",
       "@babel/preset-env": "^7.23.2",
       "nodemon": "^3.0.1"
     }
   }
   ```

5. Create `.env` file:

   Create the .env file and enter the credentials of the postgres database

   ```bash
   DB_HOST=host_name 
   DB_USER=user_name
   DB_PASS=user_password
   DB_NAME=database_name
   DB_PORT=port
   ```

7. Star the server

   ```bash
   npm run dev
   ```

This will start the server and it will be listening on the specified path and port http://localhost/4000

## License

This project is under the MIT License. See the [LICENSE](LICENSE) file for more details.
