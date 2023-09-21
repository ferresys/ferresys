--@yocser revisar
-- crear trigger por errores de salida-entrada de datos en el front-end
CREATE PROCEDURE backupDatabase
    @ferresysDB NVARCHAR(255),
    @RutaCopiaSeguridad NVARCHAR(255)
AS
BEGIN
    DECLARE @SentenciaSQL NVARCHAR(MAX);

    SET @SentenciaSQL = 
        'BACKUP DATABASE ' + @ferresysDB + ' ' +
        'TO DISK = ''' + @RutaCopiaSeguridad + '''';

    EXEC (@SentenciaSQL);
END;