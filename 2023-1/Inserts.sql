INSERT INTO "Proyecto Fase 2"."Personaje" (
    "NombreCompleto", 
    "FraseCelebre", 
    "Sexo", 
    "ColorPelo", 
    "ColorOjos", 
    "EstadoMarital", 
    "PrimeraAparicion", 
    "EsCivil")

INSERT INTO "Proyecto Fase 2"."PersonajeOcupaciones" (
    "NombrePersonaje",
    "Ocupacion"
)

INSERT INTO "Proyecto Fase 2"."PersonajeCreadores"
(
    "NombrePersonaje",
    "Creador"
)

INSERT INTO "Proyecto Fase 2"."Heroe"
(
    "NombreCompleto",
    "NombreHeroe",
    "ColoresTraje",
    "Logotipo",
    "Rival"
)

INSERT INTO "Proyecto Fase 2"."Civil"
(
    "NombreCompleto"
)

INSERT INTO "Proyecto Fase 2"."Villano"
(
    "NombreCompleto",
    "NombreVillano",
    "Objetivo"
)

INSERT INTO "Proyecto Fase 2"."VillanoEnemigos"
(
    "Enemigo",
    "NombreCompleto"
)

INSERT INTO "Proyecto Fase 2"."ColoresTraje"
(
    "Heroe",
    "ColorTraje"
)

INSERT INTO "Proyecto Fase 2"."Nacionalidad"
(
    "Pais",
    "Nombre" 
)

INSERT INTO "Proyecto Fase 2"."Organizacion"
(
    "Nombre",
    "Slogan",
    "Tipo",
    "Objetivo",
    "LugarCreacion",
    "PrimeraAparicion",
    "Fundador",
    "Lider"
)

INSERT INTO "Proyecto Fase 2"."Sede"
(
    "Nombre",
    "Ubicacion",
    "TipoEdificacion",
    "NombreOrganizacion"
)

INSERT INTO "Proyecto Fase 2"."Poder"
(
    "Nombre",
    "Descripcion"
)

INSERT INTO "Proyecto Fase 2"."Objeto"
(
    "Nombre",
    "MaterialFab",
    "TipoObj",
    "Descripcion"
)

INSERT INTO "Proyecto Fase 2"."ObjetoCreadores"
(
    "ObjetoNombre",
    "Creador"
)

INSERT INTO "Proyecto Fase 2"."Combate"
(
    "Fecha",
    "Lugar"
)

INSERT INTO "Proyecto Fase 2"."Medio"
(
    "Titulo",
    "CompaniaProd",
    "Sinopsis",
    "FechaEstr",
    "Rating"
)

INSERT INTO "Proyecto Fase 2"."Pelicula"
(
    "Titulo",
    "Director",
    "Duracion",
    "Distribuidor",
    "TipoPelicula",
    "CosteProd",
    "Ganancias"
)

INSERT INTO "Proyecto Fase 2"."Serie"
(
    "Titulo",
    "Creador",
    "CanalTrans",
    "Tipo",
    "TotalEpi"
)

INSERT INTO "Proyecto Fase 2"."Videojuego"
(
    "Titulo",
    "TipoJuego",
    "CompanniaPub"
)

INSERT INTO "Proyecto Fase 2"."VideojuegoPlataformas"
(
    "Titulo",
    "Plataforma"
)

INSERT INTO "Proyecto Fase 2"."Conoce"
(
    "Civil",
    "Heroe"
)

INSERT INTO "Proyecto Fase 2"."Trata"
(
    "NombreVillano",
    "NombreCivil"
)

INSERT INTO "Proyecto Fase 2"."Aparece"
(
    "Personaje",
    "Medio",
    "NombreActor",
    "TipoActor",
    "Rol"
)

INSERT INTO "Proyecto Fase 2"."Interviene"
(
    "Organizacion",
    "Medio",
    "Rol",
    "EstadoFinal"
)

INSERT INTO "Proyecto Fase 2"."Tiene"
(
    "NombreCompleto",
    "Nacionalidad"
)

INSERT INTO "Proyecto Fase 2"."Pertenece"
(
    "Nombre",
    "Organizacion",
    "Cargo",
    "Fecha"
)

INSERT INTO "Proyecto Fase 2"."Porta"
(
    "Nombre",
    "Objeto"
)

INSERT INTO "Proyecto Fase 2"."Posee"
(
    "Personaje",
    "Poder",
    "FormaObtencion"
)

INSERT INTO "Proyecto Fase 2"."ParticipaObj"
(
    "Nombre",
    "CombateFecha",
    "Objeto",
    "CombateLugar" 
)

INSERT INTO "Proyecto Fase 2"."ParticipaPod"
(
    "Nombre",
    "Poder",
    "CombateFecha",
    "CombateLugar"
)
