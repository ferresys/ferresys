
// CREAMOS UNA CLASE PARA MANEJAR LOS ERRORES CON LA BASE DE DATOS.

class ErrorDeBaseDeDatos extends Error { //Error es la clase nativa a la que se extiende la clase ErrorDeBaseDeDatos.
  constructor(message) { //el constructor es un metodo especial que se usa dentro de la clase y se ejecuta cuando se crea una nueva intancia de la clase. 
    super(message);//se usa para llamar al constructor de la clase nativa Error.
    this.name = 'ErrorDeBaseDeDatos';
    this.statusCode = 404; // el código de estado HTTP asociado con el error.
  }
}

export { ErrorDeBaseDeDatos }; //exportamos la clase para usarla en otros archivos o modulos.
