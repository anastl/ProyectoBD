-- Nombre de superhéroe o supervillano que poseen poderes artificiales y que han sido líderes
SELECT "Personaje"."NombreCompleto"
FROM "Proyecto Fase 2"."Personaje"
WHERE "Personaje"."NombreCompleto" IN (
    SELECT "Personaje"
    FROM "Proyecto Fase 2"."Posee"
    WHERE "Posee"."FormaObtencion" = 'Artificial'
) AND "Personaje"."EsCivil" = FALSE AND "Personaje"."NombreCompleto" IN (
    SELECT "Lider"
    FROM "Proyecto Fase 2"."Organizacion"
)

SELECT "Personaje"."NombreCompleto"
FROM "Proyecto Fase 2"."Personaje"
WHERE "Personaje"."NombreCompleto" IN (
	SELECT "Posee"."Personaje"
	FROM "Proyecto Fase 2"."Posee"
	WHERE "Posee"."FormaObtencion" = 'Artificial') 
AND "NombreCompleto" IN (
	SELECT "Organizacion"."Nombre"
	FROM "Proyecto Fase 2"."Organizacion"
	WHERE "Organizacion"."Lider" IS NOT NULL);

-- Series que han tenido más episodios que el promedio
SELECT "Serie"."Titulo"
FROM "Proyecto Fase 2"."Serie"
WHERE "Serie"."TotalEpi" > (
    SELECT AVG( "Serie"."TotalEpi" )
    FROM "Proyecto Fase 2"."Serie"
);

-- Los 5 objetos más usados por héroes o villanos
SELECT "Objeto"."Nombre"
FROM "Proyecto Fase 2"."Porta"
JOIN "Proyecto Fase 2"."Personaje" ON "Porta"."Nombre" = "Personaje"."NombreCompleto"
JOIN "Proyecto Fase 2"."Objeto" ON "Porta"."Objeto" = "Objeto"."Nombre"
WHERE "Personaje"."EsCivil" = false
GROUP BY "Objeto"."Nombre"
ORDER BY COUNT("Objeto"."Nombre") DESC
LIMIT 5;

-- Muestre las 3 locaciones donde se han desarrollado más combates
SELECT "Combate"."Lugar"
FROM "Proyecto Fase 2"."Combate"
GROUP BY "Combate"."Lugar"
ORDER BY COUNT( "Combate"."Lugar" ) DESC
LIMIT 3;

-- Imprima las películas que tengan más de 2 horas y media de duración, sean de tipo animada, cuya ganancia sea mayor al promedio de todas las películas del mismo tipo, ordenadas cronológicamente por el costo de producción
SELECT "Titulo"
FROM "Proyecto Fase 2"."Pelicula"
WHERE "Duracion" > 150 AND "TipoPelicula" = 'Animada' AND "Ganancias" > (
	SELECT AVG("Ganancias") 
	FROM "Proyecto Fase 2"."Pelicula" 
	WHERE "TipoPelicula" = 'Animada')
ORDER BY "CosteProd" ASC;

-- Liste toda la información de los poderes que son heredados y que tengan en su nombre la cadena “Super”. Además, dicho poder lo deben tener al menos 2 villanos
SELECT *
FROM "Proyecto Fase 2"."Poder"
WHERE "Poder"."Nombre" LIKE '%Super%' AND "Poder"."Nombre" IN (
    SELECT "Nombre"
    FROM "Proyecto Fase 2"."Posee"
    WHERE "Posee"."FormaObtencion" = 'Hereditario' AND "Posee"."Personaje" IN (
        SELECT "NombreCompleto"
        FROM "Proyecto Fase 2"."Villano"
    )
    GROUP BY "Posee"."Poder"
    HAVING COUNT( "Posee"."Personaje" ) >= 2
);

-- Lista de los 3 poderes más usados en combates y cuantas veces se han usado
SELECT "Poder", COUNT(*) AS "Cantidad"
FROM "Proyecto Fase 2"."ParticipaPod"
GROUP BY "Poder"
ORDER BY "Cantidad" DESC
LIMIT 3;

-- Listar los conocidos civiles de todos los lideres
SELECT "Conoce".*, "Organizacion"."Nombre" AS "Organizacion"
FROM "Proyecto Fase 2"."Conoce" JOIN "Proyecto Fase 2"."Organizacion"
ON "Conoce"."Heroe" = "Organizacion"."Lider";