// errors.js

class ErrorDeBaseDeDatos extends Error {
  constructor(message) {
    super(message);
    this.name = 'ErrorDeBaseDeDatos';
    this.statusCode = 404; // O el código de estado HTTP que desees
  }
}

export { ErrorDeBaseDeDatos };
