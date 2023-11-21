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

3. Create the `.env` file and enter the credentials of the postgres database:

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
