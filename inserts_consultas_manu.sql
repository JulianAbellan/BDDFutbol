DROP TYPE Pais_objtyp FORCE;
DROP TYPE Persona_objtyp FORCE;
DROP TYPE Presidente_objtyp FORCE;
DROP TYPE Entrenador_objtyp FORCE;
DROP TYPE LigaFutbol_objtyp FORCE;
DROP TYPE Club_objtyp FORCE;
DROP TYPE Preside_objtyp FORCE;
DROP TYPE Historial_objtyp FORCE;
DROP TYPE Estadio_objtyp FORCE;
DROP TYPE Equipo_objtyp FORCE;
DROP TYPE Clasificacion_objtyp FORCE;
DROP TYPE Jugador_objtyp FORCE;
DROP TYPE Arbitro_objtyp FORCE;
DROP TYPE Juega_objtyp FORCE;
DROP TYPE Arbitra_objtyp FORCE;
DROP TYPE nt_juega_typ FORCE;
DROP TYPE nt_arbitra_typ FORCE;
DROP TYPE Partido_objtyp FORCE;
DROP TYPE Resultado_objtyp FORCE;

DROP TABLE Pais_objtab;
DROP TABLE LigaFutbol_objtab;
DROP TABLE Clasificacion_objtab;
DROP TABLE Estadio_objtab;
DROP TABLE Club_objtab;
DROP TABLE Equipo_objtab;
DROP TABLE Partido_objtab;
DROP TABLE Jugador_objtab;
DROP TABLE Arbitro_objtab;
DROP TABLE Entrenador_objtab;
DROP TABLE Preside_objtab;
DROP TABLE Historial_objtab;
DROP TABLE Presidente_objtab;

CREATE OR REPLACE TYPE Pais_objtyp AS OBJECT(
    Nombre VARCHAR2(20),
    Continente VARCHAR2(20)
);
/

CREATE OR REPLACE TYPE Persona_objtyp AS OBJECT(
    ID_persona VARCHAR2(20),
    Nombre VARCHAR2(20),
    Apellido1 VARCHAR2(20),
    Apellido2 VARCHAR2(20),
    Edad NUMBER(3),
    Pais REF Pais_objtyp
)NOT FINAL NOT INSTANTIABLE;
/

CREATE OR REPLACE TYPE Presidente_objtyp UNDER Persona_objtyp(
    Aval VARCHAR2(20)
);
/

CREATE OR REPLACE TYPE Entrenador_objtyp UNDER Persona_objtyp(
    FueJugador NUMBER(1,0)
);
/

CREATE OR REPLACE TYPE LigaFutbol_objtyp AS OBJECT(
    ID_liga NUMBER(10),
    Nombre VARCHAR2(20),
    Division NUMBER(1),
    Pais REF Pais_objtyp
);
/

CREATE OR REPLACE TYPE Preside_objtyp AS OBJECT(
    FechaPosesion DATE,
    FechaCese DATE,
    Presidente REF Presidente_objtyp
);
/

CREATE OR REPLACE TYPE Club_objtyp AS OBJECT(
    ID_club NUMBER(10),
    Nombre VARCHAR2(20),
    MasaSalarialMaxima NUMBER(10),
    Presupuesto NUMBER(10),
    Preside Preside_objtyp  
);
/

CREATE OR REPLACE TYPE Estadio_objtyp AS OBJECT(
    ID_estadio NUMBER(10),
    Nombre VARCHAR2(20),
    Ciudad VARCHAR2(20),
    AforoMaximo NUMBER(6),
    Direccion VARCHAR2(30),
    Club REF Club_objtyp
);
/

CREATE OR REPLACE TYPE Equipo_objtyp AS OBJECT(
    ID_equipo NUMBER(10),
    Nombre VARCHAR2(20),
    NumeroTitulos NUMBER(3),
    Presupuesto NUMBER(10),
    Liga REF LigaFutbol_objtyp,
    Estadio REF Estadio_objtyp,
    Club REF Club_objtyp,
    Entrenador REF Entrenador_objtyp
);
/

CREATE OR REPLACE TYPE Clasificacion_objtyp AS OBJECT(
    ID_clasificacion NUMBER(10),
    Temporada VARCHAR2(20),
    Puntos NUMBER(3),
    PartidosGanados NUMBER(3),
    PartidosPerdidos NUMBER(3),
    PartidosEmpatados NUMBER(3),
    GolesFavor NUMBER(3),
    GolesContra NUMBER(3),
    NumeroTarjetasAmarillas NUMBER(3),
    NumeroTarjetasRojas NUMBER(3),
    Equipo REF Equipo_objtyp,
    Liga REF LigaFutbol_objtyp  
);
/

CREATE OR REPLACE TYPE Historial_objtyp as OBJECT(
    Id_historial NUMBER(10),
    TemporadaEntrada VARCHAR2(20),
    TemporadaSalida VARCHAR2(20),
    Equipo REF Equipo_objtyp
);
/

CREATE OR REPLACE TYPE Jugador_objtyp UNDER Persona_objtyp(
    Dorsal NUMBER(2),
    Posicion VARCHAR2(25),
    Sueldo NUMBER(10),
    TarjetasRojas NUMBER(3),
    TarjetasAmarillas NUMBER(3),
    PartidosJugados NUMBER(3),
    MinutosJugados NUMBER(2),
    GolesTotales NUMBER(3),
    Equipo REF Equipo_objtyp,
    Historial REF Historial_objtyp
);
/

CREATE OR REPLACE TYPE Arbitro_objtyp UNDER Persona_objtyp(
    RolPrincipal VARCHAR2(10)
);
/

CREATE OR REPLACE TYPE Juega_objtyp AS OBJECT (
    MinutoEntrada NUMBER(2),
    MinutoSalida NUMBER(2),
    TarjetaRoja NUMBER(1),
    TarjetaAmarilla1 NUMBER(1),
    TarjetaAmarilla2 NUMBER(1),
    MinutoRoja NUMBER(2),
    MinutoAmarilla1 NUMBER(2),
    MinutoAmarilla2 NUMBER(2),
    Goles NUMBER(2),
    Jugador REF Jugador_objtyp
);
/

CREATE OR REPLACE TYPE Arbitra_objtyp AS OBJECT (
    Rol VARCHAR2(35),
    Arbitro REF Arbitro_objtyp
);
/
CREATE TYPE nt_juega_typ AS TABLE OF Juega_objtyp;
/
CREATE TYPE nt_arbitra_typ AS TABLE OF Arbitra_objtyp;
/

CREATE OR REPLACE TYPE Resultado_objtyp AS OBJECT (
    GolesLocal NUMBER(2),
    GolesVisitante NUMBER(2),
    MVP VARCHAR2(50),
    MinutosPrimera NUMBER(2),
    MinutosSegunda NUMBER(2)
);
/

CREATE OR REPLACE TYPE Partido_objtyp AS OBJECT (
    ID_partido NUMBER(10),
    Fecha DATE,
    Hora NUMBER(2),
    Equipo_local REF Equipo_objtyp,
    Equipo_visitante REF Equipo_objtyp,
    Estadio_partido REF Estadio_objtyp,
    jugadores nt_juega_typ,
    arbitros nt_arbitra_typ,
    Resultado Resultado_objtyp
);
/

CREATE TABLE Pais_objtab OF Pais_objtyp(
    Nombre PRIMARY KEY,
    Continente NOT NULL
);
/

CREATE TABLE Presidente_objtab OF Presidente_objtyp(
    ID_persona PRIMARY KEY,
    Nombre NOT NULL,
    Apellido1 NOT NULL,
    Edad NOT NULL,
    CHECK (Edad >= 18),
    Aval NOT NULL
);
/

CREATE TABLE Entrenador_objtab OF Entrenador_objtyp(
    ID_persona PRIMARY KEY,
    Nombre NOT NULL,
    Apellido1 NOT NULL,
    Edad NOT NULL,
    CHECK (Edad >= 18),
    CHECK (FueJugador IN (0,1))
);
/

CREATE TABLE LigaFutbol_objtab OF LigaFutbol_objtyp(
    ID_liga PRIMARY KEY,
    Nombre NOT NULL,
    Division NOT NULL
);
/

CREATE TABLE Club_objtab OF Club_objtyp(
    ID_club PRIMARY KEY,
    Nombre NOT NULL
);
/

CREATE TABLE Preside_objtab OF Preside_objtyp(
    FechaPosesion NOT NULL
);
/

CREATE TABLE Historial_objtab OF Historial_objtyp(
    Id_historial PRIMARY KEY,
    TemporadaEntrada NOT NULL
);
/

CREATE TABLE Estadio_objtab OF Estadio_objtyp(
    ID_estadio PRIMARY KEY,
    Nombre NOT NULL,
    Ciudad NOT NULL,
    CHECK (AforoMaximo >= 0)
);
/

CREATE TABLE Equipo_objtab OF Equipo_objtyp(
    ID_equipo PRIMARY KEY,
    Nombre NOT NULL,
    CHECK (NumeroTitulos >= 0)
);
/

CREATE TABLE Clasificacion_objtab OF Clasificacion_objtyp(
    ID_clasificacion PRIMARY KEY,
    Temporada NOT NULL,
    CHECK (Puntos >= 0),
    CHECK (PartidosGanados >= 0),
    CHECK (PartidosPerdidos >= 0),
    CHECK (PartidosEmpatados >= 0),
    CHECK (GolesFavor >= 0),
    CHECK (GolesContra >= 0),
    CHECK (NumeroTarjetasAmarillas >= 0),
    CHECK (NumeroTarjetasRojas >= 0)
);
/

CREATE TABLE Jugador_objtab OF Jugador_objtyp (
    ID_persona PRIMARY KEY,
    Nombre NOT NULL,
    Apellido1 NOT NULL,
    Edad NOT NULL,
    CHECK (Edad >= 18),
    CHECK (Dorsal >= 1 AND Dorsal <= 99),
    CHECK (Posicion IN ('Delantero','Centrocampista','Defensa','Portero')),
    CHECK (Sueldo >= 0),
    CHECK (TarjetasRojas >= 0),
    CHECK (TarjetasAmarillas >= 0),
    CHECK (MinutosJugados >= 0),
    CHECK (PartidosJugados >= 0),
    CHECK (GolesTotales >= 0)
);
/

CREATE TABLE Arbitro_objtab OF Arbitro_objtyp(
    ID_persona PRIMARY KEY,
    Nombre NOT NULL,
    Apellido1 NOT NULL,
    Edad NOT NULL,
    CHECK (Edad >= 18),
    CHECK (RolPrincipal IN ('Principal', 'Asistente', 'Cuarto', 'Asistente adicional'))
);
/

CREATE TABLE Partido_objtab OF Partido_objtyp (
    ID_partido PRIMARY KEY,
    CHECK (Resultado.GolesLocal >= 0),
    CHECK (Resultado.GolesVisitante >= 0),
    CHECK (Resultado.MinutosPrimera >= 45),
    CHECK (Resultado.MinutosSegunda >= 45)
) NESTED TABLE jugadores STORE AS nt_juega_tab,
NESTED TABLE arbitros STORE AS nt_arbitra_tab;
/

ALTER TABLE LigaFutbol_objtab ADD(SCOPE FOR (Pais) IS Pais_objtab);
/
ALTER TABLE Presidente_objtab ADD(SCOPE FOR (Pais) IS Pais_objtab);
/
ALTER TABLE Entrenador_objtab ADD(SCOPE FOR (Pais) IS Pais_objtab);
/
ALTER TABLE Jugador_objtab ADD(
SCOPE FOR (Pais) IS Pais_objtab,
SCOPE FOR (Equipo) IS Equipo_objtab,
SCOPE FOR (Historial) IS Historial_objtab);
/
ALTER TABLE Arbitro_objtab ADD(SCOPE FOR (Pais) IS Pais_objtab);
/

ALTER TABLE Clasificacion_objtab ADD(
    SCOPE FOR (Liga) IS LigaFutbol_objtab,
    SCOPE FOR (Equipo) IS Equipo_objtab);
/

ALTER TABLE Equipo_objtab ADD(
    SCOPE FOR (Entrenador) IS Entrenador_objtab,
    SCOPE FOR (Liga) IS LigaFutbol_objtab,
    SCOPE FOR (Estadio) IS Estadio_objtab,
    SCOPE FOR (Club) IS Club_objtab);
/  
ALTER TABLE Estadio_objtab ADD(SCOPE FOR (Club) IS Club_objtab);
/

ALTER TABLE Preside_objtab ADD(
    SCOPE FOR (Presidente) IS Presidente_objtab);
/

ALTER TABLE Historial_objtab ADD(
    SCOPE FOR (Equipo) IS Equipo_objtab);
/

ALTER TABLE nt_juega_tab ADD(
    SCOPE FOR (Jugador) IS Jugador_objtab,
    CHECK(MinutoEntrada>=0 AND MinutoEntrada<=130),
    CHECK(MinutoSalida>=0 AND MinutoSalida<=130),
    CHECK(MinutoAmarilla1>=0 AND MinutoAmarilla1<=130),
    CHECK(MinutoAmarilla2 >=0 AND MinutoAmarilla2<=130),
    CHECK(MinutoRoja >=0 AND MinutoRoja<=130),
    CHECK(TarjetaRoja >= 0),
    CHECK(TarjetaAmarilla1 >= 0),
    CHECK(TarjetaAmarilla2 >= 0)
    );
/

ALTER TABLE nt_arbitra_tab ADD(
    SCOPE FOR (Arbitro) IS Arbitro_objtab,
    CHECK(Rol IN ('Principal', 'Asistente', 'Cuarto', 'Asistente adicional'))
    );
/

ALTER TABLE Partido_objtab ADD(
    SCOPE FOR (Equipo_local) IS Equipo_objtab,
    SCOPE FOR (Equipo_visitante) IS Equipo_objtab,
    SCOPE FOR (Estadio_partido) IS Estadio_objtab);
/  

INSERT INTO Pais_objtab VALUES('España', 'Europa');/
INSERT INTO Pais_objtab VALUES('Francia', 'Europa');/
INSERT INTO Pais_objtab VALUES('Italia', 'Europa');/
INSERT INTO Pais_objtab VALUES('Argentina', 'América del Sur');/
INSERT INTO Pais_objtab VALUES('Brasil', 'América del Sur');/
INSERT INTO Pais_objtab VALUES('Alemania', 'Europa');/
INSERT INTO Pais_objtab VALUES('Croacia', 'Europa');/
INSERT INTO Pais_objtab VALUES('Inglaterra', 'Europa');/
INSERT INTO Pais_objtab VALUES('Dinamarca', 'Europa');/
INSERT INTO Pais_objtab VALUES('Países Bajos', 'Europa');/
INSERT INTO Pais_objtab VALUES('Uruguay', 'América del Sur');/
INSERT INTO Pais_objtab VALUES('Polonia', 'Europa');/
INSERT INTO Pais_objtab VALUES('Bélgica', 'Europa');/
INSERT INTO Pais_objtab VALUES('Austria', 'Europa');/
INSERT INTO Pais_objtab VALUES('Portugal', 'Europa');/
INSERT INTO Pais_objtab VALUES('Eslovenia', 'Europa');/

INSERT INTO LigaFutbol_objtab VALUES (
    1, -- ID_liga
    'LaLiga Santander', -- Nombre
    1, -- División
    (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España') -- Pais
);

INSERT INTO LigaFutbol_objtab VALUES (
    2, -- ID_liga
    'Premier League', -- Nombre
    1, -- División
    (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Inglaterra') -- Pais
);

INSERT INTO arbitro_objtab (id_persona ,nombre, rolprincipal, apellido1, pais, edad)
            VALUES (1, 'Mateu', 'Principal', 'Lahoz', (SELECT REF(p) FROM pais_objtab p WHERE p.nombre = 'España') , 50);
/                      
INSERT INTO arbitro_objtab (id_persona, nombre, rolprincipal, apellido1, apellido2, pais, edad)
            VALUES (2, 'Jesús', 'Principal', 'Gil', 'Manzano' ,(SELECT REF(p) FROM pais_objtab p WHERE p.nombre = 'España') , 50);
/
INSERT INTO arbitro_objtab (id_persona, nombre, rolprincipal, apellido1, apellido2, pais, edad)
            VALUES (3, 'Alejandro', 'Principal', 'Hernández', 'Hernández' , (SELECT REF(p) FROM pais_objtab p WHERE p.nombre = 'España') , 50);
/
INSERT INTO arbitro_objtab (id_persona, nombre, rolprincipal, apellido1, apellido2, pais, edad)
            VALUES (4, 'Raúl', 'Cuarto', 'Calvo', 'Alcázar' , (SELECT REF(p) FROM pais_objtab p WHERE p.nombre = 'España') , 50);
/
INSERT INTO presidente_objtab (id_persona, nombre, apellido1, apellido2, edad, aval, pais)
    VALUES (200, 'Joan', 'Laporta', 'Estruch', 60, 'Spotify', (SELECT REF(p) FROM pais_objtab p WHERE p.nombre = 'España'));
/
INSERT INTO presidente_objtab (id_persona, nombre, apellido1, apellido2, edad, aval, pais)
    VALUES (201, 'Florentino', 'Pérez', 'Rodríguez', 76, 'ACS', (SELECT REF(p) FROM pais_objtab p WHERE p.nombre = 'España'));
/
INSERT INTO club_objtab (id_club, nombre, presupuesto, preside)
    VALUES (100, 'FC Barcelona', 100000000,
            Preside_objtyp(SYSDATE, null,
            (SELECT REF(pr) FROM presidente_objtab pr WHERE pr.id_persona = '200'))
            );
/
INSERT INTO club_objtab (id_club, nombre, presupuesto, preside)
    VALUES (101, 'Real Madrid CF', 200000000,
             Preside_objtyp(SYSDATE, null,
                (SELECT REF(pr) FROM presidente_objtab pr WHERE pr.id_persona = '201'))
    );
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (102, 'Atlético de Madrid', 100000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (103, 'Valencia CF', 80000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (104, 'Sevilla CF', 80000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (105, 'Real Betis Balompié', 60000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (200, 'Manchester City', 400000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (201, 'Manchester United', 200000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (202, 'Liverpool', 100000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (203, 'Arsenal', 200000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (204, 'Tottenham Hotspur FC', 100000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (205, 'Chelsea FC', 400000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (300, 'AC Milan', 100000000);
/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (301, 'Inter de Milano', 100000000);
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (1, 'Spotify Camp Nou', 'Barcelona', 90000, 'Carrer de Colon');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (2, 'Santiago Bernabéu', 'Madrid', 90000, 'Avenida de la Libertad');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (3, 'Metropolitano', 'Madrid', 90000, 'Calle de Metropolitano');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (4, 'Mestalla', 'Valencia', 70000, 'Carrer de Jaume I');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (5, 'Sánchez Pizjuan', 'Sevilla', 70000, 'Calle Zapatos');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (6, 'Benito Villamarín', 'Sevilla', 70000, 'Calle Anchoas');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (7, 'Etihad Stadium', 'Manchester', 60000, 'Success Road');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (8, 'Old Trafford', 'Manchester', 60000, 'Ryan Road');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (9, 'Anfield', 'Liverpool', 60000, 'Steven Road');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (10, 'Tottenham Stadium', 'Londres', 60000, 'Harry Road');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (11, 'Emirates Stadium', 'Londres', 60000, 'Thierry Road');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (12, 'Stamford Bridge', 'Londres', 60000, 'John Road');
/
INSERT INTO estadio_objtab (id_estadio, nombre, ciudad, aforomaximo, direccion)
    VALUES (13, 'San Siro', 'Italia', 60000, 'Strada dAllegria');
/
INSERT INTO preside_objtab (presidente, fechaposesion)
    VALUES ((SELECT REF(p) FROM presidente_objtab p WHERE p.nombre = 'Joan'),SYSDATE);
/
INSERT INTO preside_objtab (presidente, fechaposesion)
    VALUES ((SELECT REF(p) FROM presidente_objtab p WHERE p.apellido1 = 'Pérez'),SYSDATE);
/
INSERT INTO Entrenador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, FueJugador, Pais)
VALUES (116, 'Xavi', 'Hernández', 'Creus' , 40, 1, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'));
/
INSERT INTO Entrenador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, FueJugador, Pais)
VALUES (117, 'Carlo', 'Ancelotti', 'Puro', 63, 1, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Italia'));
/
INSERT INTO Entrenador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, FueJugador, Pais)
VALUES (118, 'Diego', 'Simeone', 'Juárez', 51, 1, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Argentina'));
/
INSERT INTO equipo_objtab (id_equipo, nombre, numerotitulos, presupuesto, club, estadio, entrenador, liga)
    VALUES (1, 'FC Barcelona', 26, 900000, (SELECT REF(c) FROM club_objtab c WHERE c.nombre = 'FC Barcelona'),
            (SELECT REF(e) FROM estadio_objtab e WHERE e.nombre = 'Spotify Camp Nou'),
            (SELECT REF(e) FROM entrenador_objtab e WHERE e.nombre like 'Xavi'),
            (SELECT REF(l) FROM ligafutbol_objtab l WHERE l.nombre like 'LaLiga Santander'));
/
INSERT INTO equipo_objtab (id_equipo, nombre, numerotitulos, presupuesto, club, estadio, entrenador, liga)
    VALUES (2, 'Real Madrid CF', 34, 900000, (SELECT REF(c) FROM club_objtab c WHERE c.nombre like 'Real Madrid'),
            (SELECT REF(e) FROM estadio_objtab e WHERE e.nombre = 'Santiago Bernabéu'),
            (SELECT REF(e) FROM entrenador_objtab e WHERE e.nombre like 'Carlo'),
            (SELECT REF(l) FROM ligafutbol_objtab l WHERE l.nombre like 'LaLiga Santander'));
/
INSERT INTO equipo_objtab (id_equipo, nombre, numerotitulos, presupuesto, club, estadio, entrenador, liga)
    VALUES (3, 'Atlético de Madrid', 11, 600000, (SELECT REF(c) FROM club_objtab c WHERE c.nombre = 'Atlético de Madrid'),
            (SELECT REF(e) FROM estadio_objtab e WHERE e.nombre = 'Metropolitano'),
            (SELECT REF(e) FROM entrenador_objtab e WHERE e.nombre like 'Diego'),
            (SELECT REF(l) FROM ligafutbol_objtab l WHERE l.nombre like 'LaLiga Santander'));
/








INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES (100, 'Thibaut', 'Courtois', null, 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Bélgica'), 1, 'Portero', 9000000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/




INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES (101, 'Daniel', 'Carvajal', 'Ramos', 31,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    2, 'Defensa', 6500000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/




INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES (102, 'Jesús', 'Vallejo', 'Lázaro', 27,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    5, 'Defensa', 3000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));




/
   
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES (103, 'José Ignacio', 'Fernández', 'Iglesias', 33,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    6, 'Defensa', 5000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES (104, 'Álvaro', 'Odriozola', 'Pérez', 28,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    16, 'Defensa', 1000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES (105, 'Lucas', 'Vázquez', 'Iglesias', 32,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    17, 'Defensa', 3000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
 /  

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES (106, 'Toni', 'Kroos', null , 33,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Alemania'),
    8, 'Centrocampista', 7000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/
   
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES (107, 'Luka', 'Modric', null , 38,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Croacia'),
    10, 'Centrocampista', 8000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES (108, 'Vinicius', 'de Oliveira', 'Junior' , 23 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'),
     20, 'Delantero', 8000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
VALUES (109, 'Rodrygo', 'Goes', null , 22 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'),
     21, 'Delantero', 8500000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
VALUES (110, 'Mariano', 'Díaz', 'Mejía' , 30 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
     24, 'Delantero', 1200000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
VALUES (111, 'Eduardo', 'Camavinga', null, 21 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Francia'),
     12, 'Centrocampista', 5500000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
VALUES (112, 'Aurélien ', 'Tchouameni', null, 23 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Francia'),
     18, 'Centrocampista', 6000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
VALUES (113, 'Éder', 'Gabriel', 'Militão', 25 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'),
     3, 'Defensa', 7800000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
VALUES (114, 'Antonio ', 'Rüdiger  ', null , 22 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Alemania'),
     22, 'Defensa',6500000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
VALUES (115, 'David  ', 'Alaba', null , 31 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Austria'),
     4, 'Defensa', 8000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'));
/
INSERT INTO historial_objtab (Id_historial, equipo, TemporadaEntrada)
    VALUES (0001, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre = 'FC Barcelona'), '2021-22');
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(50, 'Marc-André', 'ter Stegen', null, 30, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Alemania'), 1, 'Portero', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, Historial)
    VALUES(51, 'Ronald', 'Araujo', 24, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Uruguay'), 4, 'Defensa', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), (SELECT REF(h) FROM Historial_objtab h WHERE h.Id_historial = 0001)
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(52, 'Andreas', 'Christensen', 27, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Dinamarca'), 15, 'Defensa', 6000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(53, 'Marcos', 'Alonso', 'Mendoza', 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 17, 'Defensa', 5000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(54, 'Jules', 'Olivier', 'Koundé', 24, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Francia'), 23, 'Defensa', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(55, 'Eric', 'García', 'Martret', 22, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 24, 'Defensa', 3000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(56, 'Jordi', 'Alba', 'Ramos', 33, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 18, 'Defensa', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(57, 'Sergio', 'Busquets', 'Burgos', 34, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 5, 'Centrocampista', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(58, 'Pablo', 'Martín', 'Gavira', 18, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 6, 'Centrocampista', 6500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(59, 'Pedro', 'González', 'López', 20, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 8, 'Centrocampista', 9500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(60, 'Frenkie', 'de Jong', 25, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Países Bajos'), 21, 'Centrocampista', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(61, 'Sergi', 'Roberto', 'Carnicer', 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 20, 'Centrocampista', 6500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(62, 'Ousmane', 'Dembélé', null, 25, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Francia'), 7, 'Delantero', 9500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(63, 'Robert', 'Lewandowski', 34, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Polonia'), 9, 'Delantero', 11000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(64, 'Anssumane', 'Fati', 'Vieira', 20, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 10, 'Delantero', 7500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(65, 'Ferran', 'Torres', 'García', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 11, 'Delantero', 6500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(67, 'Raphael', 'Dias', 'Belloli', 26, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Brasil'), 22, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(66, 'Ignacio', 'Peña', 'Sotorres', 24, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 13, 'Portero', 1500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(70, 'Jan', 'Oblak', null , 30, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Eslovenia'), 13, 'Portero', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(71, 'José', 'Giménez', 'López' , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Uruguay'), 2, 'Defensa', 5000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(72, 'Mario', 'Hermoso', null , 27, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 22, 'Defensa', 2000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(73, 'Stefan', 'Savic', null , 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Eslovenia'), 15, 'Defensa', 3000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(74, 'Nahuel', 'Molina', null , 25, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Argentina'), 16, 'Defensa', 3000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(75, 'Rodrigo', 'de Paul', null , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Argentina'), 5, 'Centrocampista', 3000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(76, 'Koke', 'Resurrección', null , 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 6, 'Centrocampista', 4000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(77, 'Marcos', 'Llorente', null , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 14, 'Centrocampista', 6000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(78, 'Álvaro', 'Morata', null , 30, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 19, 'Delantero', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(79, 'Antoine', 'Griezmann', null , 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Francia'), 8, 'Delantero', 10000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(80, 'Memphis', 'Depay', null , 29, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Países Bajos'), 9, 'Delantero', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo)
    VALUES(81, 'Ángel', 'Correa', null , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Argentina'), 10, 'Delantero', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid')
);
/
INSERT INTO clasificacion_objtab (id_clasificacion, temporada, puntos, partidosganados, partidosperdidos, partidosempatados, golesfavor, golescontra, equipo, liga)
    VALUES (1, '2022-23', 62, 20, 2, 2, 46, 8,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre = 'FC Barcelona'),
            (SELECT REF(l) FROM ligafutbol_objtab l WHERE l.id_liga =  1));
/
INSERT INTO clasificacion_objtab (id_clasificacion, temporada, puntos, partidosganados, partidosperdidos, partidosempatados, golesfavor, golescontra, equipo, liga)
    VALUES (2, '2022-23', 56, 17, 5, 3, 50, 19,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre = 'Real Madrid CF'),
            (SELECT REF(l) FROM ligafutbol_objtab l WHERE l.id_liga =  1));
/
INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (1, SYSDATE, 16,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Santiago Bernabéu'),
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Courtois')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Carvajal')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Kroos')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Modric')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Vallejo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Odriozola')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Fernández')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Camavinga')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Tchouameni')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Goes')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Oliveira')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Díaz')),
                                               
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'ter Stegen')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Araujo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alonso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'García')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alba')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Busquets')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'González')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Roberto')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 2, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dembélé')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 3, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Lewandowski')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Torres')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Fati'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, jugadores, arbitros)
    VALUES (2, SYSDATE, 21,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'),  
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Courtois')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Carvajal')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Kroos')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 2, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Modric')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Vallejo')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Odriozola')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Fernández')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Camavinga')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Tchouameni')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 4, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Goes')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Oliveira')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 2, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Alaba')),
                                               
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'ter Stegen')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Araujo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alonso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'García')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alba')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Busquets')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'González')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Roberto')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dembélé')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Lewandowski')),
                        Juega_objtyp(0, 45, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Torres')),
                        Juega_objtyp(45, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Dias'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, jugadores, arbitros)
    VALUES (3, SYSDATE, 13,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Atlético de Madrid'),  
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'ter Stegen')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Araujo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alonso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'García')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alba')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Busquets')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'González')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Roberto')),
                        Juega_objtyp(0, 45, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dembélé')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Lewandowski')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Torres')),
                        Juega_objtyp(45, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Dias')),


                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Oblak')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Hermoso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Giménez')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Savic')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Molina')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Paul')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Llorente')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Resurrección')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Depay')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Morata')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Griezmann')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Correa'))
                                               
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));
           
INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, jugadores, arbitros)
    VALUES (4, SYSDATE, 12,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Atlético de Madrid'),  
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Courtois')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Carvajal')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Kroos')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Modric')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Vallejo')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Odriozola')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Fernández')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Camavinga')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Tchouameni')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Goes')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Oliveira')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Alaba')),
                     


                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Oblak')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Hermoso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Giménez')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Savic')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Molina')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Paul')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Llorente')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Resurrección')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Depay')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Morata')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Griezmann')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Correa'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));


UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(5, 0, 'Fati', 47, 50))
WHERE ID_Partido = 1;

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(10, 1, 'Modric', 47, 48))
WHERE ID_Partido = 2;

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(2, 1, 'Fati', 45, 50))
WHERE ID_Partido = 3;

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(1, 1, 'Oblak', 47, 52))
WHERE ID_Partido = 4;

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados)
    VALUES (2000, 'Morris', 'Escocio', null, 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'), 99, 'Delantero', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 3, 2, 90);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados)
    VALUES (2001, 'Raul', 'Pelao', 'Jr', 37, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'), 90, 'Delantero', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 4, 2, 90);
/



INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (100, SYSDATE, 16,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'),
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Santiago Bernabéu'),
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Courtois')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Carvajal')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Kroos')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Modric')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Vallejo')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Odriozola')),
                        Juega_objtyp(45, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Fernández')),
                        Juega_objtyp(90, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Camavinga')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Tchouameni')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Goes')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 2, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Escocio')),
                        Juega_objtyp(45, 90, 0, 0, 0, null, null, null, 3, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Pelao')),
                                               
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'ter Stegen')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Araujo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alonso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'García')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alba')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Busquets')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'González')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Roberto')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dembélé')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Lewandowski')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Torres')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Fati'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (101, SYSDATE, 16,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Spotify Camp Nou'),
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Courtois')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Carvajal')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Kroos')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Modric')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Vallejo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Odriozola')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Fernández')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Camavinga')),
                        Juega_objtyp(30, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Tchouameni')),
                        Juega_objtyp(45, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Goes')),
                        Juega_objtyp(0, 30, 0, 0, 0, null, null, null, 2, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Escocio')),
                        Juega_objtyp(0, 45, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Pelao')),
                                               
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'ter Stegen')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Araujo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alonso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'García')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alba')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Busquets')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'González')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Roberto')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dembélé')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Lewandowski')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Torres')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Fati'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));


UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(5, 0, 'Pelao', 47, 50))
WHERE ID_Partido = 100;

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(3, 1, 'Escocio', 47, 48))
WHERE ID_Partido = 101;

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados)
    VALUES (2003, 'Pedro Morrongo', 'Moya', 'Toya', 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'), 89, 'Delantero', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 3, 1, 90);
/

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (104, SYSDATE, 16,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Spotify Camp Nou'),
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Courtois')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Carvajal')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Kroos')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Modric')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Vallejo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Odriozola')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Fernández')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Camavinga')),
                        Juega_objtyp(30, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Tchouameni')),
                        Juega_objtyp(45, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Goes')),
                        Juega_objtyp(0, 30, 0, 0, 0, null, null, null, 2, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Escocio')),
                        Juega_objtyp(0, 45, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Pelao')),
                                               
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'ter Stegen')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Araujo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alonso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'García')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alba')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Busquets')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'González')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Roberto')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dembélé')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Lewandowski')),
                        Juega_objtyp(90, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Torres')),
                        Juega_objtyp(0, 90, 0, 0, 0, null, null, null, 17, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Moya'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));


UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(17, 3, 'Moya', 47, 50))
WHERE ID_Partido = 104;

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados, TarjetasRojas, TarjetasAmarillas)
    VALUES (2010, 'Pepe', 'Guarro', 'Marrano', 22, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Portugal'), 90, 'Defensa', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 10, 1, 90, 1, 2);
/

INSERT INTO Pais_objtab VALUES('Rumania', 'Europa');
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados, TarjetasRojas, TarjetasAmarillas)
    VALUES (2004, 'Dimitri', 'Gitanov', 'Cobrerrobado',37, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Rumania'), 90, 'Defensa', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 10, 1, 90, 1, 2);
/

INSERT INTO Pais_objtab VALUES('Senegal', 'Africa');
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados, TarjetasRojas, TarjetasAmarillas)
    VALUES (2005, 'Mamalu Sebastian', 'Owebebubuwewe', 'Osas',21, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Rumania'), 90, 'Defensa', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 10, 1, 90, 1, 2);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados, TarjetasRojas, TarjetasAmarillas)
    VALUES (2006, 'Lorey', 'Money',30, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Senegal'), 90, 'Defensa', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 10, 1, 90, 1, 2);
/

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (106, SYSDATE, 16,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Spotify Camp Nou'),
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Courtois')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Carvajal')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Kroos')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Modric')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Vallejo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Odriozola')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Fernández')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Camavinga')),
                        Juega_objtyp(30, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Tchouameni')),
                        Juega_objtyp(45, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Goes')),
                        Juega_objtyp(0, 90, 1, 1, 1, 50, 21, 50, 10, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Guarro')),
                        Juega_objtyp(90, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Alaba')),
                                               
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'ter Stegen')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Araujo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alonso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'García')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alba')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Busquets')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'González')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Roberto')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dembélé')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Lewandowski')),
                        Juega_objtyp(90, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Torres')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Dias'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));

/
UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 10, 'Modric', 49, 46))
WHERE ID_Partido = 106;
/
INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (107, SYSDATE, 16,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'),
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Santiago Bernabéu'),
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Courtois')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Carvajal')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Kroos')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Modric')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Vallejo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Odriozola')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Fernández')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Camavinga')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Tchouameni')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Goes')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Oliveira')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Díaz')),
                                               
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'ter Stegen')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Araujo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alonso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'García')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alba')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Busquets')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'González')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Roberto')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dembélé')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Lewandowski')),
                        Juega_objtyp(0, 90, 1, 1, 1, 82, 52, 82, 10, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Owebebubuwewe')),
                        Juega_objtyp(0, 90, 1, 1, 1, 81, 51, 81, 10, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Money'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));
/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 20, 'Money', 46, 47))
WHERE ID_Partido = 107;
/

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (108, SYSDATE, 13,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Atlético de Madrid'), 
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Santiago Bernabéu'),
            nt_juega_typ(
                       Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Courtois')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Carvajal')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Kroos')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Modric')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Vallejo')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Odriozola')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Fernández')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Camavinga')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Tchouameni')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Goes')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Oliveira')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Díaz')),


                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Oblak')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Hermoso')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Giménez')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Savic')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Molina')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Paul')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Llorente')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Resurrección')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Depay')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Morata')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Griezmann')),
                        Juega_objtyp(0, 90, 1, 1, 1, 81, 51, 81, 10, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Gitanov'))
                                               
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));
/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 10, 'Griezmann', 46, 46))
WHERE ID_Partido = 108;

--CONSULTAS MANOLETE

--Jugador del Real Madrid de nacionalidad brasileña que más goles ha marcado en el Santiago Bernabéu
CREATE OR REPLACE VIEW PichichiEnElBernabeu AS(
SELECT j.Nombre, j.Apellido1 AS Apellido,
SUM(Goles) AS NumeroGoles
FROM Partido_objtab p, TABLE(p.jugadores), Jugador_objtab j
WHERE DEREF(jugador).Id_persona = j.ID_Persona
    AND (DEREF(p.Estadio_partido).Nombre = 'Santiago Bernabéu')
    AND (DEREF(jugador).Pais = (SELECT REF(pa) FROM Pais_objtab pa WHERE pa.Nombre = 'Brasil'))
    AND (DEREF(jugador).Equipo = (SELECT REF(eq) FROM Equipo_objtab eq WHERE eq.Nombre = 'Real Madrid CF'))
GROUP BY j.ID_persona, j.Nombre, j.Apellido1
HAVING SUM(Goles) > 0
ORDER BY NumeroGoles DESC
FETCH FIRST 5 ROWS ONLY);

--Estadio en el que más veces un equipo visitante ha perdido marcando al menos un gol en la Liga Santander
CREATE OR REPLACE VIEW EstadioDerrotasVisitantes AS(
SELECT es.Nombre,
COUNT(*) AS Derrotas_Visitantes
FROM Estadio_objtab es, Partido_objtab p
WHERE DEREF(p.Estadio_partido).Nombre = es.Nombre 
    AND (p.Resultado.GolesVisitante > 1)
    AND (p.Resultado.GolesVisitante < p.Resultado.GolesLocal)
    AND (DEREF(p.Equipo_visitante).Liga = (SELECT REF(l) FROM LigaFutbol_objtab l WHERE l.Pais = (SELECT REF(pa) FROM Pais_objtab pa WHERE pa.Nombre = 'España') AND Division = 1))
    AND (DEREF(p.Equipo_local).Liga = (SELECT REF(l) FROM LigaFutbol_objtab l WHERE l.Pais = (SELECT REF(pa) FROM Pais_objtab pa WHERE pa.Nombre = 'España') AND Division = 1))
GROUP BY es.Nombre
ORDER BY Derrotas_Visitantes DESC
FETCH FIRST 1 ROWS ONLY);

--TOP Equipos visitantes con más amonestaciones en un partido que han ganado
CREATE OR REPLACE VIEW EquiposVisitantesAmonestaciones AS
SELECT DEREF(p.Equipo_visitante).Nombre AS Equipo, 
SUM(TarjetaRoja+TarjetaAmarilla1+TarjetaAmarilla2) AS Amonestaciones,
DEREF(p.Estadio_partido).Nombre AS Estadio
FROM Partido_objtab p, TABLE(p.jugadores) pj, Jugador_objtab j
WHERE pj.Jugador = REF(j)
    AND (j.Equipo = p.Equipo_visitante)
    AND (p.Resultado.GolesVisitante > p.Resultado.GolesLocal)
GROUP BY p.Id_partido, DEREF(p.Estadio_partido).Nombre, DEREF(p.Equipo_visitante).Nombre
ORDER BY Amonestaciones DESC;
