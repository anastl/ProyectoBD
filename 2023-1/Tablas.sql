-- SCHEMA: Proyecto Fase 2
-- DROP SCHEMA IF EXISTS "Proyecto Fase 2" ;
CREATE SCHEMA IF NOT EXISTS "Proyecto Fase 2"
    AUTHORIZATION postgres;

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

-- Table: Proyecto Fase 2.EnemigosVillano
-- DROP TABLE IF EXISTS "Proyecto Fase 2"."EnemigosVillano";
CREATE TABLE IF NOT EXISTS "Proyecto Fase 2"."EnemigosVillano"
(
    "VillanoNombre" character varying COLLATE pg_catalog."default" NOT NULL,
    "Enemigo" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "EnemigosVillano_pkey" PRIMARY KEY ("VillanoNombre", "Enemigo"),
    CONSTRAINT "EnemigosVillano_VillanoNombre_fkey" FOREIGN KEY ("VillanoNombre")
        REFERENCES "Proyecto Fase 2"."Personaje" ("NombreCompleto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS "Proyecto Fase 2"."EnemigosVillano"
    OWNER to postgres;

