
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
       CONCAT('$',FORMAT(precio * @conversorEuroDolar, 2, 'en-US')) AS Preu_Dolars 
       FROM Producto;

-- 5. Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans. Utilitza els següents àlies per a les columnes: nom de "producto", euros, dòlars nord-americans.
SELECT nombre AS 'Nom de producte', 
       CONCAT(REPLACE(FORMAT(precio, 2, 'ca-ES'),'.',','),'€') AS 'Preu en euros', 
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
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte',
       F.nombre AS 'Nom de Fabricant'
       FROM Producto P, Fabricante F
       WHERE F.codigo = P.codigo_fabricante
       ORDER BY F.nombre; 
       
-- 23. Retorna una llista amb el codi del producte, nom del producte, codi del fabricant i nom del fabricant, de tots els productes de la base de dades.
SELECT P.codigo AS 'Codi de Producte',
       P.nombre AS 'Nom de Producte',
       F.codigo AS 'Codi de Fabricant',
       F.nombre AS 'Nom de Fabricant'
       FROM Producto P, Fabricante F
       WHERE F.codigo = P.codigo_fabricante;

-- 24. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte',
       F.nombre AS 'Nom de Fabricant'
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante
       ORDER BY P.precio
       LIMIT 1;
       
-- 25. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte',
       F.nombre AS 'Nom de Fabricant'
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante
       ORDER BY P.precio DESC
       LIMIT 1;

-- 26. Retorna una llista de tots els productes del fabricant Lenovo.
SELECT P.nombre AS 'Nom de Producte',
       F.nombre AS 'Nom de Fabricant'  --   <-- no ho demanen, només és per comprobat que retorna els correctes
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante 
       AND P.codigo_fabricante = 2;

-- 27. Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte',
       F.nombre AS 'Nom de Fabricant'  --   <-- no ho demanen, només és per comprobat que retorna els correctes
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante 
       AND P.codigo_fabricante = 6
       AND P.precio > 200;

-- 28. Retorna una llista amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate. Sense utilitzar l'operador IN.
SELECT P.nombre AS 'Nom de Producte',       
       F.nombre AS 'Nom de Fabricant'  
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante 
       AND (P.codigo_fabricante = 1
       OR P.codigo_fabricante = 3
       OR P.codigo_fabricante = 5);

-- 29. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate. Usant l'operador IN.
SELECT P.nombre AS 'Nom de Producte',       
       F.nombre AS 'Nom de Fabricant'  
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante  
       AND F.nombre IN ( 'Asus', 'Hewlett-Packard', 'Seagate');

-- 30. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte',
       F.nombre AS 'Nom de Fabricant'  --   <-- no ho demanen, només és per comprobar que retorna els correctes
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante 
       AND F.nombre LIKE '%e';

-- 31. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants dels quals contingui el caràcter w en el seu nom.
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte',
       F.nombre AS 'Nom de Fabricant'  --   <-- no ho demanen, només és per comprobar que retorna els correctes
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante 
       AND F.nombre LIKE '%w%';

-- 32. Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte',
       F.nombre AS 'Nom de Fabricant'  --   <-- no ho demanen, només és per comprobar que retorna els correctes
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante 
       AND P.precio >= 180
       ORDER BY P.precio DESC, P.nombre ASC;

-- 33. Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT DISTINCT F.codigo AS 'Codi de Fabricant',
       F.nombre AS 'Nom de Fabricant'
       FROM Fabricante F 
       INNER JOIN Producto P ON P.codigo_fabricante = F.codigo;

-- 34. Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT F.nombre AS 'Nom de Fabricant', 
       P.nombre AS 'Nom de Producte'
       FROM Fabricante F 
       LEFT JOIN Producto P ON F.codigo = P.codigo_fabricante;    --   <-- els Fabricants que no tenen Productes associats mostrarà NULL

-- 35. Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT F.nombre AS 'Nom de Fabricant' 
       FROM Fabricante F
       LEFT JOIN Producto P ON F.codigo = P.codigo_fabricante 
       WHERE P.nombre IS NULL;

-- 36. Retorna tots els productes del fabricant Lenovo. (Sense utilitzar INNER JOIN).
SELECT P.nombre AS 'Nom de Producte',
       F.nombre AS 'Nom de Fabricant'     --   <-- no ho demanen, només és per comprobar que retorna els correctes
       FROM Producto P, Fabricante F
       WHERE F.codigo = P.codigo_fabricante
       AND P.codigo_fabricante = 2;

-- 37. Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense fer servir INNER JOIN).     
USE TIENDA;
SELECT P.* 
       FROM Producto P
       WHERE P.precio = (SELECT MAX(P.Precio) 
								FROM Producto P
                                WHERE P.codigo_fabricante=2);
                                
-- 37. versión mejorada con variables:
SET @maxPrecioLenovo = (SELECT MAX(P.Precio) 
								FROM Producto P
                                WHERE P.codigo_fabricante=2);        --  559€       
SELECT P.* 
       FROM Producto P
       WHERE P.precio = @maxPrecioLenovo;     --  559€       

-- 38. Llista el nom del producte més car del fabricant Lenovo.
SELECT P.nombre AS 'Nom de Producte'
       FROM Producto P 
       WHERE P.precio = @maxPrecioLenovo;     --  559€          

-- 39. Llista el nom del producte més barat del fabricant Hewlett-Packard.
SET @minPrecioHewlett = (SELECT MIN(P.Precio) 
								FROM Producto P
                                WHERE P.codigo_fabricante=3);    -- 59,99€

SELECT P.nombre AS 'Nom de Producte'
       FROM Producto P 
       WHERE P.precio = @minPrecioHewlett;     --  59,99€ 
       
-- 40. Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte'         --   <-- no ho demanen, només és per comprobar que retorna els correctes 
       FROM Producto P 
       WHERE P.precio >= @maxPrecioLenovo;    --  igual o més car que 559€

-- 41. Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SET @precioMedio = (SELECT TRUNCATE(AVG(precio),2) 
                           FROM Producto);
                           
SELECT @precioMedio AS 'Preu mitjà';      --   <-- como un echo de php, per veure que retorna de preu mitjà: 271,72€

SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte'     --   <-- no ho demanen, només és per comprobar que retorna els correctes 
       FROM Producto P 
       WHERE P.codigo_fabricante = 1      --  no retorna cap producte, és correcte. Podem comprobar si posem codigo_fabricante = 2 (Lenovo) sí que en retornaria
       AND P.precio > @precioMedio;       --  més car que preu mitjà de tots productes:  271,723€

-- 00. Consulta de proves necessària per anar mirant els valors reals de BD, mentres elaborem les consultes demanades:
SELECT P.nombre AS 'Nom de Producte',
       P.precio AS 'Preu de Producte',
       F.codigo AS 'Codi de Fabricant',
       F.nombre AS 'Nom de Fabricant'
       FROM Producto P, Fabricante F 
       WHERE F.codigo = P.codigo_fabricante;
       
