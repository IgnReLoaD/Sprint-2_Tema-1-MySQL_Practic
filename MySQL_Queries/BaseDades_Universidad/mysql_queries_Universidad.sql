
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

-- SELECT 