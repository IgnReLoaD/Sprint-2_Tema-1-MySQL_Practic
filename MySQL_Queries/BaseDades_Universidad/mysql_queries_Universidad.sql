
-- BD UNIVERSIDAD:
USE UNIVERSIDAD;

-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
--    El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1 AS 'Primer cognom',
       apellido2 AS 'Segon cognom',
       nombre AS 'Nom'       
       FROM Persona
       WHERE tipo='alumno';

-- 2. Esbrina el nom i els dos cognoms dels/les alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre AS 'Nom', 
       CONCAT(apellido1, ' ', apellido2) AS 'Cognoms'
       FROM Persona 
       WHERE tipo = 'alumno' 
       AND telefono IS NULL;

-- 3. Retorna el llistat dels/les alumnes que van néixer en 1999.
SELECT CONCAT(apellido1, ' ', apellido2) AS 'Cognoms',
       nombre AS 'Nom',
       fecha_nacimiento AS 'Naixement'       --    <-- no ho demanen però només és per comprobar que retorna els correctes
       FROM Persona 
       WHERE tipo = 'alumno' 
       AND Persona.fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT nombre AS 'Nom', 
       CONCAT(apellido1, ' ', apellido2) AS 'Cognoms',
       nif AS 'NIF',
       telefono AS 'Telf.'
       FROM Persona 
       WHERE tipo = 'profesor' 
       AND telefono IS NULL
       AND nif like '%K';

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre AS 'Nom Assignatura'
       -- ,cuatrimestre AS 'cuatrim',       --   <-- descomentar per debugar-comprobar resultats correctes
       -- curso AS 'Curs',
       -- id_grado AS 'Grau'
       FROM Asignatura
       WHERE cuatrimestre=1
       AND curso=3
       AND id_grado=7;


-- 00. Consulta de proves necessària per anar mirant els valors reals de BD, mentres elaborem les consultes demanades:
SELECT * FROM Persona;
SELECT * FROM Asignatura;
