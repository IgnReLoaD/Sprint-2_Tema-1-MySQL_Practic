
-- BD TIENDA:
USE TIENDA;

-- 1. Llista el nom de tots els productes que hi ha en la taula "producto".
SELECT nombre FROM Producto;
SELECT nombre AS Nom FROM Producto;

-- 2. Llista els noms i els preus de tots els productes de la taula "producto".
SELECT nombre, precio FROM Producto;
SELECT nombre AS Nom, CONCAT(CONVERT(precio, DECIMAL(5,2)),'€') AS Preu_amb_Convert FROM Producto;
SELECT nombre AS Nom, CONCAT(CAST(precio AS DECIMAL(5,2)),'€') AS Preu_amb_Cast FROM Producto;
SELECT nombre AS Nom, CONCAT(FORMAT(precio, 2, 'ca-ES'),'€') AS Preu_amb_Format FROM producto;
SELECT nombre AS Nom, CONCAT(REPLACE(FORMAT(precio, 2, 'es-ES'),'.',','),'€') AS Preu_amb_Replace_Coma FROM Producto;

-- 3. Llista totes les columnes de la taula "producto".
SELECT * FROM Producto;
SHOW COLUMNS FROM Producto;

-- 4. Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans (USD). 
--    NOTA: dia 12-Oct-22
SET @conversorEuroDolar := 0.97;
SELECT nombre AS Nom, 
       CONCAT(REPLACE(FORMAT(precio, 2, 'es-ES'),'.',','),'€') AS Preu_Euros, 
       CONCAT('$',FORMAT(precio * @conversorEuroDolar, 2, 'ca-ES')) AS Preu_Dolars 
       FROM Producto;

-- 5. Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans. Utilitza els següents àlies per a les columnes: nom de "producto", euros, dòlars nord-americans.
SELECT nombre AS 'Nom de producte', 
       CONCAT(REPLACE(FORMAT(precio, 2, 'es-ES'),'.',','),'€') AS 'Preu en euros', 
       CONCAT('$',FORMAT(precio * @conversorEuroDolar, 2, 'en-US')) AS 'Preu en Dòlars nord-americans' 
       FROM Producto;

-- 6. Llista els noms i els preus de tots els productes de la taula "producto", convertint els noms a majúscula.
SELECT UPPER(nombre) AS Nom,
       CONCAT(REPLACE(FORMAT(precio, 2, 'es-ES'),'.',','),'€') AS 'Preu en euros'
       FROM Producto;
       
-- 7. Llista els noms i els preus de tots els productes de la taula "producto", convertint els noms a minúscula.
SELECT LOWER(nombre) AS Nom,
       CONCAT(REPLACE(FORMAT(precio, 2, 'es-ES'),'.',','),'€') AS 'Preu en euros'
       FROM Producto;
       
-- 8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre AS Fabricant,
       UPPER(LEFT(nombre,2)) AS Acronim
       FROM Fabricante;
       
-- 9. Llista els noms i els preus de tots els productes de la taula "producto", arrodonint el valor del preu.
SELECT nombre AS Nom,
	   CONCAT(REPLACE(FORMAT(ROUND(precio), 2, 'es-ES'),'.',','),'€') AS 'Preu en euros arrodonit'
       FROM Producto;
       
-- 10. Llista els noms i els preus de tots els productes de la taula "producto", truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre AS Nom,
	   CONCAT((TRUNCATE(precio,0)),'€') AS 'Preu en euros sense decimals sense arrodonir'
       FROM Producto;

-- 11. Llista el codi dels fabricants que tenen productes en la taula "producto".
SELECT codigo_fabricante AS 'Codi de Fabricant'
       FROM Producto;

-- 12. Llista el codi dels fabricants que tenen productes en la taula "producto", eliminant els codis que apareixen repetits.
SELECT DISTINCT codigo_fabricante AS 'Codi de Fabricant sense repetits'
       FROM Producto;

-- 13. Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre AS 'Nom de Fabricant'
       FROM Fabricante
       ORDER BY nombre ASC;
       
-- 14. Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre AS 'Nom de Fabricant'
       FROM Fabricante
       ORDER BY nombre DESC;

-- 15. Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre AS 'Nom de Producte',
       precio AS 'Preu sense formatar'
       FROM Producto
       ORDER BY nombre ASC, precio DESC;

-- 16. Retorna una llista amb les 5 primeres files de la taula "fabricante".
SELECT * FROM Fabricante LIMIT 5;

-- 17. Retorna una llista amb 2 files a partir de la quarta fila de la taula "fabricante". La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM Fabricante LIMIT 2 OFFSET 3;

-- 18. Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podries usar MIN(preu), necessitaries GROUP BY
SELECT nombre AS 'Nom de Producte',
       precio AS 'Preu de Producte'
       FROM Producto
       ORDER BY precio ASC 
       LIMIT 1;
       
-- 19. Llista el nom i el preu del producte més car. (Fes servir solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podries usar MAX(preu), necessitaries GROUP BY.
SELECT nombre AS 'Nom de Producte',
       precio AS 'Preu de Producte'
       FROM Producto
       ORDER BY precio DESC
       LIMIT 1;       

-- 20. Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre AS 'Nom de Producte'
	   -- codigo_fabricante AS 'codi fabricant'   <-- per Debugar si retorna els correctes
       FROM Producto
       WHERE codigo_fabricante=2;
       
-- 21. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte',
       F.nombre AS 'Nom de Fabricant'
       FROM Producto P, Fabricante F
       WHERE F.codigo = P.codigo_fabricante;
       
-- 22. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.

