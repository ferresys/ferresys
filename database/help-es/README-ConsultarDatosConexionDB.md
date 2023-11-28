# **CONSULTAR DATOS DE CONEXION EN POSTGRESQL**

## *version instalada*

```BASH

SELECT version();

```
## *Nombre de la Base de Datos Conectada*

```BASH

SELECT current_database();

```
## *Datos del usuario conectado*

```BASH

SELECT current_user;

```
## *En que puerto estamos trabajando*

```BASH

SHOW listen_addresses;
SHOW port;

```

