CREATE OR REPLACE FUNCTION "Proyecto Fase 2".heroe_check()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
		SELECT 1 
		FROM "Civil" 
		WHERE "Civil"."NombreCompleto" = NEW.NombreCompleto) 
	OR EXISTS (
		SELECT 1 
		FROM "Villano" 
		WHERE "Villano"."NombreCompleto" = NEW.NombreCompleto) 
	THEN
        RAISE EXCEPTION 'El valor de NombreCompleto ya existe en las tablas Civil o Villano';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER heroe_check
BEFORE INSERT OR UPDATE ON "Proyecto Fase 2"."Heroe"
FOR EACH ROW EXECUTE FUNCTION "Proyecto Fase 2".heroe_check();

CREATE OR REPLACE FUNCTION "Proyecto Fase 2".civil_check() 
RETURNS TRIGGER AS $$ 
BEGIN 
    IF EXISTS ( 
        SELECT 1 
        FROM "Heroe" 
        WHERE "Heroe"."NombreCompleto" = NEW.NombreCompleto) 
    OR EXISTS ( 
        SELECT 1 
        FROM "Villano" 
        WHERE "Villano"."NombreCompleto" = NEW.NombreCompleto) 
    THEN RAISE EXCEPTION 'El valor de NombreCompleto ya existe en las tablas Heroe o Villano'; 
    END IF; 
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 
CREATE TRIGGER civil_check 
BEFORE INSERT OR UPDATE ON "Proyecto Fase 2"."Civil" 
FOR EACH ROW EXECUTE FUNCTION "Proyecto Fase 2".civil_check();

CREATE OR REPLACE FUNCTION "Proyecto Fase 2".villano_check()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
		SELECT 1 
		FROM "Civil" 
		WHERE "Civil"."NombreCompleto" = NEW.NombreCompleto) 
	OR EXISTS (
		SELECT 1 
		FROM "Heroe" 
		WHERE "Heroe"."NombreCompleto" = NEW.NombreCompleto) 
	THEN
        RAISE EXCEPTION 'El valor de NombreCompleto ya existe en las tablas Civil o Heroe';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER villano_check
BEFORE INSERT OR UPDATE ON "Proyecto Fase 2"."Villano"
FOR EACH ROW EXECUTE FUNCTION "Proyecto Fase 2".villano_check();

CREATE OR REPLACE FUNCTION "Proyecto Fase 2".pelicula_check()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.CosteProd > NEW.Ganancias THEN
        RAISE EXCEPTION 'El valor de CosteProd es mayor que el valor de Ganancias';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER pelicula_check
BEFORE INSERT OR UPDATE ON "Proyecto Fase 2"."Pelicula"
FOR EACH ROW EXECUTE FUNCTION "Proyecto Fase 2".pelicula_check();

SELECT "Personaje"."NombreCompleto"
FROM "Proyecto Fase 2"."Personaje"
WHERE "Personaje"."NombreCompleto" IN (
	SELECT "Posee"."Personaje"
	FROM "Proyecto Fase 2"."Posee"
	WHERE "Posee"."FormaObtencion" = 'Artificial') 
AND "NombreCompleto" IN (
	SELECT "Organizacion"."Nombre"
	FROM "Proyecto Fase 2"."Organizacion"
	WHERE "Organizacion"."Lider" IS NOT NULL)

Series que han tenido más episodios que el promedio