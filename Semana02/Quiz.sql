/*
Complete la sentencia para agregar FK iddepartamento a la tabla usuarios: 

ALTER TABLE usuarios ___ usuarios_fk ___ REFERENCES departamentos(id)

*/

-- george remigio ramirez / Brus Bejarano Briones

ALTER TABLE usuarios 
ADD CONSTRAINT usuarios_fk 
FOREIGN KEY(iddepartamento) REFERENCES departamentos(id)


/*
Complete la senencia para listar la cantidad de perror que hay en la tabla:

select ___ ___ friends_of_pickles where species ___
*/

-- george remigio ramirez: count(*) from ='dog'

select count(*) from friends_of_pickles where species ='dog'

/*
Complete la sentencia para listar la máxima y mínima estatura: 

SELECT ___ ___ FROM friends_of_pickles

*/

-- Brus Bejarano Briones: max(height_cm), min(height_cm)

SELECT max(height_cm), min(height_cm) FROM friends_of_pickles




