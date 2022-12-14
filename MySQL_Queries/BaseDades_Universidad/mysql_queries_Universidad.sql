
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
       -- ,cuatrimestre AS 'cuatrim',    <-- descomentar aquestes linies si es vol debugar-comprobar resultats correctes
       -- curso AS 'Curs',
       -- id_grado AS 'Grau'
       FROM Asignatura
       WHERE cuatrimestre=1
       AND curso=3
       AND id_grado=7;

-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats/des. 
--    El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
--    El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT P.apellido1 AS 'Cognom1', 
       P.apellido2 AS 'Cognom2',
       P.nombre AS 'Nom',
       D.nombre AS 'Departament'       
       FROM Persona P, Departamento D, Profesor PR
       WHERE P.tipo = 'profesor'
       AND PR.id_departamento = D.id
       ORDER BY P.apellido1, P.apellido2, P.nombre ASC;


-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT ASG.nombre AS 'Assignatura',
       CUR.anyo_inicio AS 'inici',
       CUR.anyo_fin AS 'final',
       PER.nombre AS 'Alumne',         --    <-- no ho demanen, és per comprobar resultats
       PER.nif AS 'NIF'                --    <-- no ho demanen, és per comprobar resultats
       FROM Asignatura ASG, Curso_escolar CUR, Alumno_se_matricula_asignatura MAT, Persona PER
       WHERE PER.nif = '26902806M'
       AND PER.id = MAT.id_alumno
       AND ASG.id = MAT.id_asignatura
       AND CUR.id = MAT.id_curso_escolar;

       
-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en 
--    el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT DPT.nombre AS 'Departaments amb professors de Grau Informàtica'
       FROM Departamento DPT, Profesor PRF, Asignatura ASG, Grado GRD
       WHERE DPT.id = PRF.id_departamento
       AND PRF.id_profesor = ASG.id_profesor
       AND ASG.id_grado = GRD.id
       AND GRD.id = 4;
       
	-- RELACIONS (totes 1-N o N-1) ENTRE TAULES:
	--   Grado.id  >>  Asignatura.id_grado 
	--   Asignatura.id_profesor  >>  Profesor.id_profesor
	--   Profesor.id_departamento  >>  Departamento.id


-- 9. Retorna un llistat amb tots els/les alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT CONCAT(PER.apellido1, ' ', PER.apellido2) AS 'Cognoms',
                PER.nombre AS 'Nom'
                -- , CUR.anyo_inicio AS 'Any inici'   --  <-- descomentar linia per comprobar resultats anys
                FROM Persona PER, Alumno_se_matricula_asignatura MAT, Curso_escolar CUR 
                WHERE PER.tipo = 'alumno'                
                AND CUR.anyo_inicio = 2018
                AND CUR.id = MAT.id_curso_escolar
                AND MAT.id_alumno = PER.id;
                
	-- RELACIONS (1-N i N-N) ENTRE TAULES:
	--   1-N.Persona.id  >>  Alumno_se_matricula.id_alumno
    --     N-1.--> Alumno_se_matricula.id_asignatura  >>  Asignatura.id
    --     N-1.--> Alumno_se_matricula.id_curso_escolar  >>  Curso_escolar.id  
    
    
-- 00. Consultes proves necessàries per veure valors reals BD, mentres elaborem Consultes demanades:
SELECT * FROM Persona;
SELECT * FROM Asignatura;
SELECT * FROM Profesor;
SELECT * FROM Departamento;
SELECT * FROM curso_escolar;
SELECT * FROM grado;
SELECT * FROM alumno_se_matricula_asignatura;


-- *****************************************************************************************************
-- ********** Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN. **********

USE UNIVERSIDAD;

-- 01. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats/des. 
--     El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
--     El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
--     El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SHOW COLUMNS FROM Persona;
INSERT INTO Persona VALUES (25, '36525544J', 'Ruben', 'Alcalde', 'Presidente', 'SantaKo', 'Pza.Singerlin n.15', '666999666', '1985/02/25', 'H', 'profesor');
SELECT * FROM Persona;
SELECT DPT.nombre AS 'Departament', 
       PER.apellido1 AS 'Primer cognom', 
       PER.apellido2 AS 'Segon cognom', 
       PER.nombre AS 'Nom' 
       FROM Persona PER 
           LEFT JOIN Profesor PRF ON PER.id = PRF.id_profesor 
           LEFT JOIN Departamento DPT ON PRF.id_departamento = DPT.id 
       WHERE PER.tipo = 'profesor' 
       ORDER BY DPT.nombre, PER.apellido1, PER.apellido2, PER.nombre ASC;


-- 02. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT CONCAT(PER.apellido1, ' ', PER.apellido2, ', ', PER.nombre) AS 'Nom_Professor'
       -- , PRF.id_departamento                                            --  <-- descomentar aquesta línea per testejar
	   FROM Persona PER
            LEFT JOIN Profesor PRF ON PER.id = PRF.id_profesor
            -- RIGHT JOIN Departamento DPT ON PRF.id_departamento = DPT.id
		WHERE PER.tipo = 'profesor'
        AND PRF.id_departamento IS NULL
		ORDER BY Nom_Professor;


-- 03. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT DPT.nombre AS 'Departaments_orfas'
       -- , PER.apellido1
       FROM Departamento DPT, Persona PER 
            LEFT JOIN Profesor PRF ON PRF.id_departamento = DPT.id
	   WHERE PRF.id_profesor IS NULL;
        

-- 04. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT CONCAT(PER.apellido1, ' ', PER.apellido2, ', ', PER.nombre) AS 'Professor (sense assignatura)'
       FROM Persona PER 
            LEFT JOIN Profesor PRF ON PER.id = PRF.id_profesor 
            LEFT JOIN Asignatura ASG ON PRF.id_profesor = ASG.id_profesor 
	   WHERE ASG.id IS NULL 
       AND PER.tipo='profesor';

-- 05. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT ASG.nombre AS 'Assignatura' 
       FROM Profesor PRF 
            RIGHT JOIN Asignatura ASG ON PRF.id_profesor = ASG.id_profesor 
       WHERE ASG.id_profesor IS NULL;

-- 06. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT DPT.nombre AS 'Departament' 
       FROM Departamento DPT 
            LEFT JOIN Profesor PRF ON DPT.id = PRF.id_departamento 
            LEFT JOIN Asignatura ASG ON PRF.id_profesor = ASG.id_profesor 
       WHERE ASG.id_profesor IS NULL;


-- ***************************************
-- **********  CONSULTES RESUM  **********

-- 01. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(id) AS "Total Alumnes" 
       FROM Persona 
       WHERE tipo = 'alumno';        --     <-- eren 11 però hem afegit el Ruben = 12

-- 02. Calcula quants/es alumnes van néixer en 1999.
SELECT COUNT(id) AS "Total Alumnes (del 1999)" 
       FROM Persona 
       WHERE tipo = 'alumno' 
       AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- 03. Calcula quants/es professors/es hi ha en cada departament. 
--     El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
--     El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.

-- SELECT * FROM Departamento;       --    <-- descomentar per veure quants Departaments existeixen en total dins la taula
SELECT DPT.nombre AS 'Departament', 
       COUNT(PRF.id_profesor) AS 'Núm_professors'
       FROM Departamento DPT 
            INNER JOIN Profesor PRF ON DPT.id = PRF.id_departamento 
	   GROUP BY DPT.nombre 
       ORDER BY Núm_professors DESC;

-- 04. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
--     Té en compte que poden existir departaments que no tenen professors/es associats/des. Aquests departaments també han d'aparèixer en el llistat.
SELECT DPT.nombre AS 'Departament', 
       COUNT(PRF.id_profesor) AS 'Núm_professors'
       FROM Departamento DPT 
            LEFT JOIN Profesor PRF ON DPT.id = PRF.id_departamento    --  <-- diferència entre LEFT i INNER, fa que apareguin els Departaments que NO tenen profes
	   GROUP BY DPT.nombre
       ORDER BY Núm_professors DESC;

-- 05. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
--     Té en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
--     El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT GRD.nombre AS 'Grau', 
       COUNT(ASG.id) AS "Núm_assignatures" 
       FROM Grado GRD 
            LEFT JOIN Asignatura ASG ON GRD.id = ASG.id_grado    --  <-- amb el RIGHT no apareixen els Graus que NO tenen assignatures
	   GROUP BY GRD.nombre 
       ORDER BY Núm_assignatures DESC;

-- 06. Retorna un llistat amb el nom de tots els graus existents en la base de dades 
--     i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT GRD.nombre AS 'Grau', 
       COUNT(ASG.id) AS "Núm_assignatures" 
       FROM Grado GRD 
            LEFT JOIN Asignatura ASG ON GRD.id = ASG.id_grado   
	   GROUP BY GRD.nombre 
       HAVING Núm_assignatures > 40;               --     <-- només hauria d'apareixer un Grau que té 51 assignatures

-- 07. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
--     El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT GRD.nombre AS 'Nom Grau', 
       ASG.tipo AS "Tipus assignatura", 
       SUM(ASG.creditos) AS 'Total crèdits' 
       FROM Grado GRD 
            INNER JOIN Asignatura ASG ON ASG.id_grado = GRD.id 
	   GROUP BY GRD.nombre, ASG.tipo;

-- 08. Retorna un llistat que mostri quants/es alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
--     El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats/des.

SELECT CAST(COUNT(MAT.id_alumno) AS UNSIGNED) AS "Núm_alumnes_matriculats",  --  <-- CAST per passar a Integer (unsigned) i que alinei com número
       CAST(CUR.anyo_inicio AS CHAR(4)) AS "Inici_curs_escolar"              --  <-- CAST per passar a String i així alineat a l'esquerra (opcional)
       FROM Curso_escolar CUR 
            LEFT JOIN Alumno_se_matricula_asignatura MAT ON CUR.id = MAT.id_curso_escolar 
	   GROUP BY CUR.id 
       ORDER BY Núm_alumnes_matriculats DESC;
       
-- 09. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. 
--     El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
--     El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
--     El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT PER.id AS 'id_profe', 
       PER.nombre AS 'Nom_profe', 
       PER.apellido1 AS 'Primer_cognom', 
       PER.apellido2 AS 'Segon_cognom', 
       COUNT(ASG.id) AS "Núm_assignatures" 
       FROM Persona PER 
            LEFT JOIN Asignatura ASG ON PER.id = ASG.id_profesor 
	   WHERE PER.tipo = 'profesor' 
       GROUP BY PER.id 
       ORDER BY Núm_assignatures DESC;


-- 10. Retorna totes les dades de l'alumne més jove.
SELECT * 
       FROM Persona 
       WHERE tipo = 'alumno' 
       AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) 
                                      FROM Persona);


-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT CONCAT(PER.apellido1, ' ', PER.apellido2, ', ', PER.nombre) AS 'Professor', 
       DPT.nombre AS 'Departament' 
       FROM Persona PER 
            INNER JOIN Profesor PRF ON PER.id = PRF.id_profesor 
            INNER JOIN Departamento DPT ON PRF.id_departamento = DPT.id 
            LEFT JOIN Asignatura ASG ON ASG.id_profesor = PRF.id_profesor 
	   WHERE ASG.id IS NULL 
       ORDER BY PER.nombre ASC;

