/*
Complete la sentencia para agregar FK iddepartamento a la tabla usuarios: 

ALTER TABLE usuarios ___ usuarios_fk ___ REFERENCES departamentos(id)

*/

-- george remigio ramirez / Brus Bejarano Briones

ALTER TABLE usuarios 
ADD CONSTRAINT usuarios_fk 
FOREIGN KEY(iddepartamento) REFERENCES departamentos(id)

 