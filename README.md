## Prerequisites

Make sure you have the following prerequisites installed before you begin:

- Node.js and npm
- PostgreSQL

## Project Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/davidadarme/FerreSys.git
   ```

2. Configure localhost in the backend directory of the project:

   ```bash
   cd FerreSys/CRUDFerreSys
   ```

3. Install dependencies:

   ```bash
   npm install
   ```

4. Initialize a new Node.js project:

   ```bash
   npm init -y
   ```

5. Install the necessary packages:

    ```bash
    npm i express pg nodemom
    ```

6. Create a connection to the database in [`index.controller.js`](Backend-FerreSys/CRUDFerreSys/index.controller.js):

   ```javascript
    const pool = new Pool({
      host: 'localhost',
      user: 'pg_username',
      password: 'password_user',
      database: 'database_name',
      port: 'port'
    });
   ```

7. Start the server:

    ```bash
    npm run dev
    ```

## License

This project is under the MIT License. See the [LICENSE](LICENSE) file for more details.
