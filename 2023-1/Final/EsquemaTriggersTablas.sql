CREATE SCHEMA IF NOT EXISTS "Proyecto";

CREATE OR REPLACE FUNCTION "Proyecto".civil_check()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    IF EXISTS (
		SELECT 1 
		FROM "Proyecto"."Personaje" 
		WHERE "Personaje"."EsCivil" = FALSE AND NEW."NombreCompleto" = "Personaje"."NombreCompleto") 
	THEN
        RAISE EXCEPTION 'El valor de NombreCompleto no es civil';
    END IF;
    RETURN NEW;
END;
$BODY$;

CREATE OR REPLACE FUNCTION "Proyecto".heroe_check()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    IF EXISTS (
		SELECT 1 
		FROM "Proyecto"."Civil" 
		WHERE "Civil"."NombreCompleto" = NEW."NombreCompleto") 
	OR EXISTS (
		SELECT 1 
		FROM "Proyecto"."Villano" 
		WHERE "Villano"."NombreCompleto" = NEW."NombreCompleto") 
	THEN
        RAISE EXCEPTION 'El valor de NombreCompleto ya existe en las tablas Civil o Villano';
    END IF;
    RETURN NEW;
END;
$BODY$;

CREATE OR REPLACE FUNCTION "Proyecto".pelicula_check()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    IF NEW."CosteProd" > NEW."Ganancias" THEN
        RAISE EXCEPTION 'El valor de CosteProd es mayor que el valor de Ganancias';
    END IF;
    RETURN NEW;
END;
$BODY$;

CREATE OR REPLACE FUNCTION "Proyecto".villano_check()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    IF EXISTS (
		SELECT 1 
		FROM "Proyecto"."Civil" 
		WHERE "Civil"."NombreCompleto" = NEW."NombreCompleto")  
	OR EXISTS (
		SELECT 1 
		FROM "Proyecto"."Heroe" 
		WHERE "Heroe"."NombreCompleto" = NEW."NombreCompleto") 
	THEN
        RAISE EXCEPTION 'El valor de NombreCompleto ya existe en las tablas Civil o Heroe';
    END IF;
    RETURN NEW;
END;
$BODY$;


CREATE TABLE IF NOT EXISTS "Proyecto"."Personaje"
(
    "NombreCompleto" character varying(512) NOT NULL,
    "Sexo" character varying(512),
    "ColorPelo" character varying(512),
    "ColorOjos" character varying(512),
    "EstadoMarital" character varying(512),
    "PrimeraAparicion" date,
    "FraseCelebre" character varying(512),
    "EsCivil" boolean,
    CONSTRAINT "Personaje_pkey" PRIMARY KEY ("NombreCompleto"),
    CONSTRAINT "Personaje_check_EstadoMarital" CHECK ("EstadoMarital" = ANY (ARRAY['Soltero', 'Casado', 'Viudo', 'Divorciado'])),
    CONSTRAINT "Personaje_check_Sexo" CHECK ("Sexo" = ANY (ARRAY['F', 'M', 'Desc', 'Otro']))
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Civil"
(
    "NombreCompleto" character varying(512) NOT NULL,
    CONSTRAINT "Civil_pkey" PRIMARY KEY ("NombreCompleto"),
    CONSTRAINT "Civil_NombreCompleto_fkey" FOREIGN KEY ("NombreCompleto")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
CREATE TRIGGER civil_check
    BEFORE INSERT OR UPDATE 
    ON "Proyecto"."Civil"
    FOR EACH ROW
    EXECUTE FUNCTION "Proyecto".civil_check();

CREATE TABLE IF NOT EXISTS "Proyecto"."Heroe"
(
    "NombreCompleto" character varying(512)  NOT NULL,
    "NombreHeroe" character varying(512) ,
    "Logotipo" character varying(512) ,
    "Rival" character varying(512) ,
    CONSTRAINT "Heroe_pkey" PRIMARY KEY ("NombreCompleto"),
    CONSTRAINT "Heroe_NombreCompleto_fkey" FOREIGN KEY ("NombreCompleto")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Heroe_Rival_fkey" FOREIGN KEY ("Rival")
        REFERENCES "Proyecto"."Villano" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
CREATE TRIGGER heroe_check
    BEFORE INSERT OR UPDATE 
    ON "Proyecto"."Heroe"
    FOR EACH ROW
    EXECUTE FUNCTION "Proyecto".heroe_check();

CREATE TABLE IF NOT EXISTS "Proyecto"."Villano"
(
    "NombreCompleto" character varying(512)  NOT NULL,
    "NombreVillano" character varying(512) ,
    "Objetivo" character varying(512) ,
    CONSTRAINT "Villano_pkey" PRIMARY KEY ("NombreCompleto")
)
CREATE TRIGGER villano_check
    BEFORE INSERT OR UPDATE 
    ON "Proyecto"."Villano"
    FOR EACH ROW
    EXECUTE FUNCTION "Proyecto".villano_check();    

CREATE TABLE IF NOT EXISTS "Proyecto"."ColoresTraje"
(
    "Heroe" character varying(512)  NOT NULL,
    "ColorTraje" character varying(512)  NOT NULL,
    CONSTRAINT "ColoresTraje_pkey" PRIMARY KEY ("Heroe", "ColorTraje"),
    CONSTRAINT "ColoresTraje_Heroe_fkey" FOREIGN KEY ("Heroe")
        REFERENCES "Proyecto"."Heroe" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."PersonajeCreadores"
(
    "NombrePersonaje" character varying(512)  NOT NULL,
    "Creador" character varying(512)  NOT NULL,
    CONSTRAINT "PersonajeCreadores_pkey" PRIMARY KEY ("NombrePersonaje", "Creador"),
    CONSTRAINT "PersonajeCreadores_NombrePersonaje_fkey" FOREIGN KEY ("NombrePersonaje")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."PersonajeOcupaciones"
(
    "NombrePersonaje" character varying(512)  NOT NULL,
    "Ocupacion" character varying(512)  NOT NULL,
    CONSTRAINT "PersonajeOcupaciones_pkey" PRIMARY KEY ("NombrePersonaje", "Ocupacion"),
    CONSTRAINT "PersonajeOcupaciones_NombrePersonaje_fkey" FOREIGN KEY ("NombrePersonaje")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."VillanoEnemigos"
(
    "Enemigo" character varying(512)  NOT NULL,
    "NombreCompleto" character varying(512)  NOT NULL,
    CONSTRAINT "VillanoEnemigos_pkey" PRIMARY KEY ("Enemigo", "NombreCompleto"),
    CONSTRAINT "VillanoEnemigos_NombreCompleto_fkey" FOREIGN KEY ("NombreCompleto")
        REFERENCES "Proyecto"."Villano" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Poder"
(
    "Nombre" character varying(512)  NOT NULL,
    "Descripcion" character varying(512) ,
    CONSTRAINT "Poder_pkey" PRIMARY KEY ("Nombre")
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Objeto"
(
    "Nombre" character varying(512)  NOT NULL,
    "MaterialFab" character varying(512) ,
    "TipoObj" character varying(512) ,
    "Descripcion" character varying(512) ,
    CONSTRAINT "Objeto_pkey" PRIMARY KEY ("Nombre")
);

CREATE TABLE IF NOT EXISTS "Proyecto"."ObjetoCreadores"
(
    "ObjetoNombre" character varying(512)  NOT NULL,
    "Creador" character varying(512)  NOT NULL,
    CONSTRAINT "ObjetoCreadores_pkey" PRIMARY KEY ("ObjetoNombre", "Creador"),
    CONSTRAINT "ObjetoCreadores_ObjetoNombre_fkey" FOREIGN KEY ("ObjetoNombre")
        REFERENCES "Proyecto"."Objeto" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Organizacion"
(
    "Nombre" character varying(512)  NOT NULL,
    "Slogan" character varying(512) ,
    "Tipo" character varying(512) ,
    "Objetivo" character varying(512) ,
    "LugarCreacion" character varying(512) ,
    "PrimeraAparicion" date,
    "Fundador" character varying(512)  NOT NULL,
    "Lider" character varying(512)  NOT NULL,
    CONSTRAINT "Organizacion_pkey" PRIMARY KEY ("Nombre"),
    CONSTRAINT "Organizacion_Fundador_fkey" FOREIGN KEY ("Fundador")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "Organizacion_Lider_fkey" FOREIGN KEY ("Lider")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Sede"
(
    "Nombre" character varying(512)  NOT NULL,
    "Ubicacion" character varying(512) ,
    "TipoEdificacion" character varying(512) ,
    "NombreOrganizacion" character varying(512)  NOT NULL,
    CONSTRAINT "Sede_pkey" PRIMARY KEY ("NombreOrganizacion"),
    CONSTRAINT "Sede_NombreOrganizacion_fkey" FOREIGN KEY ("NombreOrganizacion")
        REFERENCES "Proyecto"."Organizacion" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Medio"
(
    "Titulo" character varying(512)  NOT NULL,
    "CompaniaProd" character varying(512) ,
    "Sinopsis" character varying(512) ,
    "FechaEstr" date,
    "Rating" integer,
    CONSTRAINT "Medio_pkey" PRIMARY KEY ("Titulo"),
    CONSTRAINT "Medio_Rating_check" CHECK ("Rating" >= 1 AND "Rating" <= 5)
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Pelicula"
(
    "Titulo" character varying(512)  NOT NULL,
    "Director" character varying(512) ,
    "Duracion" integer,
    "Distribuidor" character varying(512) ,
    "TipoPelicula" character varying(512) ,
    "CosteProd" real,
    "Ganancias" real,
    CONSTRAINT "Pelicula_pkey" PRIMARY KEY ("Titulo"),
    CONSTRAINT "Pelicula_Titulo_fkey" FOREIGN KEY ("Titulo")
        REFERENCES "Proyecto"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
CREATE TRIGGER pelicula_check
    BEFORE INSERT OR UPDATE 
    ON "Proyecto"."Pelicula"
    FOR EACH ROW
    EXECUTE FUNCTION "Proyecto".pelicula_check();

CREATE TABLE IF NOT EXISTS "Proyecto"."Serie"
(
    "Titulo" character varying(512)  NOT NULL,
    "Creador" character varying(512) ,
    "CanalTrans" character varying(512) ,
    "Tipo" character varying(512) ,
    "TotalEpi" integer,
    CONSTRAINT "Serie_pkey" PRIMARY KEY ("Titulo"),
    CONSTRAINT "Serie_Titulo_fkey" FOREIGN KEY ("Titulo")
        REFERENCES "Proyecto"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Videojuego"
(
    "Titulo" character varying(512)  NOT NULL,
    "TipoJuego" character varying(512) ,
    "CompanniaPub" character varying(512) ,
    CONSTRAINT "Videojuego_pkey" PRIMARY KEY ("Titulo"),
    CONSTRAINT "Videojuego_Titulo_fkey" FOREIGN KEY ("Titulo")
        REFERENCES "Proyecto"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."VideojuegoPlataformas"
(
    "Titulo" character varying(512)  NOT NULL,
    "Plataforma" character varying(512)  NOT NULL,
    CONSTRAINT "VideojuegoPlataformas_pkey" PRIMARY KEY ("Titulo", "Plataforma"),
    CONSTRAINT "VideojuegoPlataformas_Titulo_fkey" FOREIGN KEY ("Titulo")
        REFERENCES "Proyecto"."Videojuego" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Combate"
(
    "Fecha" date NOT NULL,
    "Lugar" character varying(512)  NOT NULL,
    CONSTRAINT "Combate_pkey" PRIMARY KEY ("Fecha", "Lugar")
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Conoce"
(
    "Civil" character varying(512)  NOT NULL,
    "Heroe" character varying(512)  NOT NULL,
    CONSTRAINT "Conoce_pkey" PRIMARY KEY ("Civil", "Heroe"),
    CONSTRAINT "Conoce_Civil_fkey" FOREIGN KEY ("Civil")
        REFERENCES "Proyecto"."Civil" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Conoce_Heroe_fkey" FOREIGN KEY ("Heroe")
        REFERENCES "Proyecto"."Heroe" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Aparece"
(
    "Personaje" character varying(512)  NOT NULL,
    "Medio" character varying(512)  NOT NULL,
    "NombreActor" character varying(512) ,
    "TipoActor" character varying(512) ,
    "Rol" character varying(512) ,
    CONSTRAINT "Aparece_pkey" PRIMARY KEY ("Personaje", "Medio"),
    CONSTRAINT "Aparece_Medio_fkey" FOREIGN KEY ("Medio")
        REFERENCES "Proyecto"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Aparece_Personaje_fkey" FOREIGN KEY ("Personaje")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Aparece_TipoActor_check" CHECK ("TipoActor" = ANY (ARRAY['Interpreta', 'Presta su voz'])),
    CONSTRAINT "Aparece_Rol_check" CHECK ("Rol" = ANY (ARRAY['Protagonista', 'Antagonista', 'Secundario']))
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Interviene"
(
    "Organizacion" character varying(512)  NOT NULL,
    "Medio" character varying(512)  NOT NULL,
    "Rol" character varying(512) ,
    "EstadoFinal" character varying(512) ,
    CONSTRAINT "Interviene_pkey" PRIMARY KEY ("Organizacion", "Medio"),
    CONSTRAINT "Interviene_Medio_fkey" FOREIGN KEY ("Medio")
        REFERENCES "Proyecto"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Interviene_Organizacion_fkey" FOREIGN KEY ("Organizacion")
        REFERENCES "Proyecto"."Organizacion" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Interviene_Rol_check" CHECK ("Rol" = ANY (ARRAY['Protagonista', 'Enemiga', 'Secundario']))
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Nacionalidad"
(
    "Pais" character varying(512)  NOT NULL,
    "Nombre" character varying(512) ,
    CONSTRAINT "Nacionalidad_pkey" PRIMARY KEY ("Pais")
);

CREATE TABLE IF NOT EXISTS "Proyecto"."ParticipaObj"
(
    "Nombre" character varying(512)  NOT NULL,
    "CombateFecha" date NOT NULL,
    "Objeto" character varying(512)  NOT NULL,
    "CombateLugar" character varying(512)  NOT NULL,
    CONSTRAINT "ParticipaObj_pkey" PRIMARY KEY ("Nombre", "CombateFecha", "Objeto", "CombateLugar"),
    CONSTRAINT "ParticipaObj_CombateFecha_CombateLugar_fkey" FOREIGN KEY ("CombateFecha", "CombateLugar")
        REFERENCES "Proyecto"."Combate" ("Fecha", "Lugar") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ParticipaObj_Nombre_fkey" FOREIGN KEY ("Nombre")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ParticipaObj_Objeto_fkey" FOREIGN KEY ("Objeto")
        REFERENCES "Proyecto"."Objeto" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."ParticipaPod"
(
    "Nombre" character varying(512)  NOT NULL,
    "Poder" character varying(512)  NOT NULL,
    "CombateFecha" date NOT NULL,
    "CombateLugar" character varying(512)  NOT NULL,
    CONSTRAINT "ParticipaPod_pkey" PRIMARY KEY ("Nombre", "Poder", "CombateFecha", "CombateLugar"),
    CONSTRAINT "ParticipaPod_CombateFecha_CombateLugar_fkey" FOREIGN KEY ("CombateFecha", "CombateLugar")
        REFERENCES "Proyecto"."Combate" ("Fecha", "Lugar") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ParticipaPod_Nombre_fkey" FOREIGN KEY ("Nombre")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ParticipaPod_Poder_fkey" FOREIGN KEY ("Poder")
        REFERENCES "Proyecto"."Poder" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Pertenece"
(
    "Nombre" character varying(512)  NOT NULL,
    "Organizacion" character varying(512)  NOT NULL,
    "Cargo" character varying(512)  NOT NULL,
    "Fecha" date NOT NULL,
    CONSTRAINT "Pertenece_pkey" PRIMARY KEY ("Nombre", "Organizacion", "Cargo", "Fecha"),
    CONSTRAINT "Pertenece_Nombre_fkey" FOREIGN KEY ("Nombre")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Pertenece_Organizacion_fkey" FOREIGN KEY ("Organizacion")
        REFERENCES "Proyecto"."Organizacion" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Porta"
(
    "Nombre" character varying(512)  NOT NULL,
    "Objeto" character varying(512)  NOT NULL,
    CONSTRAINT "Porta_pkey" PRIMARY KEY ("Nombre", "Objeto"),
    CONSTRAINT "Porta_Nombre_fkey" FOREIGN KEY ("Nombre")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Porta_Objeto_fkey" FOREIGN KEY ("Objeto")
        REFERENCES "Proyecto"."Objeto" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Posee"
(
    "Personaje" character varying(512)  NOT NULL,
    "Poder" character varying(512)  NOT NULL,
    "FormaObtencion" character varying(512) ,
    CONSTRAINT "Posee_pkey" PRIMARY KEY ("Personaje", "Poder"),
    CONSTRAINT "Posee_Personaje_fkey" FOREIGN KEY ("Personaje")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Posee_Poder_fkey" FOREIGN KEY ("Poder")
        REFERENCES "Proyecto"."Poder" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Posee_FormaObtencion_check" CHECK ("FormaObtencion" = ANY (ARRAY['Hereditario', 'Artificial', 'Natural']))
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Tiene"
(
    "NombreCompleto" character varying(512)  NOT NULL,
    "Nacionalidad" character varying(512)  NOT NULL,
    CONSTRAINT "Tiene_pkey" PRIMARY KEY ("NombreCompleto", "Nacionalidad"),
    CONSTRAINT "Tiene_Nacionalidad_fkey" FOREIGN KEY ("Nacionalidad")
        REFERENCES "Proyecto"."Nacionalidad" ("Pais") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Tiene_NombreCompleto_fkey" FOREIGN KEY ("NombreCompleto")
        REFERENCES "Proyecto"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Proyecto"."Trata"
(
    "NombreVillano" character varying(512)  NOT NULL,
    "NombreCivil" character varying(512)  NOT NULL,
    CONSTRAINT "Trata_pkey" PRIMARY KEY ("NombreVillano", "NombreCivil"),
    CONSTRAINT "Trata_NombreCivil_fkey" FOREIGN KEY ("NombreCivil")
        REFERENCES "Proyecto"."Civil" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Trata_NombreVillano_fkey" FOREIGN KEY ("NombreVillano")
        REFERENCES "Proyecto"."Villano" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);