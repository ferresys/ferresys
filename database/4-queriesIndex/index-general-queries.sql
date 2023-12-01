/*creacion de indices para mejorar el rendimiento en las consultas,ya que
por lo general usamos ean_art para referenciar ya sea en where,order by o join*/
CREATE INDEX indexEan ON tabArticulo (eanArt);


/*ejemplo(el index ayuda cuando hay muchisimos registros en la tabla)
ya que si hay pocos registros no es tan necesario y si nos ocupa espacio,
tambien puede afectar el rendimiento de las operaciones de inserción, actualización 
y eliminación*/
select *from tabArticulo order by eanArt asc;

/*se supone que con el index creado, automaticamente la base de datos lo usa y 
las consultas se hacen en menor tiempo "se supone"*/