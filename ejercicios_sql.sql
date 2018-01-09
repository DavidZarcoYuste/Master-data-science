--- ejecutar fichero \i ejercicios_sql.sql desde psql 

-- borrar base de datos email si existe
DROP DATABASE if exists email;

-- crear bd email
CREATE DATABASE email;

-- conectar a Bd email
\c email

-- borrar tablas de bd email
DROP TABLE if exists my_email;
DROP TABLE if exists my_telefono;

-- crear tabla my_email
CREATE TABLE my_email (nombre VARCHAR, 
                       edad INT,
                       mail VARCHAR);

-- insertar filas en my_email                       
INSERT INTO my_email VALUES ('pedro',23,'pedro@hotmail.com'),
                            ('Antonio',34,'antonio@yahoo.es'),
                            ('Ana',65,'ana@hotmail.com'),
                            ('Maria',13,'maria@yahoo.com');

--incluir columnas sexo y teléfono en tabla my_email
ALTER TABLE my_email ADD COLUMN sexo VARCHAR;

ALTER TABLE my_email ADD COLUMN telefono VARCHAR;

-- crear tabla telefonos y mail
CREATE TABLE my_telefono (mail VARCHAR,
                          sexo VARCHAR,
                          telefono INT);

-- insertar filas en my_telefono                       
INSERT INTO my_telefono VALUES ('pedro@hotmail.com','hombre',2343454),
                               ('antonio@yahoo.es','hombre',8889989),
                               ('ana@hotmail.com','mujer',98988988),
                               ('ana@hotmail.com','mujer',45558988),
                               ('maria@yahoo.com','mujer',929202002),
                               ('maria@yahoo.com','mujer',929202002);

                               
-- insertar valores columna sexo y telfono en my_emai desde tabla my_telefono
INSERT INTO my_email(sexo,telefono)
            SELECT A.sexo,
                   A.telefono
             FROM my_telefono A, my_email B
             WHERE A.mail = B.mail;

             
-- borrar tablas de bd email
DROP TABLE if exists copia2_my_email;

-- crear tabla my_email
CREATE TABLE copia2_my_email (edad INT,
                              mail VARCHAR,
                              sexo VARCHAR,
                              telefono INT);

-- insertar valores columna sexo y telfono en my_emai desde tabla my_telefono
INSERT INTO copia2_my_email(edad,mail)
            SELECT A.edad,
                   A.mail
             FROM  my_email A
             WHERE A.edad > 0; 
             
             
-- actualizar registro
UPDATE copia2_my_email 
     SET telefono = 8346466464
     WHERE mail = 'maria@yahoo.com';
        
      
-- visualizar tablas
SELECT * FROM my_email;
SELECT * FROM my_telefono;

-- modificar nombre 'maria@yahoo.com' por María Jesus                            
UPDATE my_email SET nombre = 'Maria Jesus' WHERE mail='maria@yahoo.com';

-- borrar columna nombre de tabla email
ALTER TABLE my_email DROP COLUMN nombre;
                            
-- crear clave primaria
ALTER TABLE my_email ADD PRIMARY KEY (mail,telefono);

-- borrar tablas de bd copia_my_email
DROP TABLE if exists copia_my_email;

-- renombrar la tabla my_email
ALTER TABLE my_email RENAME TO copia_my_email;

-- crear tabla my_email
CREATE TABLE my_email  AS SELECT edad,
                                 mail,
                                 sexo,
                                 telefono
                            FROM copia_my_email;
            
-- selecciona todas las filas cuyo teléfono es distinto
SELECT DISTINCT telefono,mail,sexo FROM my_telefono;

-- Join
  SELECT  copia2_my_email 
       FROM copia2_my_email A INNER JOIN my_telefono B
        ON (A.mail = B.mail);
       
      
  
