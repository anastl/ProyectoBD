-- 1. Nombre de superhéroe o supervillano que poseen poderes artificiales y que han sido líderes
SELECT "Personaje"."NombreCompleto"
FROM "Proyecto"."Personaje"
WHERE "Personaje"."NombreCompleto" IN (
    SELECT "Personaje"
    FROM "Proyecto"."Posee"
    WHERE "Posee"."FormaObtencion" = 'Artificial'
) AND "Personaje"."EsCivil" = FALSE AND "Personaje"."NombreCompleto" IN (
    SELECT "Lider"
    FROM "Proyecto"."Organizacion"
)

-- 2. Series que han tenido más episodios que el promedio
SELECT "Serie"."Titulo"
FROM "Proyecto"."Serie"
WHERE "Serie"."TotalEpi" > (
    SELECT AVG( "Serie"."TotalEpi" )
    FROM "Proyecto"."Serie"
);

-- 3. Los 5 objetos más usados por héroes o villanos
SELECT "Objeto"."Nombre"
FROM "Proyecto"."Porta"
JOIN "Proyecto"."Personaje" ON "Porta"."Nombre" = "Personaje"."NombreCompleto"
JOIN "Proyecto"."Objeto" ON "Porta"."Objeto" = "Objeto"."Nombre"
WHERE "Personaje"."EsCivil" = false
GROUP BY "Objeto"."Nombre"
ORDER BY COUNT("Objeto"."Nombre") DESC
LIMIT 5;

-- 4. Muestre las 3 locaciones donde se han desarrollado más combates
SELECT "Combate"."Lugar"
FROM "Proyecto"."Combate"
GROUP BY "Combate"."Lugar"
ORDER BY COUNT( "Combate"."Lugar" ) DESC
LIMIT 3;

-- 5. Imprima las películas que tengan más de 2 horas y media de duración, sean de tipo animada, cuya ganancia sea mayor al promedio de todas las películas del mismo tipo, ordenadas cronológicamente por el costo de producción
SELECT "Titulo"
FROM "Proyecto"."Pelicula"
WHERE "Duracion" > 150 AND "TipoPelicula" = 'Animada' AND "Ganancias" > (
	SELECT AVG("Ganancias") 
	FROM "Proyecto"."Pelicula" 
	WHERE "TipoPelicula" = 'Animada')
ORDER BY "CosteProd" ASC;

-- 6. Liste toda la información de los poderes que son heredados y que tengan en su nombre la cadena “Super”. Además, dicho poder lo deben tener al menos 2 villanos
SELECT *
FROM "Proyecto"."Poder"
WHERE "Poder"."Nombre" LIKE '%Super%' AND "Poder"."Nombre" IN (
    SELECT "Nombre"
    FROM "Proyecto"."Posee"
    WHERE "Posee"."FormaObtencion" = 'Hereditario' AND "Posee"."Personaje" IN (
        SELECT "NombreCompleto"
        FROM "Proyecto"."Villano"
    )
    GROUP BY "Posee"."Poder"
    HAVING COUNT( "Posee"."Personaje" ) >= 2
);

-- 7. Lista de los 3 poderes más usados en combates y cuantas veces se han usado ordanos de manera descendiente
SELECT "Poder", COUNT(*) AS "Cantidad"
FROM "Proyecto"."ParticipaPod"
GROUP BY "Poder"
ORDER BY "Cantidad" DESC
LIMIT 3;

-- 8. Listar los conocidos civiles de todos los lideres con poderes no heredados
SELECT "Conoce".*, "Organizacion"."Nombre" AS "Organizacion"
FROM "Proyecto"."Conoce" JOIN "Proyecto"."Organizacion"
ON "Conoce"."Heroe" = "Organizacion"."Lider"
WHERE "Organizacion"."Lider" IN (
    SELECT "Personaje"
    FROM "Proyecto"."Posee" 
    WHERE "Posee"."FormaObtencion" != 'Hereditario'
);