    
    Valstock= 50
    Valmin= 10
    Valmax= 80
    
    ENTRADA = 60 
    ENTRADA = 10
    ENTRADA = 5

    SALIDA = 60
    SALIDA = 10
    SALIDA = 5

   IF (zCantArt - zValStock) < zStockMin THEN
        RAISE EXCEPTION 'No se puede realizar la operacion, el stock hara que sea menor que el stock minimo';
        RAISE NOTICE 'Error 4';
    
    osea que si es mayor si es valido
    END IF;

    if (60-50) < 10
          10 < 10 = test passed

    if (10-50) < 10
         40 < 10 = test passed
          
    if (5-50) < 10
         45 < 10 = test passed

    if (41-50) < 10
         9 < 10 = test not passed


---

Valstock= 30
Valmin= 10
Valmax= 500

