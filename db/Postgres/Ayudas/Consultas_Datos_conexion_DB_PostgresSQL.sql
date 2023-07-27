datos de conexion base de datos postgres

--para saber la version instalada
SELECT version();

--para saber el nombre d ela base de datos conectada
SELECT current_database();

--para saber datos del usuario conectado
SELECT current_user;

--en que puerto estamos trabajando
SHOW listen_addresses;
SHOW port;

select * from tab_articulo
