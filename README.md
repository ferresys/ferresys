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

3. Initialize a new Node.js project:

   ```bash
   npm init -y
   ```

4. Install the necessary packages:

    ```bash
    npm i express pg
    ```
    
    ```bash
    npm i nodemon -D
    ```


5. Configure nodemos in [package.json](
CRUDFerreSys/src/controllers/index.controller.js) as follows

   ```javascript
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

   ```

6. Start the server:

    ```bash
    npm run dev
    ```

Done! the server is running correctly through CLI, remember to save all the changes that you make to the code and check constantly the CLI to see that everything is correct. After that, you can run queries through you web browser or Postman, using url http://localhost:4000/

## License

This project is under the MIT License. See the [LICENSE](LICENSE) file for more details.