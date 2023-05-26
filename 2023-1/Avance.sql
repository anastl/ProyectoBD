/*

Personaje(idPersonaje PK, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador)
Civil(idPersonaje FK)
Heroe(idPersonaje FK, nombreSuper, logo, trajeColor)
Villano(idPersonaje FK, nombreVillano, objetivo)
Medio(idMedio PK, titulo, fecha_estreno, productora, rating, sinopsis)
Juego(plataforma, tipo, compañia)
Pelicula(director, duracion, distribuidor, ganancia, costo, tipo)
Serie(tipo, canal, creador, cantEpisodios)
Organizacion(idOrganizacion PK, nombre, eslogan, lugarCreacion, tipoOrganizacion, objetivo, primeraAparicionEnComic)
Cargo(idCargo PK, descripcion)
Sede(idSede PK, nombre, ubicacion, tipo)
Objeto(idObjeto PK, nombre, material, tipo, descripcion, creador)
Poder(idPoder PK, nombre, descripcion)
Actor(CI PK, nombre)

Interpreta(idPersonaje FK, CIActor FK, forma)
Combate(idObjeto FK, idPersonaje FK, idPoder, FK, lugar, personaje, fechaCombate PK)
Aparece(idOrganizacion, FK, idMedio FK, idPersonaje FK)
Ocupa(idPersonaje FK, idCargo FK, idOrganizacion FK)
Obtiene(idPoder FK, idPersonaje FK, manera)
Pertenece(idOrganizacion FK, idPersonaje FK)
Funda()
Lidera()

*/


--
/***  Creación de Tablas  ***/
--

/* Tabla de Personaje */

CREATE TABLE personaje (idPersonaje integer PRIMARY KEY, nombre text, fraseCelebre text, sexo text, colorCabello text, colorOjos text, estadoCivil text, ocupacion text, nacionalidad text, creador text)

Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (1, 'Groot', 'Yo soy Groot', 'Masculino', 'marron', 'marron', 'soltero', 'integrante', 'Flora colossus', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (2, 'Peter Quill', 'Yo soy Groot', 'Masculino', 'marron', 'marron', 'soltero', 'integrante', 'Estadounidense', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (3, 'Anthony Edward Stark', 'Yo soy Groot', 'Femenino', 'marron', 'marron', 'soltero', 'integrante', 'Horrible mujer', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (4, 'Bruce Banner', 'Mi secreto es que siempre estoy furioso', 'Masculino', 'verde', 'verde', 'soltero', 'integrante', 'Kylosiano', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (5, 'Thor', 'Sigo siendo digno', 'Masculino', 'marron', 'marron', 'soltero', 'integrante', 'Kylosiano', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (6, 'Peter Parker', 'Un gran poder conlleva una gran responsabilidad', 'Masculino', 'marron', 'marron', 'soltero', 'integrante', 'Humano', 'Stan Lee');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (7, 'Johann Schmidt', 'Un gran poder conlleva una gran responsabilidad', 'Masculino', 'marron', 'marron', 'soltero', 'integrante', 'Kylosiano', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (8, 'Jackson Rollins', 'Un gran poder conlleva una gran responsabilidad', 'Masculino', 'marron', 'marron', 'soltero', 'integrante', 'Kylosiano', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (9, 'Alveus', 'Un gran poder conlleva una gran responsabilidad', 'Masculino', 'marron', 'marron', 'soltero', 'integrante', 'Kylosiano', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (10, 'Maybelle Reilly', 'Un gran poder conlleva una gran responsabilidad', 'Femenino', 'marron', 'marron', 'casada', 'integrante', 'Kylosiano', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (11, 'Pepper Potts', 'Un gran poder conlleva una gran responsabilidad', 'Femenino', 'marron', 'marron', 'soltero', 'integrante', 'Kylosiano', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (12, 'Alphonso Mackenzie', 'Un gran poder conlleva una gran responsabilidad', 'Masculino', 'marron', 'marron', 'soltero', 'integrante', 'Kylosiano', 'Dan Abnett');
Insert into personaje(idPersonaje, nombre, fraseCelebre, sexo, colorCabello, colorOjos, estadoCivil, ocupacion, nacionalidad, creador) VALUES (13, 'Howard Anthony Walter Stark', 'Un gran poder conlleva una gran responsabilidad', 'Masculino', 'marron', 'marron', 'soltero', 'integrante', 'Kylosiano', 'Dan Abnett');


/* Tabla de Heroe */

CREATE TABLE heroe (idPersonaje integer FOREIGN KEY, nombreSuper text, logo text, trajeColor text)

Insert into heroe(idPersonaje, nombreSuper, logo, trajeColor) VALUES (1, 'Groot', 'su cara', 'marron');
Insert into heroe(idPersonaje, nombreSuper, logo, trajeColor) VALUES (2, 'Star Lord', 'su casco', 'vinotinto');
Insert into heroe(idPersonaje, nombreSuper, logo, trajeColor) VALUES (3, 'Iron Man', 'su casco', 'rojo');
Insert into heroe(idPersonaje, nombreSuper, logo, trajeColor) VALUES (4, 'Hulk', 'un punno', 'verde');
Insert into heroe(idPersonaje, nombreSuper, logo, trajeColor) VALUES (5, 'Thor', 'un martillo', 'gris');
Insert into heroe(idPersonaje, nombreSuper, logo, trajeColor) VALUES (6, 'Spider Man', 'una arannia', 'rojo');


/* Tabla de Civil */

CREATE TABLE civil (idPersonaje integer FOREIGN KEY)

Insert into heroe(idPersonaje) VALUES (10);
Insert into heroe(idPersonaje) VALUES (11);
Insert into heroe(idPersonaje) VALUES (12);
Insert into heroe(idPersonaje) VALUES (13);


/* Tabla de Villano */

CREATE TABLE villano (idPersonaje integer FOREIGN KEY, nombreVillano text, objetivo text)

Insert into villano(idPersonaje, nombreVillano, objetivo) VALUES (7, 'hive', 'Destruir el mundo');
Insert into villano(idPersonaje, nombreVillano, objetivo) VALUES (8, 'hive', 'Destruir el mundo');
Insert into villano(idPersonaje, nombreVillano, objetivo) VALUES (9, 'hive', 'Destruir el mundo');


/* Tabla de Medio */

CREATE TABLE medio (idMedio integer PRIMARY KEY, titulo text, fecha_estreno date, productora text, rating real, sinopsis text)


/* Tabla de Juego */

CREATE TABLE juego(idMedio integer FOREIGN KEY, plataforma text, compannia text)


/* Tabla de Pelicula */

CREATE TABLE pelicula (idMedio integer FOREIGN KEY, director text, duracion real, distribuidor text, ganancia real, costo real, tipo text)


/* Tabla de Serie */

CREATE TABLE serie (idMedio integer FOREIGN KEY, tipo text, canal text, creador text, cantEpisodios integer)


/* Tabla de Organizacion */

CREATE TABLE organizacion (idOrganizacion integer PRIMARY KEY, nombre text, eslogan text, lugarCreacion text, tipoOrganizacin text, objetivo text, primeraAparicion text)

Insert into organizacion(idOrganizacion, nombre, eslogan, lugarCreacion, tipoOrganizacion, objetivo, primeraAparicion) values(1, 'S.H.I.E.L.D.', 'tenemos infiltrados', 'United State', 'Buena', 'Salvar', 'En la segunda guerra mundial')
Insert into organizacion(idOrganizacion, nombre, eslogan, lugarCreacion, tipoOrganizacion, objetivo, primeraAparicion) values(2, 'Stark Industries', 'Tony fiesta', 'New York', 'Buena', 'Salvar', '1939')
Insert into organizacion(idOrganizacion, nombre, eslogan, lugarCreacion, tipoOrganizacion, objetivo, primeraAparicion) values(3, 'Hydra', 'somos los infiltrados', 'Somewhere', 'Mala', 'Destruir', 'ancient times')

/* Tabla de Cargo */

CREATE TABLE cargo (idCargo integer PRIMARY KEY, descripcion text)


/* Tabla de Sede */

CREATE TABLE sede (idSede integer PRIMARY KEY, nombre text, ubicacion text, tipo text)


/* Tabla de Objeto */

CREATE TABLE objeto (idObjeto integer PRIMARY KEY, nombre text, matetrial text, tipo text, descripcion text, creador text)


/* Tabla de Poder */

CREATE TABLE poder (idPoder integer PRIMARY KEY, nombre text, descripcion text)


/* Tabla de Actor */

CREATE TABLE actor (CI integer PRIMARY KEY, nombre text)


/* Tabla Interpreta */

CREATE TABLE interpreta (idPersonaje integer FOREIGN KEY, CIActor FOREIGN KEY, forma text)


/* Tabla Combate */

CREATE TABLE combate (idObjeto integer FOREIGN KEY, idPersonaje integer FOREIGN KEY, idPoder integer FOREIGN KEY, lugar text, personaje text, fechaCombate date PRIMARY KEY)


/* Tabla Aparece */

CREATE TABLE aparece (idOrganizacion integer FOREIGN KEY, idMedio integer FOREIGN KEY, idPersonaje integer FOREIGN KEY, alineacion text, estado text)
 

/* Tabla Interpreta */

CREATE TABLE ocupa (idPersonaje integer FOREIGN KEY, idCargo integer FOREIGN KEY, idOrganizacion integer FOREIGN KEY)


/* Tabla Obtiene */

CREATE TABLE obtiene (idPoder integer FOREIGN KEY, idPersonaje integer FOREIGN KEY, manera text)


/* Tabla Pertenece */

CREATE TABLE pertenece (idOrganizacion integer FOREIGN KEY, idPersonaje integer FOREIGN KEY)

