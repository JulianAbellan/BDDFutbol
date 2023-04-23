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

DROP SEQUENCE Seq_Clasif;


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
    MinutosJugados NUMBER(10),
    GolesTotales NUMBER(3),
    Equipo REF Equipo_objtyp,
    Historial REF Historial_objtyp
);
/
CREATE OR REPLACE TYPE Arbitro_objtyp UNDER Persona_objtyp(
    RolPrincipal VARCHAR2(35)
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
    MVP NUMBER(5),
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
    TarjetasRojas NOT NULL,
    TarjetasAmarillas NOT NULL,
    PartidosJugados NOT NULL,
    MinutosJugados NOT NULL,
    GolesTotales NOT NULL,
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
INSERT INTO Pais_objtab VALUES('Noruega', 'Europa');/
INSERT INTO Pais_objtab VALUES('Escocia', 'Europa');/
INSERT INTO Pais_objtab VALUES('Egipto', 'África');/
INSERT INTO Pais_objtab VALUES('Senegal', 'Africa');
INSERT INTO Pais_objtab VALUES('Rumania', 'Europa');


INSERT INTO LigaFutbol_objtab VALUES (
    1, -- ID_liga
    'LaLiga Santander', -- Nombre
    1, -- División
    (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España') -- Pais
);
/

INSERT INTO LigaFutbol_objtab VALUES (
    2, -- ID_liga
    'Premier League', -- Nombre
    1, -- División
    (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Inglaterra') -- Pais
);
/



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
INSERT INTO presidente_objtab (id_persona, nombre, apellido1, apellido2, edad, aval, pais)
    VALUES (202, 'Manu', 'Pelao', 'Master', 50, 'UCLM', (SELECT REF(p) FROM pais_objtab p WHERE p.nombre = 'España'));
/
INSERT INTO presidente_objtab (id_persona, nombre, apellido1, apellido2, edad, aval, pais)
    VALUES (203, 'Julian', 'Llorica', 'Master', 58, 'UCLM', (SELECT REF(p) FROM pais_objtab p WHERE p.nombre = 'España'));
/

INSERT INTO club_objtab (id_club, nombre, presupuesto, preside)
    VALUES (100, 'FC Barcelona', 100000000,
            Preside_objtyp(SYSDATE, null,
            (SELECT REF(pr) FROM presidente_objtab pr WHERE pr.id_persona = '200'))
            );/
INSERT INTO club_objtab (id_club, nombre, presupuesto, preside)
    VALUES (101, 'Real Madrid CF', 200000000,
             Preside_objtyp(SYSDATE, null,
                (SELECT REF(pr) FROM presidente_objtab pr WHERE pr.id_persona = '201'))
    );/
INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (102, 'Atlético de Madrid', 100000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (103, 'Valencia CF', 80000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (104, 'Sevilla CF', 80000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (105, 'Real Betis Balompié', 60000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (200, 'City Group', 400000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (201, 'Manchester United', 200000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (202, 'Liverpool', 100000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (203, 'Arsenal', 200000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (204, 'Tottenham Hotspur FC', 100000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (205, 'Chelsea FC', 400000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (300, 'AC Milan', 100000000);/

INSERT INTO club_objtab (id_club, nombre, presupuesto)
    VALUES (301, 'Inter de Milano', 100000000);/


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
INSERT INTO preside_objtab (presidente, fechaposesion, FechaCese)
    VALUES ((SELECT REF(p) FROM presidente_objtab p WHERE p.apellido1 = 'Pelao'), '22/04/22', '22/04/23');
/
INSERT INTO preside_objtab (presidente, fechaposesion, FechaCese)
    VALUES ((SELECT REF(p) FROM presidente_objtab p WHERE p.apellido1 = 'Llorica'), '22/04/21', '22/04/23');
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

INSERT INTO Entrenador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, FueJugador, Pais)
VALUES (119, 'Josep', 'Guardiola', 'Sala', 52, 1, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'));
/

INSERT INTO Entrenador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, FueJugador, Pais)
VALUES (120, 'Jürgen', 'Klopp', null, 45, 0, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Alemania'));
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

INSERT INTO equipo_objtab (id_equipo, nombre, numerotitulos, presupuesto, club, estadio, entrenador, liga)
    VALUES (4, 'Manchester City', 8, 1200000, (SELECT REF(c) FROM club_objtab c WHERE c.nombre = 'Manchester City'),
            (SELECT REF(e) FROM estadio_objtab e WHERE e.nombre = 'Metropolitano'),
            (SELECT REF(e) FROM entrenador_objtab e WHERE e.nombre like 'Josep'),
            (SELECT REF(l) FROM ligafutbol_objtab l WHERE l.nombre like 'Premier League'));
/

INSERT INTO equipo_objtab (id_equipo, nombre, numerotitulos, presupuesto, club, estadio, entrenador, liga)
    VALUES (5, 'Liverpool', 19, 800000, (SELECT REF(c) FROM club_objtab c WHERE c.nombre = 'Liverpool'),
            (SELECT REF(e) FROM estadio_objtab e WHERE e.nombre = 'Anfield'),
            (SELECT REF(e) FROM entrenador_objtab e WHERE e.nombre like 'Jürgen'),
            (SELECT REF(l) FROM ligafutbol_objtab l WHERE l.nombre like 'Premier League'));
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (100, 'Thibaut', 'Courtois', null, 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Bélgica'), 1, 'Portero', 9000000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (101, 'Daniel', 'Carvajal', 'Ramos', 31,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    2, 'Defensa', 6500000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (102, 'Jesús', 'Vallejo', 'Lázaro', 27,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    5, 'Defensa', 3000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (103, 'José Ignacio', 'Fernández', 'Iglesias', 33,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    6, 'Defensa', 5000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (104, 'Álvaro', 'Odriozola', 'Pérez', 28,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    16, 'Defensa', 1000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (105, 'Lucas', 'Vázquez', 'Iglesias', 32,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
    17, 'Defensa', 3000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
 /  

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (106, 'Toni', 'Kroos', null , 33,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Alemania'),
    8, 'Centrocampista', 7000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/
   
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (107, 'Luka', 'Modric', null , 38,
    (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Croacia'),
    10, 'Centrocampista', 8000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (108, 'Vinicius', 'de Oliveira', 'Junior' , 23 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'),
     20, 'Delantero', 8000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
VALUES (109, 'Rodrygo', 'Goes', null , 22 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'),
     21, 'Delantero', 8500000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
VALUES (110, 'Mariano', 'Díaz', 'Mejía' , 30 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'España'),
     24, 'Delantero', 1200000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
VALUES (111, 'Eduardo', 'Camavinga', null, 21 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Francia'),
     12, 'Centrocampista', 5500000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
VALUES (112, 'Aurélien ', 'Tchouameni', null, 23 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Francia'),
     18, 'Centrocampista', 6000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
VALUES (113, 'Éder', 'Gabriel', 'Militão', 25 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'),
     3, 'Defensa', 7800000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
VALUES (114, 'Antonio ', 'Rüdiger  ', null , 22 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Alemania'),
     22, 'Defensa',6500000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);
/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
VALUES (115, 'David  ', 'Alaba', null , 31 , (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Austria'),
     4, 'Defensa', 8000000, (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (2000, 'Morris', 'Escocio', null, 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'), 99, 'Delantero', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 2, 90, 3);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (2001, 'Raul', 'Pelao', 'Jr', 37, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'), 90, 'Delantero', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 2, 90, 4);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES (2010, 'Pepe', 'Guarro', 'Marrano', 22, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Portugal'), 90, 'Defensa', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 1, 2, 1, 90, 10);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados, TarjetasRojas, TarjetasAmarillas)
    VALUES (2003, 'Pedro Morrongo', 'Moya', 'Toya', 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Brasil'), 89, 'Delantero', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 3, 1, 90, 0, 0);
/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(50, 'Marc-André', 'ter Stegen', null, 30, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Alemania'), 1, 'Portero', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(51, 'Ronald', 'Araujo', 24, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Uruguay'), 4, 'Defensa', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(52, 'Andreas', 'Christensen', 27, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Dinamarca'), 15, 'Defensa', 6000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(53, 'Marcos', 'Alonso', 'Mendoza', 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 17, 'Defensa', 5000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(54, 'Jules', 'Olivier', 'Koundé', 24, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Francia'), 23, 'Defensa', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(55, 'Eric', 'García', 'Martret', 22, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 24, 'Defensa', 3000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(56, 'Jordi', 'Alba', 'Ramos', 33, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 18, 'Defensa', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(57, 'Sergio', 'Busquets', 'Burgos', 34, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 5, 'Centrocampista', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(58, 'Pablo', 'Martín', 'Gavira', 18, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 6, 'Centrocampista', 6500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(59, 'Pedro', 'González', 'López', 20, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 8, 'Centrocampista', 9500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(60, 'Frenkie', 'de Jong', 25, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Países Bajos'), 21, 'Centrocampista', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(61, 'Sergi', 'Roberto', 'Carnicer', 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 20, 'Centrocampista', 6500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(62, 'Ousmane', 'Dembélé', null, 25, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Francia'), 7, 'Delantero', 9500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(63, 'Robert', 'Lewandowski', 34, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Polonia'), 9, 'Delantero', 11000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(64, 'Anssumane', 'Fati', 'Vieira', 20, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 10, 'Delantero', 7500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(65, 'Ferran', 'Torres', 'García', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 11, 'Delantero', 6500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(67, 'Raphael', 'Dias', 'Belloli', 26, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Brasil'), 22, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/




INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(66, 'Ignacio', 'Peña', 'Sotorres', 24, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 13, 'Portero', 1500000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados, TarjetasRojas, TarjetasAmarillas)
    VALUES (2005, 'Mamalu Sebastian', 'Owebebubuwewe', 'Osas',21, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Rumania'), 90, 'Defensa', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 10, 1, 90, 1, 2);
/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados, TarjetasRojas, TarjetasAmarillas)
    VALUES (2006, 'Lorey', 'Money',30, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Senegal'), 90, 'Defensa', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 10, 1, 90, 1, 2);
/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(70, 'Jan', 'Oblak', null , 30, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Eslovenia'), 13, 'Portero', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(71, 'José', 'Giménez', 'López' , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Uruguay'), 2, 'Defensa', 5000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(72, 'Mario', 'Hermoso', null , 27, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 22, 'Defensa', 2000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(73, 'Stefan', 'Savic', null , 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Eslovenia'), 15, 'Defensa', 3000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(74, 'Nahuel', 'Molina', null , 25, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Argentina'), 16, 'Defensa', 3000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(75, 'Rodrigo', 'de Paul', null , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Argentina'), 5, 'Centrocampista', 3000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(76, 'Koke', 'Resurrección', null , 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 6, 'Centrocampista', 4000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(77, 'Marcos', 'Llorente', null , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 14, 'Centrocampista', 6000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(78, 'Álvaro', 'Morata', null , 30, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 19, 'Delantero', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(79, 'Antoine', 'Griezmann', null , 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Francia'), 8, 'Delantero', 10000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(80, 'Memphis', 'Depay', null , 29, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Países Bajos'), 9, 'Delantero', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/


INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(81, 'Ángel', 'Correa', null , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Argentina'), 10, 'Delantero', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, GolesTotales, PartidosJugados, MinutosJugados, TarjetasRojas, TarjetasAmarillas)
    VALUES (2004, 'Dimitri', 'Popescu', 'Cobrerrobado',37, (SELECT REF(p) FROM Pais_objtab p WHERE p.nombre = 'Rumania'), 90, 'Defensa', 1000,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Atlético de Madrid'), 10, 1, 90, 1, 2);
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(82, 'Ederson', 'Santana', 'Moraes' , 29, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Brasil'), 31, 'Portero', 10000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(83, 'Rúben', 'Dias', 'Alves' , 25, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 6, 'Defensa', 10000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(84, 'Nathan', 'Aké', null , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Países Bajos'), 3, 'Defensa', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(85, 'Aymeric', 'Laporte', null , 28, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 14, 'Defensa', 10000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(86, 'Kyle', 'Walker', null , 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Inglaterra'), 2, 'Defensa', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(87, 'Kevin', 'de Bruyne', null , 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Bélgica'), 17, 'Centrocampista', 12000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(88, 'Bernando', 'Silva', 'dos Santos' , 30, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 20, 'Centrocampista', 12000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(89, 'Ilkay', 'Gündogan', null , 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Alemania'), 8, 'Centrocampista', 11000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(90, 'Phil', 'Foden', null , 22, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Inglaterra'), 47, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(91, 'Erling', 'Haaland', null , 22, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Noruega'), 9, 'Delantero', 15000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(92, 'Jack', 'Grealish', null , 27, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Inglaterra'), 10, 'Delantero', 10000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(93, 'Julián', 'Álvarez', 'Frías' , 21, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Argentina'), 19, 'Delantero', 6000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Manchester City'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(94, 'Alisson', 'Becker', 'Gonçalves' , 30, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Brasil'), 19, 'Portero', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(95, 'Virgil', 'van Dijk', null , 31, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Países Bajos'), 19, 'Defensa', 10000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(96, 'Joe', 'Gomez', null , 25, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Inglaterra'), 2, 'Defensa', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(97, 'Trent', 'Alexander-Arnold', null , 24, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Inglaterra'), 66, 'Defensa', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(98, 'Ibrahima', 'Konaté', null , 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Francia'), 5, 'Defensa', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(99, 'Andrew', 'Robertson', null , 29, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Escocia'), 26, 'Defensa', 9000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1000, 'Thiago', 'Alcántara', 'Rivera' , 32, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'España'), 6, 'Centrocampista', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(10001, 'Curtis', 'Jones', null, 22, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Inglaterra'), 17, 'Centrocampista', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1002, 'James', 'Milner', null, 37, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Inglaterra'), 7, 'Centrocampista', 8000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1003, 'Mohamed', 'Salah', null, 30, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Egipto'), 11, 'Centrocampista', 11000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1004, 'Darwin', 'Núñez', 'Olivera', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Uruguay'), 27, 'Delantero', 10000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1005, 'Diogo', 'Jota', 'Alves', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 20, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Liverpool'), 0, 0, 0, 0, 0
);/




-----------TRIGGERS JULIAN


--___________________________________________________________________________________

-- DISPARADORES DE JULIÁN

--___________________________________________________________________________________



-- Disparador para mantener la tabla Clasificación actualizada en todo momento



CREATE SEQUENCE Seq_Clasif  INCREMENT BY 1 START WITH 10 MAXVALUE 9999 CACHE 15 NOCYCLE;
/
CREATE OR REPLACE FUNCTION CalculoTemp (Fecha IN DATE) RETURN VARCHAR2 AS

    VYear NUMBER(4);
    VMes NUMBER(2);
BEGIN
    SELECT EXTRACT(year FROM Fecha), EXTRACT(month FROM Fecha) INTO VYear, VMes FROM DUAL;

    IF VMes > 7 THEN 
        RETURN '' || VYear || '-' || (VYear+1)MOD 2000;
    ELSIF VMes < 7 THEN
        RETURN '' || VYear-1 || '-' || (VYear)MOD 2000;
    ELSE RAISE_APPLICATION_ERROR('-20001','No puede haber partidos en julio, porque hay vacaciones obligatorias');
    END IF;

END;
/

CREATE OR REPLACE PROCEDURE CheckExisteClasif(VEquipo in Equipo_objtab.nombre%type, VTemp in Clasificacion_objtab.Temporada%type) 
IS
    VID Clasificacion_objtab.ID_clasificacion%type;
BEGIN
    SELECT c.ID_clasificacion INTO VID
    FROM Clasificacion_objtab c
    WHERE c.Equipo = (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = VEquipo);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    IF VID IS NULL THEN
        INSERT INTO clasificacion_objtab (id_clasificacion, temporada, puntos, partidosganados, partidosperdidos, partidosempatados, golesfavor, golescontra, equipo, liga)
        VALUES (Seq_Clasif.NEXTVAL, VTemp, 0, 0, 0, 0, 0, 0,
            (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre LIKE VEquipo),
            (SELECT e.liga FROM equipo_objtab e WHERE e.nombre = VEquipo)
            );
    END IF;
END;
/

/*
CREATE OR REPLACE TRIGGER Clasificacion_Trigger
AFTER INSERT OR DELETE OR UPDATE ON Partido_objtab
FOR EACH ROW
DECLARE
    VGolesLocal Partido_objtab.Resultado.GolesLocal%Type;
    VGolesVisitante Partido_objtab.Resultado.GolesVisitante%Type;
    VTemporada Clasificacion_objtab.Temporada%TYPE;
    VPuntos Clasificacion_objtab.Puntos%TYPE;
    VPG clasificacion_objtab.partidosganados%TYPE;
    VPE clasificacion_objtab.partidosempatados%TYPE;
    VPP clasificacion_objtab.partidosperdidos%TYPE;
    VNLocal equipo_objtab.nombre%type;
    VNVisitante equipo_objtab.nombre%type;
BEGIN

    SELECT CalculoTemp(:NEW.Fecha) INTO VTemporada FROM DUAL;
    
    SELECT DEREF(:NEW.Equipo_local).Nombre, DEREF(:NEW.Equipo_visitante).Nombre 
    INTO VNLocal, VNVisitante
    FROM DUAL;

    CheckExisteClasif(VNLocal, VTemporada);
    CheckExisteClasif(VNVisitante, VTemporada);
    

    SELECT SUM(Goles) INTO VGolesLocal
    FROM Partido_objtab p, TABLE(p.jugadores), Jugador_objtab j
    WHERE jugador = REF(j) AND j.Equipo = :NEW.Equipo_local AND p.ID_partido = :NEW.ID_partido;

    SELECT SUM(Goles) INTO VGolesVisitante
    FROM Partido_objtab p, TABLE(p.jugadores), Jugador_objtab j
    WHERE jugador = REF(j) AND j.Equipo = :NEW.Equipo_visitante AND p.ID_partido = :NEW.ID_partido;

    
    :NEW.Resultado := Resultado_objtyp(VGolesLocal, VGolesVisitante, null, null, null);
    

    SELECT c.GolesFavor + :NEW.Resultado.GolesLocal, c.GolesContra + :NEW.Resultado.GolesVisitante INTO VGF, VGC
    FROM Clasificacion_objtab c
    WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada;

    UPDATE Clasificacion_objtab c
    SET c.GOlesFavor = VGF, c.GolesContra = VGC
    WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada; 

    SELECT c.GolesFavor + :NEW.Resultado.GolesVisitante, c.GolesContra + :NEW.Resultado.GolesLocal INTO VGF, VGC
    FROM Clasificacion_objtab c
    WHERE c.Equipo = :NEW.Equipo_Visitante AND c.Temporada = VTemporada;

    UPDATE Clasificacion_objtab c
    SET c.GOlesFavor = VGF, c.GolesContra = VGC
    WHERE c.Equipo = :NEW.Equipo_visitante AND c.Temporada = VTemporada; 

    IF :NEW.Resultado.GolesLocal > :NEW.Resultado.GolesVisitante THEN
        SELECT c.Puntos + 3 INTO VPuntos FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada;
        SELECT c.PartidosGanados + 1 INTO VPG FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada;
        SELECT c.PartidosPerdidos + 1 INTO VPP FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_visitante AND c.Temporada = VTemporada;

        UPDATE Clasificacion_objtab c
        SET c.Puntos = VPuntos,
            c.PartidosGanados = VPG
        WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada;
        
        UPDATE Clasificacion_objtab c
        SET c.PartidosPerdidos = VPP
        WHERE c.Equipo = :NEW.Equipo_visitante AND c.Temporada = VTemporada;
  
    ELSIF :NEW.Resultado.GolesLocal < :NEW.Resultado.GolesVisitante THEN
        SELECT c.Puntos + 3 INTO VPuntos FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_visitante AND c.Temporada = VTemporada;
        SELECT c.PartidosGanados + 1 INTO VPG FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_visitante AND c.Temporada = VTemporada;
        SELECT c.PartidosPerdidos + 1 INTO VPP FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada;

        UPDATE Clasificacion_objtab c
        SET c.Puntos = VPuntos,
            c.PartidosGanados = VPG
        WHERE c.Equipo = :NEW.Equipo_visitante AND c.Temporada = VTemporada;
       
        UPDATE Clasificacion_objtab c
        SET c.PartidosPerdidos = VPP
        WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada;
    ELSE 
        SELECT c.Puntos + 1 INTO VPuntos FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_visitante AND c.Temporada = VTemporada;
        SELECT c.PartidosEmpatados + 1 INTO VPE FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_visitante AND c.Temporada = VTemporada;
        
        UPDATE Clasificacion_objtab c
        SET c.Puntos = VPuntos,
            c.PartidosEmpatados = VPE
        WHERE c.Equipo = :NEW.Equipo_visitante AND c.Temporada = VTemporada;
        
        SELECT c.Puntos + 1 INTO VPuntos FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada;
        SELECT c.PartidosEmpatados + 1 INTO VPE FROM Clasificacion_objtab c WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada;
        
        UPDATE Clasificacion_objtab c
        SET c.Puntos = VPuntos,
            c.PartidosEmpatados = VPE
        WHERE c.Equipo = :NEW.Equipo_local AND c.Temporada = VTemporada;
    END IF;
END;
    
/
*/

CREATE OR REPLACE TRIGGER Clasificacion_Trigger_C 
FOR INSERT ON Partido_objtab
COMPOUND TRIGGER
    TYPE TFecha IS TABLE OF Partido_objtab.Fecha%TYPE INDEX BY BINARY_INTEGER;
    VTFecha TFecha;
    TYPE TEL IS TABLE OF Partido_objtab.Equipo_local%TYPE INDEX BY BINARY_INTEGER;
    VTEL TEL;
    TYPE TEV IS TABLE OF Partido_objtab.Equipo_visitante%TYPE INDEX BY BINARY_INTEGER;
    VTEV TEV;
    TYPE TIDP IS TABLE OF Partido_objtab.ID_partido%TYPE INDEX BY BINARY_INTEGER;
    VTIDP TIDP;
    TYPE TResul IS TABLE OF Partido_objtab.Resultado%TYPE INDEX BY BINARY_INTEGER;
    VTResul TResul;
    IND BINARY_INTEGER:=0;
    VGolesLocal Partido_objtab.Resultado.GolesLocal%Type;
    VGolesVisitante Partido_objtab.Resultado.GolesVisitante%Type;
    VTemporada Clasificacion_objtab.Temporada%TYPE;
    VPuntos Clasificacion_objtab.Puntos%TYPE;
    VPG clasificacion_objtab.partidosganados%TYPE;
    VPE clasificacion_objtab.partidosempatados%TYPE;
    VPP clasificacion_objtab.partidosperdidos%TYPE;
    VNLocal equipo_objtab.nombre%type;
    VNVisitante equipo_objtab.nombre%type;
    VGC Clasificacion_objtab.GolesContra%TYPE;
    VGF Clasificacion_objtab.GolesFavor%TYPE;

BEFORE EACH ROW IS
BEGIN
    IND := IND + 1;
    VTFecha(IND) := :NEW.Fecha;
    VTEL(IND) := :NEW.Equipo_local;
    VTEV(IND) := :NEW.Equipo_visitante;
    VTIDP(IND) := :NEW.ID_partido;
    VTResul(IND) := :NEW.Resultado;
END BEFORE EACH ROW;

AFTER STATEMENT IS
BEGIN
    FOR i IN 1..IND LOOP
        SELECT CalculoTemp(VTFecha(i)) INTO VTemporada FROM DUAL;
    
        SELECT DEREF(VTEL(i)).Nombre, DEREF(VTEV(i)).Nombre 
        INTO VNLocal, VNVisitante
        FROM DUAL;

        CheckExisteClasif(VNLocal, VTemporada);
        CheckExisteClasif(VNVisitante, VTemporada);
    

        SELECT SUM(Goles) INTO VGolesLocal
        FROM Partido_objtab p, TABLE(p.jugadores), Jugador_objtab j
        WHERE jugador = REF(j) AND j.Equipo = VTEL(i) AND p.ID_partido = VTIDP(i);

    
        SELECT SUM(Goles) INTO VGolesVisitante
        FROM Partido_objtab p, TABLE(p.jugadores), Jugador_objtab j
        WHERE jugador = REF(j) AND j.Equipo = VTEV(i) AND p.ID_partido = VTIDP(i);

        VTResul(i) := Resultado_objtyp(VGolesLocal, VGolesVisitante, null, null, null);
        
        UPDATE Partido_objtab p
        SET p.Resultado = VTResul(i)
        WHERE p.ID_Partido = VTIDP(i);

        SELECT c.GolesFavor + VTResul(i).GolesLocal, c.GolesContra + VTResul(i).GolesVisitante INTO VGF, VGC
        FROM Clasificacion_objtab c
        WHERE c.Equipo = VTEL(i) AND c.Temporada = VTemporada;

        UPDATE Clasificacion_objtab c
        SET c.GOlesFavor = VGF, c.GolesContra = VGC
        WHERE c.Equipo = VTEL(i)  AND c.Temporada = VTemporada; 

        SELECT c.GolesFavor + VTResul(i).GolesVisitante, c.GolesContra + VTResul(i).GolesLocal INTO VGF, VGC
        FROM Clasificacion_objtab c
        WHERE c.Equipo = VTEV(i)  AND c.Temporada = VTemporada;

        UPDATE Clasificacion_objtab c
        SET c.GOlesFavor = VGF, c.GolesContra = VGC
        WHERE c.Equipo = VTEV(i)  AND c.Temporada = VTemporada; 

        IF VTResul(i).GolesLocal > VTResul(i).GolesVisitante THEN
            SELECT c.Puntos + 3 INTO VPuntos FROM Clasificacion_objtab c WHERE c.Equipo = VTEL(i) AND c.Temporada = VTemporada;
            SELECT c.PartidosGanados + 1 INTO VPG FROM Clasificacion_objtab c WHERE c.Equipo = VTEL(i) AND c.Temporada = VTemporada;
            SELECT c.PartidosPerdidos + 1 INTO VPP FROM Clasificacion_objtab c WHERE c.Equipo = VTEV(i) AND c.Temporada = VTemporada;

            UPDATE Clasificacion_objtab c
            SET c.Puntos = VPuntos,
                c.PartidosGanados = VPG
            WHERE c.Equipo = VTEL(i) AND c.Temporada = VTemporada;
        
            UPDATE Clasificacion_objtab c
            SET c.PartidosPerdidos = VPP
            WHERE c.Equipo = VTEV(i) AND c.Temporada = VTemporada;
  
            ELSIF VTResul(i).GolesLocal < VTResul(i).GolesVisitante THEN
            SELECT c.Puntos + 3 INTO VPuntos FROM Clasificacion_objtab c WHERE c.Equipo = VTEV(i) AND c.Temporada = VTemporada;
            SELECT c.PartidosGanados + 1 INTO VPG FROM Clasificacion_objtab c WHERE c.Equipo = VTEV(i) AND c.Temporada = VTemporada;
            SELECT c.PartidosPerdidos + 1 INTO VPP FROM Clasificacion_objtab c WHERE c.Equipo = VTEL(i) AND c.Temporada = VTemporada;

            UPDATE Clasificacion_objtab c
            SET c.Puntos = VPuntos,
                c.PartidosGanados = VPG
            WHERE c.Equipo = VTEV(i) AND c.Temporada = VTemporada;
       
            UPDATE Clasificacion_objtab c
            SET c.PartidosPerdidos = VPP
            WHERE c.Equipo = VTEL(i) AND c.Temporada = VTemporada;
        ELSE 
            SELECT c.Puntos + 1 INTO VPuntos FROM Clasificacion_objtab c WHERE c.Equipo = VTEV(i) AND c.Temporada = VTemporada;
            SELECT c.PartidosEmpatados + 1 INTO VPE FROM Clasificacion_objtab c WHERE c.Equipo = VTEV(i) AND c.Temporada = VTemporada;
        
            UPDATE Clasificacion_objtab c
            SET c.Puntos = VPuntos,
                c.PartidosEmpatados = VPE
            WHERE c.Equipo = VTEV(i) AND c.Temporada = VTemporada;
        
            SELECT c.Puntos + 1 INTO VPuntos FROM Clasificacion_objtab c WHERE c.Equipo = VTEL(i) AND c.Temporada = VTemporada;
            SELECT c.PartidosEmpatados + 1 INTO VPE FROM Clasificacion_objtab c WHERE c.Equipo = VTEL(i) AND c.Temporada = VTemporada;
        
            UPDATE Clasificacion_objtab c
            SET c.Puntos = VPuntos,
                c.PartidosEmpatados = VPE
            WHERE c.Equipo = VTEL(i) AND c.Temporada = VTemporada;
        END IF;

    END LOOP;
END AFTER STATEMENT;
END;
/


INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (1, SYSDATE, 16,
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
            ));/




INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (2, SYSDATE, 21,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'), 
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Santiago Bernabéu'),
 
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
                        Juega_objtyp(45, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Dias' AND j.Nombre = 'Raphael'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));/






INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (3, SYSDATE, 13,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'FC Barcelona'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Atlético de Madrid'),
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Spotify Camp Nou'),              
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
                        Juega_objtyp(45, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Dias' AND j.Nombre = 'Raphael')),


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
            ));/
           
INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (4, '11/11/2022', 12,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Real Madrid CF'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Atlético de Madrid'),  
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Santiago Bernabéu'),
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
            ));/

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (5, SYSDATE, 20,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Manchester City'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Liverpool'),            
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Etihad Stadium'),
            nt_juega_typ(
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Ederson')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dias' AND j.Nombre = 'Rúben')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Aké')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Laporte')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Walker')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Bruyne')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Gündogan')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Silva')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 3, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Haaland')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Foden')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Álvarez')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Grealish')),
                     


                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Becker')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'van Dijk')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Konaté')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Robertson')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alexander-Arnold')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 2, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alcántara')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Milner')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Jones')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Núñez')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Salah')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Jota'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));/

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante,Estadio_partido, jugadores, arbitros)
    VALUES (6, SYSDATE, 12,
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Liverpool'),
            (SELECT REF(e) FROM Equipo_objtab e WHERE e.Nombre = 'Manchester City'),
            (SELECT REF (e) FROM Estadio_objtab e WHERE e.Nombre = 'Anfield'),

            nt_juega_typ(
                         Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Becker')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'van Dijk')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Konaté')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Robertson')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alexander-Arnold')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Alcántara')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Milner')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Jones')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Núñez')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Salah')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Jota')),
                     

                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Ederson')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Dias' AND j.Nombre = 'Rúben')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Aké')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Laporte')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Walker')),
                        Juega_objtyp(0, 60, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'de Bruyne')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Gündogan')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Silva')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Haaland')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Foden')),
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 1, (SELECT REF(j) FROM Jugador_objtab j WHERE j.Apellido1 = 'Álvarez')),
                        Juega_objtyp(60, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Grealish'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));/


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
                        Juega_objtyp(0, null, 0, 0, 0, null, null, null, 0, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Dias' AND j.Nombre = 'Rúben'))
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));
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

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (108, '12/12/2022', 13,
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
                        Juega_objtyp(0, 90, 1, 1, 1, 81, 51, 81, 10, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Popescu'))
                                               
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));
/

--CONSULTAS DE JULIÁN

--Muestra los 5 jugadores con más premios al jugador del partido


CREATE OR REPLACE VIEW Top5MVP AS(
SELECT j.Nombre AS NombreJugador, j.Apellido1 AS ApellidoJugador, COUNT(*) AS NumeroMVPS, j.Equipo.Nombre as Equipo
FROM Partido_objtab p, Jugador_objtab j
GROUP BY p.Resultado.MVP, j.ID_Persona, j.Equipo.Nombre, j.Apellido1, j.Nombre
HAVING j.ID_persona = p.Resultado.MVP
ORDER BY NumeroMVPS DESC
FETCH FIRST 5 ROWS ONLY);

SELECT * FROM TOP5MVP;/

--Muestra los porteros con más porterías imbatidas


CREATE OR REPLACE VIEW MasPorteriasImbatidas AS
SELECT j.Nombre, j.Apellido1 AS Apellido, DEREF(j.Equipo).Nombre AS Equipo, COUNT(*) AS PorteriasImbatidas
FROM Partido_objtab p, TABLE(p.jugadores), Jugador_objtab j
WHERE DEREF(jugador).Id_persona = j.ID_Persona
    AND j.Posicion = 'Portero'
    AND ((j.Equipo = p.Equipo_local AND p.Resultado.GolesVisitante = 0) OR (j.Equipo = p.Equipo_visitante AND p.Resultado.GolesLocal = 0))
GROUP BY j.Id_persona, j.Nombre, j.Apellido1, DEREF(j.Equipo).Nombre
ORDER BY PorteriasImbatidas DESC;/

SELECT * FROM MasPorteriasImbatidas;/

--Muestra la tabla de goleadores de la primera división española


CREATE OR REPLACE VIEW TablaPichichisLaLiga AS
SELECT j.Nombre, j.Apellido1 AS Apellido, SUM(Goles) AS TotalGoles
FROM Partido_objtab p, TABLE(p.jugadores), Jugador_objtab j
WHERE DEREF(jugador).Id_persona = j.ID_Persona
    AND (DEREF(p.Equipo_local).Liga = (SELECT REF(l) FROM LigaFutbol_objtab l WHERE l.Pais = (SELECT REF(pa) FROM Pais_objtab pa WHERE pa.Nombre = 'España') AND Division = 1))
    AND (DEREF(p.Equipo_visitante).Liga = (SELECT REF(l) FROM LigaFutbol_objtab l WHERE l.Pais = (SELECT REF(pa) FROM Pais_objtab pa WHERE pa.Nombre = 'España') AND Division = 1))
GROUP BY j.ID_Persona, j.Nombre, j.Apellido1
HAVING SUM(Goles) > 0
ORDER BY TotalGoles DESC;/


SELECT * FROM TablaPichichisLaLiga;/


--PROCEDIMIENTOS DE JULIÁN

--Dada un país y una división, muestra todos los equipos con el listado de sus respectivos jugadores

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE InfoLiga (p_pais in Pais_objtab.nombre%type, p_div in LigaFutbol_objtab.Division%type)
IS
    TYPE Eq_tab IS TABLE OF REF Equipo_objtyp;
    TEquipos Eq_tab;
    VNombre Equipo_objtab.nombre%type;
BEGIN

    IF p_pais IS null THEN 
        RAISE_APPLICATION_ERROR(-20001, 'El parámetro "país" no puede ser nulo');
    END IF;

    IF p_div IS null THEN 
        RAISE_APPLICATION_ERROR(-20002, 'El parámetro "división" no puede ser nulo');
    END IF;

    SELECT REF(e) BULK COLLECT INTO TEquipos
    FROM Equipo_objtab e
    WHERE Liga = (SELECT REF(l) 
                FROM LigaFutbol_objtab l
                WHERE l.Pais = (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = p_pais)
                AND l.Division = p_div);
    
    DBMS_OUTPUT.PUT_LINE('========================================================');        
    DBMS_OUTPUT.PUT_LINE('LISTA DE LOS EQUIPOS DE LA ' || p_div || ' DIVISION DE ' || UPPER(p_pais));
    DBMS_OUTPUT.PUT_LINE('========================================================');
    
    
    FOR i IN 1..TEquipos.COUNT LOOP
        SELECT DEREF(TEquipos(i)).Nombre INTO VNombre FROM DUAL;
        DBMS_OUTPUT.PUT_LINE('========================================================');        
        DBMS_OUTPUT.PUT_LINE('EQUIPO: ' ||  VNOMBRE);
        DBMS_OUTPUT.PUT_LINE('========================================================');

        FOR VJugador IN (SELECT *
                        FROM Jugador_objtab 
                        WHERE Equipo = TEquipos(i)) LOOP

                            IF VJugador.Apellido2 IS NULL THEN 
                                DBMS_OUTPUT.PUT_LINE(' - ' || VJugador.Nombre || ' ' || VJugador.Apellido1);
                            ELSE
                                DBMS_OUTPUT.PUT_LINE(' - ' || VJugador.Nombre || ' ' || VJugador.Apellido1 || ' ' || VJugador.Apellido2);
                            END IF;
                        END LOOP;
        DBMS_OUTPUT.PUT_LINE(' ');

    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);

END;
/



EXECUTE InfoLiga('España', 1);
EXECUTE InfoLiga('Inglaterra', 1);



--Dado un país, dime el jugador con esa nacionalidad que más goles haya marcado en esa temporada


CREATE OR REPLACE PROCEDURE MaxGoleadorPaisTemporada (p_pais in Pais_objtab.nombre%type)
IS
    TYPE Jug_tab IS TABLE OF REF Jugador_objtyp;
    TJugadores Jug_tab;
    VGoles nt_juega_tab.Goles%type;
    VNombre Jugador_objtab.Nombre%type;
    VApellido1 Jugador_objtab.Apellido1%type;
    VApellido2 Jugador_objtab.Apellido2%type;
    VEquipo Equipo_objtab.Nombre%type;
BEGIN

    IF p_pais IS null THEN 
        RAISE_APPLICATION_ERROR(-20001, 'El parámetro "país" no puede ser nulo');
    END IF;

    SELECT REF(j) BULK COLLECT INTO TJugadores
    FROM Jugador_objtab j
    WHERE Pais = (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = p_pais);
    
    DBMS_OUTPUT.PUT_LINE('========================================================');        
    DBMS_OUTPUT.PUT_LINE('MOSTRANDO LA TABLA DE GOLEADORES DE ' || UPPER(p_pais));
    DBMS_OUTPUT.PUT_LINE('========================================================');
    
    


        FOR VJugador IN (SELECT *
                        FROM Jugador_objtab 
                        WHERE Pais = (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = p_pais) AND GolesTotales > 0 AND PartidosJugados > 0
                        ORDER BY GolesTotales DESC) LOOP

                            SELECT j.Nombre, j.Apellido1, j.Apellido2, DEREF(j.Equipo).Nombre, j.GolesTotales INTO VNombre, VApellido1, VApellido2, VEquipo, VGoles
                            FROM Jugador_objtab j
                            WHERE j.id_persona = VJugador.Id_persona;

                            IF VApellido2 IS NULL THEN 
                                DBMS_OUTPUT.PUT_LINE(' - ' || VJugador.Nombre || ' ' || VJugador.Apellido1 || ' (' || VEquipo || '): ' || VGoles);
                            ELSE
                                DBMS_OUTPUT.PUT_LINE(' - ' || VJugador.Nombre || ' ' || VJugador.Apellido1 || ' ' || VJugador.Apellido2 ||' (' || VEquipo || '): ' || VGoles);
                            END IF;
                        END LOOP;
        DBMS_OUTPUT.PUT_LINE(' ');


EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);

END;
/

SET SERVEROUTPUT ON;

EXECUTE MaxGoleadorPaisTemporada('Brasil');
EXECUTE MaxGoleadorPaisTemporada('España');
EXECUTE MaxGoleadorPaisTemporada('Francia');







 -------------------------------------------
------------ TRIGGERS MANU  ------------
--------------------------------------------

--TRIGGER 1

CREATE OR REPLACE TRIGGER trig_salario
FOR INSERT OR DELETE OR UPDATE ON Partido_objtab
COMPOUND TRIGGER
    TYPE T_ID IS TABLE OF Partido_objtab.ID_Partido%TYPE INDEX BY BINARY_INTEGER;
    V_ID T_ID;
    id_jugador Jugador_objtab.ID_Persona%TYPE;
    
    IND BINARY_INTEGER:=0;

BEFORE EACH ROW IS
BEGIN
    IND := IND + 1;
    V_ID(IND) := :NEW.ID_partido;
END BEFORE EACH ROW;

AFTER STATEMENT IS
BEGIN
   FOR I IN 1..IND LOOP 
        BEGIN
            SELECT j.Id_persona INTO id_jugador
            FROM Partido_objtab p, Jugador_objtab j
            WHERE p.Resultado.MVP = j.Id_persona
            AND  p.ID_partido = V_ID(i);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            id_jugador := NULL;
        END;
             
        IF id_jugador IS NOT NULL THEN
            UPDATE Jugador_objtab j
            SET j.Sueldo = j.Sueldo+500
            WHERE j.ID_persona = id_jugador;
        END IF;
    END LOOP;
    
END AFTER STATEMENT;
END trig_salario;
/

--TRIGGER 2

CREATE OR REPLACE TRIGGER trig_multa
FOR INSERT OR DELETE OR UPDATE ON Partido_objtab
COMPOUND TRIGGER
    TYPE T_ID IS TABLE OF Partido_objtab.ID_Partido%TYPE INDEX BY BINARY_INTEGER;
    IND BINARY_INTEGER:=0;

    V_Presupuesto club_objtab.presupuesto%TYPE;
    V_ID T_ID;

BEFORE EACH ROW IS
BEGIN
    IND:= IND + 1;
    V_ID(IND) := :NEW.ID_partido;

END BEFORE EACH ROW;

AFTER STATEMENT IS
BEGIN
    FOR k IN 1..IND LOOP
        FOR i IN (SELECT COUNT(*) AS Tarjetas, c.Nombre AS Club, c.Presupuesto AS presupuesto
        FROM partido_objtab p, table(p.jugadores) pj, jugador_objtab j, equipo_objtab e, club_objtab c
        WHERE pj.Jugador=REF(j) AND
        p.Id_partido = V_ID(k) AND
        (DEREF(p.Equipo_visitante).Nombre = e.Nombre OR
        DEREF(p.Equipo_local).Nombre = e.Nombre) AND
        DEREF(e.Club).Nombre = c.Nombre AND
        pj.TarjetaRoja = 1
        GROUP BY c.Nombre, c.Presupuesto) LOOP
            V_Presupuesto:=i.presupuesto;
            IF (V_Presupuesto - 100 >= 0) THEN
                UPDATE club_objtab c
                SET c.presupuesto = c.presupuesto - 100
                WHERE c.Nombre = i.Club;  
            END IF;
        END LOOP;
    END LOOP;

END AFTER STATEMENT;
END trig_multa;
/
INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (109, '09/11/2022', 13,
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
                        Juega_objtyp(0, 90, 1, 1, 1, 81, 51, 81, 10, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Popescu'))
                                               
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));
/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 10, 79, 46, 46))
WHERE ID_Partido = 109;
/

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (110, '11/12/2021', 13,
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
                        Juega_objtyp(0, 90, 1, 1, 1, 81, 51, 81, 10, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Popescu'))
                                               
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));
/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 10, 79, 46, 46))
WHERE ID_Partido = 110;
/

INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (111, SYSDATE, 13,
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
                        Juega_objtyp(0, 90, 1, 1, 1, 81, 51, 81, 10, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Popescu'))
                                               
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));
/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 10, 79, 46, 46))
WHERE ID_Partido = 111;
/



INSERT INTO Partido_objtab (ID_partido, Fecha, Hora, Equipo_local, Equipo_visitante, Estadio_partido, jugadores, arbitros)
    VALUES (112, '107/06/2021', 13,
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
                        Juega_objtyp(0, 90, 1, 1, 1, 81, 51, 81, 10, (SELECT REF(j) FROM Jugador_objtab j  WHERE j.Apellido1 = 'Popescu'))
                                               
            ),
            nt_arbitra_typ(
                        Arbitra_objtyp('Principal', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Gil')),
                        Arbitra_objtyp('Asistente adicional', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Lahoz')),
                        Arbitra_objtyp('Asistente', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Hernández')),
                        Arbitra_objtyp('Cuarto', (SELECT REF(a) FROM Arbitro_objtab A WHERE a.Apellido1 = 'Calvo'))
            ));
/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 10, 79, 46, 46))
WHERE ID_Partido = 112;
/


--------------------------------------------
--------- CONSULTAS MANU  --------------
--------------------------------------------

--Jugador del Real Madrid de nacionalidad brasileña que más goles ha marcado en el Santiago Bernabéu
CREATE OR REPLACE VIEW PichichiEnElBernabeu AS(
SELECT j.Nombre, j.Apellido1 AS Apellido,
SUM(Goles) AS NumeroGoles
FROM Partido_objtab p,TABLE(p.jugadores) pj, Jugador_objtab j
WHERE DEREF(pj.jugador).Id_persona = j.ID_Persona
    AND (DEREF(p.Estadio_partido).Nombre = 'Santiago Bernabéu')
    AND (DEREF(pj.jugador).Pais = (SELECT REF(pa) FROM Pais_objtab pa WHERE pa.Nombre = 'Brasil'))
    AND (DEREF(pj.jugador).Equipo = (SELECT REF(eq) FROM Equipo_objtab eq WHERE eq.Nombre = 'Real Madrid CF'))
GROUP BY j.ID_persona, j.Nombre, j.Apellido1
HAVING SUM(Goles) > 0
ORDER BY NumeroGoles DESC
FETCH FIRST 5 ROWS ONLY);

SELECT * FROM PichichiEnElBernabeu;

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

SELECT * FROM EstadioDerrotasVisitantes;

--TOP Equipos visitantes con más amonestaciones en un partido que han ganado
CREATE OR REPLACE VIEW EquiposVisitantesAmonestaciones AS
SELECT DEREF(p.Equipo_visitante).Nombre AS Equipo, 
SUM(TarjetaRoja+TarjetaAmarilla1+TarjetaAmarilla2) AS Amonestaciones,
DEREF(p.Estadio_partido).Nombre AS Estadio,
p.Fecha
FROM Partido_objtab p, TABLE(p.jugadores) pj, Jugador_objtab j
WHERE pj.Jugador = REF(j)
    AND (j.Equipo = p.Equipo_visitante)
    AND (p.Resultado.GolesVisitante > p.Resultado.GolesLocal)
GROUP BY p.Id_partido, DEREF(p.Estadio_partido).Nombre, DEREF(p.Equipo_visitante).Nombre, p.Fecha
ORDER BY Amonestaciones DESC;

SELECT * FROM EquiposVisitantesAmonestaciones;

--------------------------------------------
--------- PROCEDIMIENTOS MANU  ---------
--------------------------------------------

-- PROCEDIMIENTO 1
--Muestra la clasificacion de la division del pais introducido por parametro, y por cada equipo de la clasificacion va mostrnado los resultados en los partidos jugando como local y como visitante
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE Clasificacion_temporada(vdivision IN LigaFutbol_objtab.Division%TYPE, vpais IN Pais_objtab.nombre%TYPE)
IS
    TYPE Equipos_TAB IS TABLE OF REF Equipo_objtyp;
    TEquipos Equipos_TAB;
    VNombre Equipo_objtab.nombre%type;
    VEquipo_visitante Equipo_objtab.nombre%type;
    VEquipo_local Equipo_objtab.nombre%type;
    VGolesLocal Partido_objtab.Resultado.GolesLocal%type;
    VGolesVisitante Partido_objtab.Resultado.GolesVisitante%type;
    VCheck NUMBER(1);
    VCheck2 NUMBER(1);
    CURSOR c_resultado_local(Nombre_equipo Equipo_objtab.nombre%type) IS (
        SELECT p.Resultado.GolesLocal, p.Resultado.GolesVisitante, DEREF(Equipo_visitante).Nombre
        FROM Partido_objtab p, Equipo_objtab e 
        WHERE DEREF(p.Equipo_local).Nombre = Nombre_equipo AND
        p.Equipo_local = REF(e)
    );
    
    CURSOR c_resultado_visitante(Nombre_equipo Equipo_objtab.nombre%type) IS (
        SELECT p.Resultado.GolesLocal, p.Resultado.GolesVisitante, DEREF(Equipo_local).Nombre
        FROM Partido_objtab p, Equipo_objtab e 
        WHERE DEREF(p.Equipo_visitante).Nombre = Nombre_equipo AND
        p.Equipo_visitante = REF(e)
    ); 

BEGIN
    IF vdivision IS null AND vpais IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20012, 'Alguno o ambos de los parámetros introducidos no son validos');
    END IF;

    IF vdivision IS null THEN 
        RAISE_APPLICATION_ERROR(-20012, 'La division introducida no es válida');
    END IF;
    
     IF vpais IS null THEN 
        RAISE_APPLICATION_ERROR(-20012, 'El pais introducido no es válido');
    END IF;


    SELECT REF(e) BULK COLLECT INTO TEquipos
    FROM Equipo_objtab e, Clasificacion_objtab c, LigaFutbol_objtab l
    WHERE c.Equipo = REF(e)
    AND e.Liga = REF(l)
    AND c.Liga = REF(l)
    AND l.Division = vdivision
    AND DEREF(l.Pais).Nombre= vpais;

    DBMS_OUTPUT.PUT_LINE('========================================================');        
    DBMS_OUTPUT.PUT_LINE('CLASIFICACION DE LA ' || vdivision || ' DIVISION DE ' || vpais);
    DBMS_OUTPUT.PUT_LINE('========================================================');

    FOR I IN 1..TEquipos.COUNT LOOP
        SELECT DEREF(TEquipos(I)).Nombre INTO VNombre FROM DUAL;
        DBMS_OUTPUT.PUT_LINE('========================================================');        
        DBMS_OUTPUT.PUT_LINE('PUESTO NUMERO ' || I || ' ' || VNombre );
        DBMS_OUTPUT.PUT_LINE('========================================================'); 
        IF NOT c_resultado_local%ISOPEN THEN
            OPEN c_resultado_local(VNombre);
        END IF;
        
        VCheck:=0;
        VCheck2:=0;

        
        DBMS_OUTPUT.PUT_LINE('========================================================');          
        DBMS_OUTPUT.PUT_LINE('RESULTADOS DE ' || VNombre ||' SIENDO LOCAL');
        DBMS_OUTPUT.PUT_LINE('========================================================');
    
        LOOP
            FETCH c_resultado_local INTO VGolesLocal, VGolesVisitante, VEquipo_visitante ;
            DBMS_OUTPUT.PUT_LINE('-------->' || VNombre || ' CONTRA ' || VEquipo_visitante || ':' || VGolesLocal || '-' || VGolesVisitante || '<--------');
            EXIT WHEN c_resultado_local%NOTFOUND;
        END LOOP;
        
        CLOSE c_resultado_local;    
 
        DBMS_OUTPUT.PUT_LINE('========================================================');          
        DBMS_OUTPUT.PUT_LINE('RESULTADOS DE ' || VNombre ||' SIENDO VISITANTE');
        DBMS_OUTPUT.PUT_LINE('========================================================');
         IF NOT c_resultado_visitante%ISOPEN THEN
            OPEN c_resultado_visitante(VNombre);
        END IF;
        
    
        LOOP
            FETCH c_resultado_visitante INTO VGolesLocal, VGolesVisitante, VEquipo_local ;
            DBMS_OUTPUT.PUT_LINE('-------->' || VEquipo_local || ' CONTRA ' || VNombre || ':' || VGolesLocal || '-' || VGolesVisitante || '<--------');
            EXIT WHEN c_resultado_visitante%NOTFOUND;
        END LOOP;
        
        CLOSE c_resultado_visitante;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(' ');
END;
/

EXECUTE Clasificacion_temporada(1,'España');
EXECUTE Clasificacion_temporada(1,NULL);
EXECUTE Clasificacion_temporada(NULL, 'España');
EXECUTE Clasificacion_temporada(NULL, NULL);



--PROCEDIMIENTO 2
--Si introduces solo un club en el primer parametro el sueldo de los jugadores de ese club queda reducido a la mitad
--Si introduces solo un club en el segundo parametro el sueldo de los jugadores de ese club se aumenta al doble
--Si introduces ambos parametros intercambia los presidentes de los clubs introducidos por parametro

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE RecorteAumentoPresupuestario(vclub IN Club_objtab.nombre%type DEFAULT null, vclub2 IN Club_objtab.nombre%type DEFAULT null)
IS
    TYPE Jugadores_TAB IS TABLE OF REF Jugador_objtyp;
    TJugadores Jugadores_TAB;
    VNombre Jugador_objtab.Nombre%type;
    VApellido Jugador_objtab.Apellido1%type;
    VSueldo Jugador_objtab.Sueldo%type;
    VPresi Presidente_objtab.Nombre%type;
    VPresi2 Presidente_objtab.Nombre%type;
    VCheck NUMBER(1);
    VCheck2 NUMBER(2);
    
BEGIN
    IF vclub IS NULL AND vclub2 IS NULL THEN
        RAISE_APPLICATION_ERROR(-20012, 'Por favor introduzca parametros válidos');
    END IF;

    SELECT COUNT(*) INTO VCheck FROM Club_objtab c WHERE c.Nombre = vclub;
    SELECT COUNT(*) INTO VCheck2 FROM Club_objtab c WHERE c.Nombre = vclub2;


    IF vclub IS NOT NULL AND vclub2 IS NOT NULL THEN

        IF VCheck > 0 AND VCheck2 > 0 THEN
    
            SELECT DISTINCT DEREF(c.Preside.Presidente).Nombre INTO VPresi FROM Club_objtab c WHERE c.Nombre = vclub;
            SELECT DISTINCT DEREF(c.Preside.Presidente).Nombre INTO VPresi2 FROM Club_objtab c WHERE c.Nombre = vclub2;
            
            UPDATE Club_objtab c
            SET c.Preside.Presidente = (SELECT REF(p)
                FROM Presidente_objtab p
                WHERE p.Nombre = VPresi2),
                c.Preside.FechaPosesion = SYSDATE,
                c.Preside.Fechacese = null
            WHERE c.Nombre = vclub;


            UPDATE Club_objtab c
            SET c.Preside.Presidente = (SELECT REF(p)
                FROM Presidente_objtab p
                WHERE p.Nombre = VPresi),
            c.Preside.FechaPosesion = SYSDATE,
            c.Preside.Fechacese = null
            WHERE c.Nombre = vclub2;

            DBMS_OUTPUT.PUT_LINE('============================================================================');          
            DBMS_OUTPUT.PUT_LINE('EL NUEVO PRESIDENTE DEL ' || vclub ||' ES ' || VPresi2);
            DBMS_OUTPUT.PUT_LINE('============================================================================');
            DBMS_OUTPUT.PUT_LINE('============================================================================');          
            DBMS_OUTPUT.PUT_LINE('EL NUEVO PRESIDENTE DEL ' || vclub2 ||' ES ' || VPresi);
            DBMS_OUTPUT.PUT_LINE('============================================================================');

         ELSE

            RAISE_APPLICATION_ERROR(-20012, 'Alguno o ambos de los clubs introducidos no es valido');

         END IF;
    ELSE

        IF vclub IS NOT NULL AND vclub2 IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('============================================================================');          
            DBMS_OUTPUT.PUT_LINE('EL SUELDO DE LOS JUGADORES DEL CLUB ' || vclub ||' QUEDA REDUCIDO A LA MITAD');
            DBMS_OUTPUT.PUT_LINE('============================================================================');
            
            UPDATE Jugador_objtab j
            SET j.Sueldo = j.Sueldo / 2
            WHERE DEREF(j.Equipo).Nombre =
                (SELECT e.Nombre
                FROM Equipo_objtab e
                WHERE DEREF(e.Club).Nombre = vclub);
                
            SELECT DISTINCT REF(j) BULK COLLECT INTO TJugadores
            FROM Jugador_objtab j, Equipo_objtab e, Club_objtab c
            WHERE DEREF(j.Equipo).Nombre = e.Nombre
            AND DEREF(e.Club).Nombre = vclub;
            
        END IF;

        IF vclub IS NULL AND vclub2 IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('============================================================================');          
            DBMS_OUTPUT.PUT_LINE('EL SUELDO DE LOS JUGADORES DEL CLUB ' || vclub ||' ES INCREMENTADO 500€');
            DBMS_OUTPUT.PUT_LINE('============================================================================');
            
            UPDATE Jugador_objtab j
            SET j.Sueldo = j.Sueldo + 500
            WHERE DEREF(j.Equipo).Nombre =
                (SELECT e.Nombre
                FROM Equipo_objtab e
                WHERE DEREF(e.Club).Nombre = vclub2);
            
            SELECT DISTINCT REF(j) BULK COLLECT INTO TJugadores
            FROM Jugador_objtab j, Equipo_objtab e, Club_objtab c
            WHERE DEREF(j.Equipo).Nombre = e.Nombre
            AND DEREF(e.Club).Nombre = vclub2;
        
        END IF;       


        FOR I IN 1..TJugadores.COUNT LOOP
        SELECT DEREF(TJugadores(I)).Nombre INTO VNombre FROM DUAL;
        SELECT DEREF(TJugadores(I)).Apellido1 INTO VApellido FROM DUAL;
        SELECT DEREF(TJugadores(I)).Sueldo INTO VSueldo FROM DUAL;

            DBMS_OUTPUT.PUT_LINE('============================================================================');          
            DBMS_OUTPUT.PUT_LINE('EL SUELDO DE ' || VNombre ||' '|| VApellido ||' AHORA ES DE ' || VSueldo);
            DBMS_OUTPUT.PUT_LINE('============================================================================');

        END LOOP;
    END IF;
    DBMS_OUTPUT.PUT_LINE(' ');
 END;
 /
 EXECUTE RecorteAumentoPresupuestario('FC Barcelona');
 EXECUTE RecorteAumentoPresupuestario(null,'FC Barcelona');
 EXECUTE RecorteAumentoPresupuestario('Real Madrid CF', 'FC Barcelona');
 EXECUTE RecorteAumentoPresupuestario(null, null);
 EXECUTE RecorteAumentoPresupuestario('EquipoNoExiste1','EquipoNoExiste1');



-----TRIGGERS DEL PELAO

--2 Disparadores

--Si un arbitro arbitra en alguno de los últimos 5 partidos con rol distinto al principal se le cambia

CREATE OR REPLACE TRIGGER CambiarRolArbitro
FOR INSERT ON Partido_objtab
COMPOUND TRIGGER    
    TYPE TPartido IS TABLE OF Partido_objtab.ID_Partido%TYPE INDEX BY BINARY_INTEGER;
    tablapartido TPartido;
    IND BINARY_INTEGER:=0;
    
    v_partido_id NUMBER(10);        

BEFORE EACH ROW IS BEGIN
    IND := IND + 1;
    tablapartido(IND) := :NEW.ID_Partido;
END BEFORE EACH ROW;

AFTER STATEMENT IS
BEGIN   
    FOR i IN 1..IND
    loop
        
        v_partido_id := tablapartido(i);

        -- Obtengo la información del árbitro que haya participado en el partido v__partido_id
        -- y que en alguno de los últimos 5 partidos haya cambiado de rolprincipal por otro.
        -- Y si es así se le cambia por este nuevo

        FOR vi IN (SELECT arb.Arbitro.ID_Persona AS idpersona, arb.Arbitro.Nombre AS nombre, arb.Arbitro.RolPrincipal AS rolprincipal, arb.Rol AS rol
                        FROM Partido_objtab p, TABLE(p.arbitros) arb
                        WHERE p.ID_Partido = v_partido_id
                        AND arb.Arbitro IN
                        
                        (SELECT a.Arbitro 
                         FROM Partido_objtab p, TABLE(p.arbitros) a
                        WHERE a.Arbitro.ID_persona = arb.Arbitro.ID_Persona AND a.Rol != a.Arbitro.RolPrincipal
                        ORDER BY p.Fecha DESC, p.Hora DESC
                        FETCH FIRST 5 ROWS ONLY)
                        )
        loop
            DBMS_OUTPUT.PUT_LINE('_____________________Se va a actualizar árbitro_____________________');
            DBMS_OUTPUT.PUT_LINE(vi.idpersona || ' ' || vi.nombre || ' ' || vi.rolprincipal || ' ' || vi.rol);
             UPDATE Arbitro_Objtab SET RolPrincipal = vi.rol WHERE ID_Persona = vi.idpersona;
        end loop;
        DBMS_OUTPUT.PUT_LINE(' ');
    end loop;
END AFTER STATEMENT;
END;
/




CREATE OR REPLACE TRIGGER ActualizarJugador
FOR UPDATE ON Partido_objtab
COMPOUND TRIGGER
    v_partido_id NUMBER(10);        
    variabletemporal NUMBER(10);
    TYPE TPartido IS TABLE OF Partido_objtab.ID_Partido%TYPE INDEX BY BINARY_INTEGER;
    tablapartido TPartido;
    IND BINARY_INTEGER:=0;

BEFORE EACH ROW IS BEGIN
    IND := IND + 1;
    tablapartido(IND) := :NEW.ID_Partido;
END BEFORE EACH ROW;

AFTER STATEMENT IS
BEGIN   
    FOR i IN 1..IND LOOP
    
    v_partido_id := tablapartido(i);
    
    DBMS_OUTPUT.put_line ('Has insertado el partido: ' || v_partido_id);

    -- Iteramos la información de cada jugador del partido

    FOR vi IN (
    SELECT p.ID_partido AS idpartido, j.Jugador.ID_Persona AS idpersona, j.Jugador.Apellido1 AS apellido, j.MinutoEntrada AS minutoentrada, 
    j.MinutoSalida AS minutosalida, j.TarjetaRoja AS tarjetaroja, j.TarjetaAmarilla1 AS amarilla1, j.TarjetaAmarilla2 AS amarilla2, j.Goles AS goles,
    p.resultado.MinutosPrimera AS minprimera, p.resultado.MinutosSegunda AS minsegunda
    FROM partido_objtab p, TABLE(p.jugadores) j 
    WHERE p.ID_Partido = v_partido_id) loop
    
    DBMS_OUTPUT.put_line ('El jugador con estadisticas: ' || vi.idpartido || '  ' || vi.idpersona || '  ' || vi.apellido || '  ' || vi.minutoentrada || '  ' || 
    vi.minutosalida || '  ' || vi.tarjetaroja || '  ' || vi.amarilla1 || '  ' || vi.amarilla2 || '  ' || vi.goles);
    
    -- Actualizamos cada una de las variables de jugador obtenidas previamente

    UPDATE jugador_objtab set 
        TarjetasRojas = (TarjetasRojas + vi.tarjetaroja),
        TarjetasAmarillas = (TarjetasAmarillas + vi.amarilla1 + vi.amarilla2),
        PartidosJugados = (PartidosJugados + 1),
        GolesTotales = (GolesTotales + vi.goles)
        WHERE ID_Persona = vi.idpersona;

    -- Si vi.minutosalida, que es el minuto de salida del jugador del partido, está a nulo, significa que ha estado jugando hasta el final
    -- Por ello si ha jugado hasta el final el cálculo es: MinutosJugados + vi.minprimera + vi.minsegunda - vi.minutoentrada
    -- y si ha salido en un momento distinto el cálculo es: MinutosJugados + vi.minutosalida - vi.minutoentrada        

    if (vi.minutosalida is NULL) then
            DBMS_OUTPUT.put_line ( '1 ' ||vi.idpersona || ' ' || (vi.minprimera + vi.minsegunda - vi.minutoentrada));
            DBMS_OUTPUT.put_line ( 'min primero ' ||vi.idpersona || ' ' || vi.minprimera || vi.minsegunda || vi.minutoentrada);
            UPDATE jugador_objtab set MinutosJugados = MinutosJugados + vi.minprimera + vi.minsegunda - vi.minutoentrada WHERE ID_persona = vi.idpersona;
        else
            SELECT MinutosJugados INTO variabletemporal FROM Jugador_objtab WHERE ID_Persona = vi.idpersona;
            variabletemporal := variabletemporal + vi.minutosalida - vi.minutoentrada;
            DBMS_OUTPUT.put_line ( '2 ' ||vi.idpersona || ' ' || variabletemporal);
        
            UPDATE jugador_objtab set MinutosJugados = MinutosJugados + vi.minutosalida - vi.minutoentrada WHERE ID_persona = vi.idpersona;
        end if;           

        DBMS_OUTPUT.put_line ('Se ha actualizado el jugador ' || vi.idpersona || ' ' || vi.apellido);
    END LOOP;
    END LOOP;    
END AFTER STATEMENT;
END;
/

SET SERVEROUTPUT ON;

------RAUUUUUUL PELAAAAAO

UPDATE Partido_objtab
SET Resultado = Resultado_objtyp((SELECT p.Resultado.GolesLocal FROM Partido_objtab p WHERE p.ID_Partido=1), (SELECT p.Resultado.GolesVisitante FROM Partido_objtab p WHERE p.ID_Partido=1), 64, 47, 50)
WHERE ID_Partido = 1;/

UPDATE Partido_objtab
SET Resultado = Resultado_objtyp((SELECT p.Resultado.GolesLocal FROM Partido_objtab p WHERE p.ID_Partido=2), (SELECT p.Resultado.GolesVisitante FROM Partido_objtab p WHERE p.ID_Partido=2), 107, 47, 48)
WHERE ID_Partido = 2;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp((SELECT p.Resultado.GolesLocal FROM Partido_objtab p WHERE p.ID_Partido=3), (SELECT p.Resultado.GolesVisitante FROM Partido_objtab p WHERE p.ID_Partido=3), 64, 45, 50))
WHERE ID_Partido = 3;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp((SELECT p.Resultado.GolesLocal FROM Partido_objtab p WHERE p.ID_Partido=4), (SELECT p.Resultado.GolesVisitante FROM Partido_objtab p WHERE p.ID_Partido=4), 70, 47, 52))
WHERE ID_Partido = 4;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp((SELECT p.Resultado.GolesLocal FROM Partido_objtab p WHERE p.ID_Partido=5), (SELECT p.Resultado.GolesVisitante FROM Partido_objtab p WHERE p.ID_Partido=5), 91, 49, 52))
WHERE ID_Partido = 5;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp((SELECT p.Resultado.GolesLocal FROM Partido_objtab p WHERE p.ID_Partido=6), (SELECT p.Resultado.GolesVisitante FROM Partido_objtab p WHERE p.ID_Partido=6), 1000, 48, 50))
WHERE ID_Partido = 6;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(5, 0, 2000, 47, 50))
WHERE ID_Partido = 100;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(3, 1, 2001, 47, 48))
WHERE ID_Partido = 101;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(17, 3, 2003, 47, 50))
WHERE ID_Partido = 104;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 10, 107, 49, 46))
WHERE ID_Partido = 106;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 20, 2006, 46, 47))
WHERE ID_Partido = 107;/

UPDATE Partido_objtab
SET Resultado = (Resultado_objtyp(0, 10, 79, 46, 46))
WHERE ID_Partido = 108;/

--_____________________________________________________________________________________________________

--___________________________________RAÚL CONSULTAS_____________________________________________________

--______________________________________________________________________________________________________
--3 Consultah
--Dime el arbitro que
--participó como asistente en los partidos en cuyo resultado el número de goles del equipo local fue mayor de 5 

CREATE OR REPLACE VIEW arbitroAsistente AS

SELECT * 
    FROM arbitro_objtab a
    WHERE REF(a) IN     
(SELECT a.Arbitro
    FROM partido_objtab p, TABLE(p.arbitros) a
    WHERE (p.resultado.GolesLocal > 5)  AND a.Rol = 'Asistente')
    ORDER BY a.ID_PERSONA;/

 select * from arbitroAsistente;/

--Dime la clasificación de la LaLiga Santander 
--del equipo haya participado en el partido con más goles como visitante
 
CREATE OR REPLACE VIEW EquipoVisitanteGoleador AS

SELECT *
    FROM clasificacion_objtab c
    WHERE c.Liga.Nombre = 'LaLiga Santander'
        AND
            c.equipo in 
        (SELECT p.equipo_visitante
        FROM partido_objtab p
        WHERE p.resultado.GolesVisitante = (SELECT MAX(p.resultado.GolesVisitante) FROM partido_objtab p)) ;/

 select * from EquipoVisitanteGoleador;/

--Dime el presidente con el periodo entre posesión 
--y cese más larga y cuyo equipo tenga el mayor número de partidos ganados

CREATE OR REPLACE VIEW PresidenteLongevoGanador AS(

SELECT p.*, pre.fechacese, pre.fechaposesion, (pre.fechacese - pre.fechaposesion) as dias
    FROM presidente_objtab p, preside_objtab pre
    WHERE REF(p) = pre.presidente
        AND
            (pre.fechacese - pre.fechaposesion) = (SELECT MAX(pre.fechacese - pre.fechaposesion) as resta
        FROM preside_objtab pre));/

 select * from PresidenteLongevoGanador;/






--_____________________________________________________________________________________________________

--___________________________________RAÚL PROCEDIMIENTOS_____________________________________________________

--______________________________________________________________________________________________________

--1-2 Procedimientos

--funcion que calcule el numero de minutos de cada jugador por primera vez
CREATE OR REPLACE PROCEDURE MinutoSalidaJugador IS
    SolucionJugador NUMBER(10);
    minutos jugador_objtab.MinutosJugados%TYPE;
BEGIN

for vi in (    
    SELECT j.Jugador.ID_persona idpersona, j.Jugador.Apellido1 AS apellido, j.MinutoEntrada AS jugentrada, j.MinutoSalida AS jugsalida, 
                        p.resultado.MinutosPrimera AS minprimera, p.resultado.MinutosSegunda AS minsegunda, j.Goles AS Goles
    FROM partido_objtab p, TABLE(p.jugadores) j
    WHERE j.jugador.ID_persona IS NOT NULL
    ORDER BY j.jugador.ID_persona
    ) loop
 
    select MinutosJugados INTO minutos FROM jugador_objtab j WHERE ID_persona = vi.idpersona;
    
    if (vi.jugsalida is NULL) then
            SolucionJugador := vi.minprimera + vi.minsegunda - vi.jugentrada;                        
        else
            SolucionJugador := vi.jugsalida - vi.jugentrada;
        end if;
                
    IF minutos IS null THEN
        UPDATE jugador_objtab set MinutosJugados = SolucionJugador WHERE ID_persona = vi.idpersona;
    ELSE
        UPDATE jugador_objtab set MinutosJugados = MinutosJugados + SolucionJugador WHERE ID_persona = vi.idpersona;
    END IF;
    end loop;
END;    
/
-- execute MinutoSalidaJugador





-- Disparadores

--Disparador que controle que un jugador puede ser insertado en un nuevo equipo
--(controlando que no supere el tamaño máximo permitido de jugadores por equipo)
-- y que se le asigne un historial con ese equipo automáticamente.

CREATE OR REPLACE TRIGGER tr_insertar_jugador
BEFORE INSERT ON jugador_objtab
FOR EACH ROW
DECLARE
    v_num_jugadores NUMBER;
    v_temporada Historial_objtab.TemporadaEntrada%TYPE;
    v_id_historial Historial_objtab.Id_historial%TYPE;
    v_anio NUMBER;
    v_mes NUMBER;
BEGIN
    -- Compruebo que el equipo al que quiero añadir el jugador tiene menos de 25 jugadores
    SELECT COUNT(*) INTO v_num_jugadores
    FROM Jugador_objtab j
    WHERE j.Equipo = :NEW.Equipo
    AND j.Historial.TemporadaSalida IS NULL;
    --Lanzo error si no puede ser añadido al equipo.    
    IF v_num_jugadores >= 25 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El equipo no puede inscribir más jugadores a la liga.');
    END IF;
    
    --Declaro valores para el Historial
    SELECT EXTRACT(YEAR FROM SYSDATE), EXTRACT(MONTH FROM SYSDATE) INTO v_anio, v_mes FROM dual;
    
    IF v_mes >= 7 THEN
        v_temporada := TO_CHAR(v_anio) || '-' || SUBSTR(TO_CHAR(v_anio+1), 3, 2);
    ELSE
        v_temporada := SUBSTR(TO_CHAR(v_anio-1), 1, 4) || '-' || SUBSTR(TO_CHAR(v_anio), 3, 2);
    END IF;
    
    SELECT MAX(id_historial) + 1 INTO v_id_historial FROM Historial_objtab;
    IF v_id_historial IS NULL THEN
        v_id_historial := 1;
    END IF;
    
    --Creo el nuevo historial que va a ir asociado al jugador    
    INSERT INTO Historial_objtab (id_historial, equipo, temporadaentrada)
    VALUES (v_id_historial, :new.Equipo, v_temporada);
    
    SELECT REF(h) INTO :NEW.Historial FROM Historial_objtab h WHERE h.id_historial = v_id_historial;
    
    -- Añado el historial al jugador que acabo de añadir
    UPDATE Jugador_objtab j
    SET j.Historial = :NEW.Historial
    WHERE Id_persona = :NEW.Id_persona;
END;
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1100, 'Mount', 'Tern', 'Alves', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 20, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0
);/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1101, 'Mount', 'Terni', 'Alves', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 20, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0
);/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1102, 'Mount', 'Terna', 'Alves', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 20, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0
);/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1103, 'Mount', 'Ternu', 'Alves', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 20, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0
);/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1104, 'Mount', 'Terno', 'Alves', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 20, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0
);/
INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1105, 'Mount', 'Ternos', 'Alves', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 20, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'Real Madrid CF'), 0, 0, 0, 0, 0
);/

-- El real madrid tiene 20 jugadores, por lo tanto, al añadir estos nuevos jugadores, los 5 primeros se insertan correctamente y se le asigna un historial con el Real Madrid, pero el último jugador no puede ser añadido al superar el límite de jugadores

--TRIGGER 2

--DISPARADOR QUE COMPRUEBE LA DISPONIBILIDAD DE LOS ESTADIOS
--ANTES DE PROGRAMAR UN PARTIDO EN ELLOS, DE MODO QUE SE VERIFIQUE QUE
--NO SE PUEDEN JUGAR VARIOS PARTIDOS EN EL MISMO ESTADIO EN LA MISMA FECHA Y HORA.

CREATE OR REPLACE TRIGGER tr_comprobar_estadio_disponible
BEFORE INSERT ON Partido_objtab
FOR EACH ROW
DECLARE
    v_estadio_ocupado NUMBER;
    v_fecha_partido Partido_objtab.Fecha%TYPE;
    v_old_fecha Partido_objtab.Fecha%TYPE;
BEGIN
    
    v_old_fecha := :NEW.Fecha;
    --Compruebo si hay partidos en los que coinciden las fechas y los estadios.
    v_fecha_partido := :NEW.Fecha;
    
    SELECT COUNT(*) INTO v_estadio_ocupado
    FROM Partido_objtab p
    WHERE p.Estadio_partido = :NEW.Estadio_partido
    AND p.Fecha LIKE v_fecha_partido;
    
    --Si hay partidos en los que coinciden las fechas y estadios, cambio la fecha a una disponible
    IF v_estadio_ocupado > 0 THEN 
        LOOP
            v_fecha_partido := v_fecha_partido + 1;
            
            SELECT COUNT(*) INTO v_estadio_ocupado
            FROM Partido_objtab p
            WHERE p.Estadio_partido = :NEW.Estadio_partido
            AND p.Fecha LIKE v_fecha_partido;
            
            EXIT WHEN v_estadio_ocupado = 0;
        END LOOP;
        
        :NEW.Fecha := v_fecha_partido;
        
        DBMS_OUTPUT.PUT_LINE(v_old_fecha || ' - ' || :NEW.Hora || 'h --> ' || :NEW.Fecha || ' - ' || :NEW.Hora || 'h.');
    END IF;
END;
/




--Consultas JAvier

-- Muestrame el máximo goleador y el jugador con más tarjetas amarillas de cada
--equipo de todos los equipos de la primera y segunda división española de la temporada actual.

CREATE OR REPLACE VIEW vista1 AS (
    SELECT nombre, apellido1 AS apellido, golestotales, tarjetasamarillas, j.equipo.nombre AS Equipo
    FROM jugador_objtab j
    WHERE j.equipo.liga.division IN (1,2)
    AND j.equipo.liga.pais.nombre LIKE 'España'
    AND j.golestotales = (
        SELECT MAX(golestotales) 
        FROM jugador_objtab a 
        WHERE a.equipo=j.equipo)
    AND j.historial.TemporadaSalida IS NULL
    UNION
    SELECT nombre, apellido1, golestotales, tarjetasamarillas, j.equipo.nombre as Equipo
    FROM jugador_objtab j
    WHERE j.equipo.liga.division IN (1,2)
    AND j.equipo.liga.pais.nombre LIKE 'España'
    AND j.tarjetasamarillas = (
        SELECT MAX(tarjetasamarillas) 
        FROM jugador_objtab c 
        WHERE c.equipo=j.equipo)
    AND j.historial.TemporadaSalida IS NULL
    )ORDER BY Equipo, golestotales;

SELECT * FROM vista1; --FALTA AÑADIR VALORES EN GOLESTOTALES Y TARJETASAMARILLAS EN LA BBDD


-- Muestrame los jugadores españoles del Real Madrid que hayan jugado un partido entero sin recibir ninguna amonestación en la temporada actual y el número de ellos (nº de partidos)

CREATE OR REPLACE VIEW vista2 AS (
SELECT j.nombre, j.apellido1 AS Apellido, (SELECT COUNT(*)
    FROM Partido_objtab p, TABLE(p.jugadores) pp
    WHERE pp.jugador.Id_persona = j.Id_persona
    AND pp.minutoEntrada = 0
    AND pp.minutoSalida IS NULL
    AND pp.tarjetaRoja = 0
    AND pp.tarjetaAmarilla1 = 0
    AND pp.tarjetaAmarilla2 = 0
    AND p.fecha BETWEEN TO_DATE('13/08/2', 'DD/MM/YY') AND TO_DATE('04/06/23', 'DD/MM/YY')
    ) AS Partidos
FROM Jugador_objtab j
WHERE j.equipo.nombre LIKE 'Real Madrid CF'
AND j.pais.nombre LIKE 'España'
AND j.historial.temporadaSalida IS NULL
AND j.Id_persona IN (
    SELECT pp.jugador.Id_persona
    FROM Partido_objtab p, TABLE(p.jugadores) pp
    WHERE pp.minutoEntrada = 0
    AND pp.minutoSalida IS NULL
    AND pp.tarjetaRoja  = 0
    AND pp.tarjetaAmarilla1 = 0
    AND pp.tarjetaAmarilla2 = 0
    AND p.fecha BETWEEN TO_DATE('13/08/22', 'DD/MM/YY') AND TO_DATE('04/06/23', 'DD/MM/YY')
    )
);
SELECT * FROM vista2;

-- De los dos equipos de LaLiga Santander cuyo estadio tengan más aforo máximo,
--muestrame la suma de los minutos jugados de los delanteros de estos equipos con un sueldo menor a 7.000.000€ de todas las temporadas

CREATE OR REPLACE VIEW vista3 AS (
SELECT count(*) AS numJugadores, SUM(j.minutosjugados) AS MinutosTotales
FROM jugador_objtab j
WHERE j.equipo.ID_equipo IN (
    SELECT ID_equipo
    FROM equipo_objtab q
    WHERE q.liga.nombre LIKE 'LaLiga Santander'
    ORDER BY q.estadio.aforomaximo DESC
    FETCH FIRST 2 ROWS ONLY)
AND j.posicion LIKE 'Delantero'
AND j.Sueldo <= 7000000
);
SELECT * FROM vista3; --FALTA AÑADIR VALORES EN MINUTOSJUGADOS EN LA BBDD


 ----------------------------------------------------------------   

--*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/

-------------PROCEDIMIENTOS JAVIER

-- Este procedimiento permite realizar el transpaso de un jugador actual a otro equipo,
-- para lo que se necesitará el jugador, el equipo, su nuevo sueldo y el precio del fichaje.


CREATE OR REPLACE PROCEDURE Fichar_Jugador(p_jugador IN Jugador_objtab.ID_persona%TYPE, p_equipo IN Equipo_objtab.ID_equipo%TYPE, p_sueldo IN Jugador_objtab.Sueldo%TYPE, p_precio IN Equipo_objtab.Presupuesto%TYPE)
IS
v_equipo Equipo_objtab.Nombre%TYPE;
v_antiguo_equipo Equipo_objtab.Nombre%TYPE;
v_jugador Jugador_objtab.Nombre%TYPE;
v_sueldo Jugador_objtab.Sueldo%TYPE := p_sueldo;
v_historial Jugador_objtab.Historial%TYPE;
v_temp_salida Historial_objtab.TemporadaSalida%TYPE;
v_presupuesto Equipo_objtab.Presupuesto%TYPE;

v_temporada Historial_objtab.TemporadaSalida%TYPE;
v_anio NUMBER;
v_mes NUMBER;

BEGIN
    DBMS_OUTPUT.PUT_LINE('~ Realizando fichaje... ~');

    IF p_jugador IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010, 'Debes de indicar el id de un jugador.');
    END IF;
    IF p_equipo IS NULL THEN
        RAISE_APPLICATION_ERROR(-20020, 'Debes de indicar el id de un equipo.');
    END IF;
    IF p_sueldo <= 0 OR p_sueldo IS NULL THEN --Si no pasamos el sueldo o el que pasamos no es válido asignamos 5M
        v_sueldo := 5000000;
    END IF;
    IF p_precio < 0 OR p_precio IS NULL THEN
         RAISE_APPLICATION_ERROR(-20090, 'Precio por el transpaso no válido.');
    END IF;
    
    SELECT Nombre, Presupuesto INTO v_equipo, v_presupuesto
    FROM Equipo_objtab
    WHERE ID_equipo = p_Equipo;
    

    IF v_equipo IS NULL THEN
        RAISE_APPLICATION_ERROR(-20030, 'El equipo introducido no existe.');
    END IF;
        
    IF v_presupuesto < p_precio THEN
        RAISE_APPLICATION_ERROR(-20080, 'El ' || v_equipo || ' no tiene suficiente presupuesto.');
    END IF;
    
    SELECT j.Nombre, j.Equipo.Nombre, j.Historial, j.Historial.TemporadaSalida INTO v_jugador, v_antiguo_equipo, v_historial, v_temp_salida
    FROM Jugador_objtab j
    WHERE j.ID_persona = p_jugador;
    
    
    IF v_jugador IS NULL THEN
        RAISE_APPLICATION_ERROR(-20040, 'El jugador introducido no existe.');
    END IF;
    
    IF v_historial IS NULL THEN
        RAISE_APPLICATION_ERROR(-20050, 'El jugador no dispone de historial.');
    END IF;
    
    IF v_temp_salida IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20060, 'Este jugador no puede ser fichado.');
    END IF; --Porque tiene el historial cerrado.
    
    
    IF v_antiguo_equipo = v_equipo THEN
        RAISE_APPLICATION_ERROR(-20070, 'No puedes transferir un jugador al mismo equipo al que pertenece');
    END IF;
    
    --Calculamos la temporada en la que estamos
    SELECT EXTRACT(YEAR FROM SYSDATE), EXTRACT(MONTH FROM SYSDATE) INTO v_anio, v_mes FROM dual;
    
    IF v_mes >= 7 THEN
        v_temporada := TO_CHAR(v_anio) || '-' || SUBSTR(TO_CHAR(v_anio+1), 3, 2);
    ELSE
        v_temporada := SUBSTR(TO_CHAR(v_anio-1), 1, 4) || '-' || SUBSTR(TO_CHAR(v_anio), 3, 2);
    END IF;

    --Actualizamos su historial con el antiguo club
    UPDATE Historial_objtab
    SET TemporadaSalida = v_temporada
    WHERE Id_historial = (
        SELECT j.Historial.Id_historial 
        FROM Jugador_objtab j 
        WHERE j.Id_persona = p_jugador
    );


    --Creamos el nuevo historial
    INSERT INTO Historial_objtab (Id_historial, equipo, TemporadaEntrada)
    VALUES (
        (SELECT MAX(id_historial) + 1 FROM Historial_objtab),
        (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre = v_equipo),
        v_temporada);
    
   
    --Añado el nuevo jugador
    INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales, Equipo, Historial)
    VALUES (
    (SELECT COALESCE(MAX(TO_NUMBER(id_persona)), 0) + 1 FROM jugador_objtab),
    (SELECT j.Nombre FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.Apellido1 FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.Apellido2 FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.Edad FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.Pais FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.Dorsal FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.Posicion FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    v_sueldo,
    (SELECT j.TarjetasRojas FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.TarjetasAmarillas FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.PartidosJugados FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.MinutosJugados FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT j.GolesTotales FROM Jugador_objtab j WHERE j.ID_persona = p_jugador),
    (SELECT REF(e) FROM equipo_objtab e WHERE e.ID_equipo = p_equipo),
    (SELECT REF(h) FROM Historial_objtab h WHERE h.Id_historial = (SELECT MAX(id_historial) FROM Historial_objtab))
    );
    
    UPDATE Equipo_objtab
    SET Presupuesto = Presupuesto - p_precio
    WHERE ID_equipo = p_equipo;
    
    DBMS_OUTPUT.PUT_LINE('*** NUEVO FICHAJE!   ['|| v_jugador ||' ABANDONA ' || v_antiguo_equipo || ' Y SE INCORPORA AL ' || v_equipo || ' Por ' || p_precio || '€]  !! ***');
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
END;
/

INSERT INTO Jugador_objtab (ID_persona, Nombre, Apellido1, Apellido2, Edad, Pais, Dorsal, Posicion, Sueldo, Equipo, TarjetasRojas, TarjetasAmarillas, PartidosJugados, MinutosJugados, GolesTotales)
    VALUES(1008, 'Alvaro', 'Grists', '', 23, (SELECT REF(p) FROM Pais_objtab p WHERE p.Nombre = 'Portugal'), 20, 'Delantero', 7000000,
    (SELECT REF(e) FROM equipo_objtab e WHERE e.nombre like 'FC Barcelona'), 0, 0, 0, 0, 0
);
/
--Error: no existe el jugador
EXECUTE Fichar_Jugador(1015, 3, 6000000, 100000); 
--Error: no existe el equipo
EXECUTE Fichar_Jugador(1008, 100, 6000000, 100000); 
--Error por mismo equipo
EXECUTE Fichar_Jugador(1008, 1, 6000000, 100000); 
--Error por no tener presupuesto
EXECUTE Fichar_jugador(1008 ,3, 6000000, 1000000000); 
--Fichado
EXECUTE Fichar_jugador(1008 ,3, 6000000, 100000); 
--Error: este jugador ya ha sido fichado - historial cerrado
EXECUTE Fichar_jugador(1008 ,1, 6000000, 100000); 




-- Debido a un nuevo reglamento de la FIFA, todos los estadios de una misma liga
--tinen que aumentar el aforo máximo de su estadio dependiendo del presupuesto del club.
--Dada una liga, por cada 1 millón de presupuesto del club, aumenta en 100 el aforo de los estadios de todos los equipos de esa liga,
-- y substrae en un 10% el presupuesto total del club por ello.



CREATE OR REPLACE PROCEDURE actualizar_aforo_y_presupuesto(
    p_liga IN LigaFutbol_objtab.ID_liga%TYPE
)
IS

    CURSOR c_equipos_cursor IS
        SELECT e.id_equipo, e.nombre,
        e.estadio.AforoMaximo as Aforo,
        e.estadio.id_estadio as idestadio,
        e.estadio.nombre as estadionombre,
        e.club.presupuesto as presupuestoclub,
        e.club.id_club as idclub
        FROM equipo_objtab e
        WHERE e.Liga.ID_liga = p_liga
        FOR UPDATE;
        
    v_presupuesto Club_objtab.presupuesto%TYPE;
    v_nuevo_aforo estadio_objtab.AforoMaximo%TYPE;
    v_liga ligafutbol_objtab.id_liga%TYPE;
BEGIN   

    --verifico si la liga existe en la tabla
    SELECT ID_liga INTO v_liga
    FROM LigaFutbol_objtab
    WHERE ID_liga = p_liga;

    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20010, '');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(' ');
    FOR r_equipo IN c_equipos_cursor LOOP
        
        IF r_equipo.idclub IS NOT NULL THEN
        IF r_equipo.presupuestoclub < 1000000 THEN
            DBMS_OUTPUT.PUT_LINE('El club del ' || r_equipo.nombre || ' no tiene suficiente presupuesto.');
            DBMS_OUTPUT.PUT_LINE(' ');
        ELSE
            
            -- Calcular el nuevo aforo del estadio del equipo
            v_nuevo_aforo := r_equipo.Aforo + (FLOOR(r_equipo.presupuestoclub / 1000000) * 100);
            
            -- Actualizar el aforo del estadio del equipo
            UPDATE estadio_objtab
            SET AforoMaximo = v_nuevo_aforo
            WHERE id_estadio = r_equipo.idestadio;
            
            -- Calcular el nuevo presupuesto del club del equipo
            v_presupuesto := r_equipo.presupuestoclub * 0.9;
            
            -- Actualizar el presupuesto del club del equipo
            UPDATE club_objtab
            SET presupuesto = v_presupuesto
            WHERE id_club = r_equipo.idclub;
            
            DBMS_OUTPUT.PUT_LINE(r_equipo.nombre || ' [ESTADIO: '|| r_equipo.estadionombre || ' AFORO: ' || r_equipo.Aforo || ' ---> ' || v_nuevo_aforo || ' | PRESUPUESTO CLUB: ' || r_equipo.presupuestoclub || ' --> ' || v_presupuesto || '].');
            DBMS_OUTPUT.PUT_LINE(' ');
            
        END IF;
        ELSE
        DBMS_OUTPUT.PUT_LINE( r_equipo.nombre || ' no tiene asociado un club.');
        DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
        
    END LOOP;
    COMMIT;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('La liga introducida no existe.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/

--Actualiza los estadios de laliga santander (Real madrid --> No lo actualiza porque no tiene asociado el club)
EXECUTE actualizar_aforo_y_presupuesto(1);

