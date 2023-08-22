/*creacion de indices para mejorar el rendimiento en las consultas,ya que
por lo general usamos ean_art para referenciar ya sea en where,order by o join*/
CREATE INDEX index_ean ON tab_articulo (ean_art);
CREATE INDEX index_fecha ON tab_articulo (fec_reg);

/*ejemplo(el index ayuda cuando hay muchisimos registros en la tabla)
ya que si hay pocos registros no es tan necesario y si nos ocupa espacio,
tambien puede afectar el rendimiento de las operaciones de inserción, actualización 
y eliminación*/
select *from tab_articulo order by ean_art asc;

/*se supone que con el index creado, automaticamente la base de datos lo usa y 
las consultas se hacen en menor tiempo "se supone"*/