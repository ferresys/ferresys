## Prerequisites

- Git
- Node.js 18
- PostgreSQL 15

## Project Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/ferresys/ferresys
   ```

2. Setup postgres database with this [instructions](database/README.md):

3. Initialize the project:

   ```bash
   cd app/
   npm install
   ```

4. Create the `.env` file and enter the credentials of the postgres database:

   ```bash
   DB_HOST=host_name 
   DB_USER=user_name
   DB_PASS=user_password
   DB_NAME=database_name
   DB_PORT=port
   SECRET=secret
   ```

5. Star the server

   ```bash
   npm run dev
   ```

## Get routes

This will start the server and it will be listening on the specified path and port http://localhost:4000/

   ```bash
   /articulos
   /clientes
   /usuarios/123456789 #example
   /proveedores
   /marcas
   ```

## License

This project is under the MIT License. See the [LICENSE](LICENSE) file for more details.