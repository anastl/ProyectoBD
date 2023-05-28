-- Table: Proyecto Fase 2.Personaje

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Personaje";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Personaje"
(
    "NombreCompleto" character varying COLLATE pg_catalog."default" NOT NULL,
    "Sexo" character varying COLLATE pg_catalog."default",
    "ColorPelo" character varying COLLATE pg_catalog."default",
    "ColorOjos" character varying COLLATE pg_catalog."default",
    "EstadoMarital" character varying COLLATE pg_catalog."default",
    "PrimeraAparicion" date,
    "FraseCelebre" character varying COLLATE pg_catalog."default",
    "EsCivil" boolean,
    CONSTRAINT "Personaje_pkey" PRIMARY KEY ("NombreCompleto"),
    CONSTRAINT "Personaje_check" CHECK ('Personaje.Sexo'::text = ANY (ARRAY['F'::text, 'M'::text, 'Desc'::text, 'Otro'::text])),
    CONSTRAINT "Personaje_check1" CHECK ('Personaje.EstadoMarital'::text = ANY (ARRAY['Soltero'::text, 'Casado'::text, 'Viudo'::text, 'Divorciado'::text]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Personaje"
    OWNER to postgres;

-- Table: Proyecto Fase 2.PersonajeOcupaciones

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."PersonajeOcupaciones";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."PersonajeOcupaciones"
(
    "NombrePersonaje" character varying COLLATE pg_catalog."default" NOT NULL,
    "Ocupacion" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PersonajeOcupaciones_pkey" PRIMARY KEY ("NombrePersonaje", "Ocupacion"),
    CONSTRAINT "PersonajeOcupaciones_NombrePersonaje_fkey" FOREIGN KEY ("NombrePersonaje")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."PersonajeOcupaciones"
    OWNER to postgres;

-- Table: Proyecto Fase 2.PersonajeCreadores

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."PersonajeCreadores";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."PersonajeCreadores"
(
    "NombrePersonaje" character varying COLLATE pg_catalog."default" NOT NULL,
    "Creador" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PersonajeCreadores_pkey" PRIMARY KEY ("NombrePersonaje", "Creador"),
    CONSTRAINT "PersonajeCreadores_NombrePersonaje_fkey" FOREIGN KEY ("NombrePersonaje")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."PersonajeCreadores"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Heroe

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Heroe";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Heroe"
(
    "NombreCompleto" character varying COLLATE pg_catalog."default" NOT NULL,
    "NombreHeroe" character varying COLLATE pg_catalog."default",
    "ColoresTraje" character varying COLLATE pg_catalog."default",
    "Logotipo" character varying COLLATE pg_catalog."default",
    "Rival" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Heroe_pkey" PRIMARY KEY ("NombreCompleto"),
    CONSTRAINT "Heroe_NombreCompleto_fkey" FOREIGN KEY ("NombreCompleto")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Heroe_Rival_fkey" FOREIGN KEY ("Rival")
        REFERENCES "Proyecto Fase 2"."Villano" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Heroe"
    OWNER to postgres;

-- Trigger: heroe_check

-- DROP TRIGGER IF EXISTS heroe_check ON "Proyecto Fase 2"."Heroe";

CREATE TRIGGER heroe_check
    BEFORE INSERT OR UPDATE 
    ON "Proyecto Fase 2"."Heroe"
    FOR EACH ROW
    EXECUTE FUNCTION "Proyecto Fase 2".heroe_check();

-- Table: Proyecto Fase 2.Civil

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Civil";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Civil"
(
    "NombreCompleto" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Civil_pkey" PRIMARY KEY ("NombreCompleto"),
    CONSTRAINT "Civil_NombreCompleto_fkey" FOREIGN KEY ("NombreCompleto")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Civil"
    OWNER to postgres;

-- Trigger: civil_check

-- DROP TRIGGER IF EXISTS civil_check ON "Proyecto Fase 2"."Civil";

CREATE TRIGGER civil_check
    BEFORE INSERT OR UPDATE 
    ON "Proyecto Fase 2"."Civil"
    FOR EACH ROW
    EXECUTE FUNCTION "Proyecto Fase 2".civil_check();

-- Table: Proyecto Fase 2.Villano

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Villano";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Villano"
(
    "NombreCompleto" character varying COLLATE pg_catalog."default" NOT NULL,
    "NombreVillano" character varying COLLATE pg_catalog."default",
    "Objetivo" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Villano_pkey" PRIMARY KEY ("NombreCompleto")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Villano"
    OWNER to postgres;

-- Trigger: villano_check

-- DROP TRIGGER IF EXISTS villano_check ON "Proyecto Fase 2"."Villano";

CREATE TRIGGER villano_check
    BEFORE INSERT OR UPDATE 
    ON "Proyecto Fase 2"."Villano"
    FOR EACH ROW
    EXECUTE FUNCTION "Proyecto Fase 2".villano_check();

-- Table: Proyecto Fase 2.VillanoEnemigos

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."VillanoEnemigos";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."VillanoEnemigos"
(
    "Enemigo" character varying COLLATE pg_catalog."default" NOT NULL,
    "NombreCompleto" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "VillanoEnemigos_pkey" PRIMARY KEY ("Enemigo", "NombreCompleto"),
    CONSTRAINT "VillanoEnemigos_NombreCompleto_fkey" FOREIGN KEY ("NombreCompleto")
        REFERENCES "Proyecto Fase 2"."Villano" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."VillanoEnemigos"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Nacionalidad

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Nacionalidad";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Nacionalidad"
(
    "Pais" character varying COLLATE pg_catalog."default" NOT NULL,
    "Nombre" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Nacionalidad_pkey" PRIMARY KEY ("Pais")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Nacionalidad"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Organizacion

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Organizacion";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Organizacion"
(
    "Nombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "Slogan" character varying COLLATE pg_catalog."default",
    "Tipo" character varying COLLATE pg_catalog."default",
    "Objetivo" character varying COLLATE pg_catalog."default",
    "LugarCreacion" character varying COLLATE pg_catalog."default",
    "PrimeraAparicion" date,
    "Fundador" character varying COLLATE pg_catalog."default",
    "Lider" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Organizacion_pkey" PRIMARY KEY ("Nombre"),
    CONSTRAINT "Organizacion_Fundador_fkey" FOREIGN KEY ("Fundador")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "Organizacion_Lider_fkey" FOREIGN KEY ("Lider")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Organizacion"
    OWNER to postgres;    

-- Table: Proyecto Fase 2.Sede

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Sede";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Sede"
(
    "Nombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "Ubicacion" character varying COLLATE pg_catalog."default",
    "TipoEdificacion" character varying COLLATE pg_catalog."default",
    "NombreOrganizacion" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Sede_pkey" PRIMARY KEY ("NombreOrganizacion"),
    CONSTRAINT "Sede_NombreOrganizacion_fkey" FOREIGN KEY ("NombreOrganizacion")
        REFERENCES "Proyecto Fase 2"."Organizacion" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Sede"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Poder

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Poder";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Poder"
(
    "Nombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "Descripcion" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Poder_pkey" PRIMARY KEY ("Nombre")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Poder"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Objeto

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Objeto";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Objeto"
(
    "Nombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "MaterialFab" character varying COLLATE pg_catalog."default",
    "TipoObj" character varying COLLATE pg_catalog."default",
    "Descripcion" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Objeto_pkey" PRIMARY KEY ("Nombre")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Objeto"
    OWNER to postgres;

-- Table: Proyecto Fase 2.ObjetoCreadores

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."ObjetoCreadores";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."ObjetoCreadores"
(
    "ObjetoNombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "Creador" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "ObjetoCreadores_pkey" PRIMARY KEY ("ObjetoNombre", "Creador"),
    CONSTRAINT "ObjetoCreadores_ObjetoNombre_fkey" FOREIGN KEY ("ObjetoNombre")
        REFERENCES "Proyecto Fase 2"."Objeto" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."ObjetoCreadores"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Combate

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Combate";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Combate"
(
    "Fecha" date NOT NULL,
    "Lugar" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Combate_pkey" PRIMARY KEY ("Fecha", "Lugar")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Combate"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Medio

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Medio";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Medio"
(
    "Titulo" character varying COLLATE pg_catalog."default" NOT NULL,
    "CompaniaProd" character varying COLLATE pg_catalog."default",
    "Sinopsis" character varying COLLATE pg_catalog."default",
    "FechaEstr" date,
    "Rating" integer,
    CONSTRAINT "Medio_pkey" PRIMARY KEY ("Titulo"),
    CONSTRAINT "Medio_Rating_check" CHECK ("Rating" >= 1 AND "Rating" <= 5)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Medio"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Pelicula

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Pelicula";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Pelicula"
(
    "Titulo" character varying COLLATE pg_catalog."default" NOT NULL,
    "Director" character varying COLLATE pg_catalog."default",
    "Duracion" integer,
    "Distribuidor" character varying COLLATE pg_catalog."default",
    "TipoPelicula" character varying COLLATE pg_catalog."default",
    "CosteProd" real,
    "Ganancias" real,
    CONSTRAINT "Pelicula_pkey" PRIMARY KEY ("Titulo"),
    CONSTRAINT "Pelicula_Titulo_fkey" FOREIGN KEY ("Titulo")
        REFERENCES "Proyecto Fase 2"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Pelicula"
    OWNER to postgres;

-- Trigger: pelicula_check

-- DROP TRIGGER IF EXISTS pelicula_check ON "Proyecto Fase 2"."Pelicula";

CREATE TRIGGER pelicula_check
    BEFORE INSERT OR UPDATE 
    ON "Proyecto Fase 2"."Pelicula"
    FOR EACH ROW
    EXECUTE FUNCTION "Proyecto Fase 2".pelicula_check();

-- Table: Proyecto Fase 2.Serie

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Serie";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Serie"
(
    "Titulo" character varying COLLATE pg_catalog."default" NOT NULL,
    "Creador" character varying COLLATE pg_catalog."default",
    "CanalTrans" character varying COLLATE pg_catalog."default",
    "Tipo" character varying COLLATE pg_catalog."default",
    "TotalEpi" integer,
    CONSTRAINT "Serie_pkey" PRIMARY KEY ("Titulo"),
    CONSTRAINT "Serie_Titulo_fkey" FOREIGN KEY ("Titulo")
        REFERENCES "Proyecto Fase 2"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Serie"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Videojuego

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Videojuego";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Videojuego"
(
    "Titulo" character varying COLLATE pg_catalog."default" NOT NULL,
    "TipoJuego" character varying COLLATE pg_catalog."default",
    "CompanniaPub" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Videojuego_pkey" PRIMARY KEY ("Titulo"),
    CONSTRAINT "Videojuego_Titulo_fkey" FOREIGN KEY ("Titulo")
        REFERENCES "Proyecto Fase 2"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Videojuego"
    OWNER to postgres;

-- Table: Proyecto Fase 2.VideojuegoPlataformas

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."VideojuegoPlataformas";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."VideojuegoPlataformas"
(
    "Titulo" character varying COLLATE pg_catalog."default" NOT NULL,
    "Plataforma" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "VideojuegoPlataformas_pkey" PRIMARY KEY ("Titulo", "Plataforma"),
    CONSTRAINT "VideojuegoPlataformas_Titulo_fkey" FOREIGN KEY ("Titulo")
        REFERENCES "Proyecto Fase 2"."Videojuego" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."VideojuegoPlataformas"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Conoce

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Conoce";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Conoce"
(
    "Civil" character varying COLLATE pg_catalog."default" NOT NULL,
    "Heroe" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Conoce_pkey" PRIMARY KEY ("Civil", "Heroe"),
    CONSTRAINT "Conoce_Civil_fkey" FOREIGN KEY ("Civil")
        REFERENCES "Proyecto Fase 2"."Civil" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Conoce_Heroe_fkey" FOREIGN KEY ("Heroe")
        REFERENCES "Proyecto Fase 2"."Heroe" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Conoce"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Trata

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Trata";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Trata"
(
    "NombreVillano" character varying COLLATE pg_catalog."default" NOT NULL,
    "NombreCivil" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Trata_pkey" PRIMARY KEY ("NombreVillano", "NombreCivil"),
    CONSTRAINT "Trata_NombreCivil_fkey" FOREIGN KEY ("NombreCivil")
        REFERENCES "Proyecto Fase 2"."Civil" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Trata_NombreVillano_fkey" FOREIGN KEY ("NombreVillano")
        REFERENCES "Proyecto Fase 2"."Villano" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Trata"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Aparece

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Aparece";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Aparece"
(
    "Personaje" character varying COLLATE pg_catalog."default" NOT NULL,
    "Medio" character varying COLLATE pg_catalog."default" NOT NULL,
    "NombreActor" character varying COLLATE pg_catalog."default",
    "TipoActor" character varying COLLATE pg_catalog."default",
    "Rol" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Aparece_pkey" PRIMARY KEY ("Personaje", "Medio"),
    CONSTRAINT "Aparece_Medio_fkey" FOREIGN KEY ("Medio")
        REFERENCES "Proyecto Fase 2"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Aparece_Personaje_fkey" FOREIGN KEY ("Personaje")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Aparece_TipoActor_check" CHECK ("TipoActor"::text = ANY (ARRAY['Interpreta'::character varying, 'Presta su voz'::character varying]::text[])),
    CONSTRAINT "Aparece_Rol_check" CHECK ("Rol"::text = ANY (ARRAY['Protagonista'::character varying, 'Antagonista'::character varying, 'Secundario'::character varying]::text[]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Aparece"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Interviene

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Interviene";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Interviene"
(
    "Organizacion" character varying COLLATE pg_catalog."default" NOT NULL,
    "Medio" character varying COLLATE pg_catalog."default" NOT NULL,
    "Rol" character varying COLLATE pg_catalog."default",
    "EstadoFinal" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Interviene_pkey" PRIMARY KEY ("Organizacion", "Medio"),
    CONSTRAINT "Interviene_Medio_fkey" FOREIGN KEY ("Medio")
        REFERENCES "Proyecto Fase 2"."Medio" ("Titulo") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Interviene_Organizacion_fkey" FOREIGN KEY ("Organizacion")
        REFERENCES "Proyecto Fase 2"."Organizacion" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Interviene_Rol_check" CHECK ("Rol"::text = ANY (ARRAY['Protagonista'::character varying, 'Enemiga'::character varying, 'Secundario'::character varying]::text[]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Interviene"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Tiene

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Tiene";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Tiene"
(
    "NombreCompleto" character varying COLLATE pg_catalog."default" NOT NULL,
    "Nacionalidad" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Tiene_pkey" PRIMARY KEY ("NombreCompleto", "Nacionalidad"),
    CONSTRAINT "Tiene_Nacionalidad_fkey" FOREIGN KEY ("Nacionalidad")
        REFERENCES "Proyecto Fase 2"."Nacionalidad" ("Pais") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Tiene_NombreCompleto_fkey" FOREIGN KEY ("NombreCompleto")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Tiene"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Pertenece

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Pertenece";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Pertenece"
(
    "Nombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "Organizacion" character varying COLLATE pg_catalog."default" NOT NULL,
    "Cargo" character varying COLLATE pg_catalog."default" NOT NULL,
    "Fecha" date NOT NULL,
    CONSTRAINT "Pertenece_pkey" PRIMARY KEY ("Nombre", "Organizacion", "Cargo", "Fecha"),
    CONSTRAINT "Pertenece_Nombre_fkey" FOREIGN KEY ("Nombre")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Pertenece_Organizacion_fkey" FOREIGN KEY ("Organizacion")
        REFERENCES "Proyecto Fase 2"."Organizacion" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Pertenece"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Porta

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Porta";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Porta"
(
    "Nombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "Objeto" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Porta_pkey" PRIMARY KEY ("Nombre", "Objeto"),
    CONSTRAINT "Porta_Nombre_fkey" FOREIGN KEY ("Nombre")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Porta_Objeto_fkey" FOREIGN KEY ("Objeto")
        REFERENCES "Proyecto Fase 2"."Objeto" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Porta"
    OWNER to postgres;

-- Table: Proyecto Fase 2.Posee

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."Posee";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."Posee"
(
    "Personaje" character varying COLLATE pg_catalog."default" NOT NULL,
    "Poder" character varying COLLATE pg_catalog."default" NOT NULL,
    "FormaObtencion" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Posee_pkey" PRIMARY KEY ("Personaje", "Poder"),
    CONSTRAINT "Posee_Personaje_fkey" FOREIGN KEY ("Personaje")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Posee_Poder_fkey" FOREIGN KEY ("Poder")
        REFERENCES "Proyecto Fase 2"."Poder" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Posee_FormaObtencion_check" CHECK ("FormaObtencion"::text = ANY (ARRAY['Hereditario'::character varying, 'Artificial'::character varying, 'Natural'::character varying]::text[]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."Posee"
    OWNER to postgres;

-- Table: Proyecto Fase 2.ParticipaObj

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."ParticipaObj";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."ParticipaObj"
(
    "Nombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "CombateFecha" date NOT NULL,
    "Objeto" character varying COLLATE pg_catalog."default" NOT NULL,
    "CombateLugar" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "ParticipaObj_pkey" PRIMARY KEY ("Nombre", "CombateFecha", "Objeto", "CombateLugar"),
    CONSTRAINT "ParticipaObj_CombateFecha_CombateLugar_fkey" FOREIGN KEY ("CombateFecha", "CombateLugar")
        REFERENCES "Proyecto Fase 2"."Combate" ("Fecha", "Lugar") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ParticipaObj_Nombre_fkey" FOREIGN KEY ("Nombre")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ParticipaObj_Objeto_fkey" FOREIGN KEY ("Objeto")
        REFERENCES "Proyecto Fase 2"."Objeto" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."ParticipaObj"
    OWNER to postgres;

-- Table: Proyecto Fase 2.ParticipaPod

-- DROP TABLE IF EXISTS "Proyecto Fase 2"."ParticipaPod";

CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."ParticipaPod"
(
    "Nombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "Poder" character varying COLLATE pg_catalog."default" NOT NULL,
    "CombateFecha" date NOT NULL,
    "CombateLugar" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "ParticipaPod_pkey" PRIMARY KEY ("Nombre", "Poder", "CombateFecha", "CombateLugar"),
    CONSTRAINT "ParticipaPod_CombateFecha_CombateLugar_fkey" FOREIGN KEY ("CombateFecha", "CombateLugar")
        REFERENCES "Proyecto Fase 2"."Combate" ("Fecha", "Lugar") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ParticipaPod_Nombre_fkey" FOREIGN KEY ("Nombre")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "ParticipaPod_Poder_fkey" FOREIGN KEY ("Poder")
        REFERENCES "Proyecto Fase 2"."Poder" ("Nombre") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Proyecto Fase 2"."ParticipaPod"
    OWNER to postgres;