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

--------------------------------------------
--------- CONSULTAS MANOLETE  --------------
--------------------------------------------

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

--------------------------------------------
--------- PROCEDIMIENTOS MANOLETE  ---------
--------------------------------------------

-- PROCEDIMIENTO 1
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
        WHERE Nombre_equipo = DEREF(p.Equipo_local).Nombre
    );
    
    CURSOR c_resultado_visitante(Nombre_equipo Equipo_objtab.nombre%type) IS (
        SELECT p.Resultado.GolesLocal, p.Resultado.GolesVisitante, DEREF(Equipo_local).Nombre
        FROM Partido_objtab p, Equipo_objtab e
        WHERE Nombre_equipo = DEREF(p.Equipo_visitante).Nombre
    ); 

BEGIN
    IF vpais IS null THEN 
       DBMS_OUTPUT.PUT_LINE('Por favor introduzca un pais válido');
    END IF;

    IF vdivision IS null THEN 
       DBMS_OUTPUT.PUT_LINE('Por favor introduzca una division válida');
    END IF;

    SELECT REF(e) BULK COLLECT INTO TEquipos
    FROM Equipo_objtab e, Clasificacion_objtab c, LigaFutbol_objtab l
    WHERE c.Equipo = REF(e)
    AND l.Division=division
    AND DEREF(l.Pais).Nombre=vpais;

    DBMS_OUTPUT.PUT_LINE('========================================================');        
    DBMS_OUTPUT.PUT_LINE('CLASIFICACION DE LA ' || vdivision || ' DIVISION DE ' || vpais);
    DBMS_OUTPUT.PUT_LINE('========================================================');

    FOR I IN 1..TEquipos.COUNT LOOP
        SELECT DEREF(TEquipos(I)).Nombre INTO VNombre FROM DUAL;
        DBMS_OUTPUT.PUT_LINE('========================================================');        
        DBMS_OUTPUT.PUT_LINE('PUESTO NUMERO ' || I || ' ' || VNombre );
        DBMS_OUTPUT.PUT_LINE('========================================================'); 
        DBMS_OUTPUT.PUT_LINE('========================================================');          
        DBMS_OUTPUT.PUT_LINE('RESULTADOS DE ' || VNombre ||' SIENDO LOCAL');
        DBMS_OUTPUT.PUT_LINE('========================================================');
        
        IF NOT c_resultado_local%ISOPEN THEN
            OPEN c_resultado_local(VNombre);
        END IF;
        
        IF NOT c_resultado_visitante%ISOPEN THEN
            OPEN c_resultado_visitante(VNombre);
        END IF;
        
        VCheck:=0;
        VCheck2:=0;

        
        LOOP
            IF VCheck = 0 THEN                
                FETCH c_resultado_local INTO VGolesLocal, VGolesVisitante, VEquipo_visitante ;
                DBMS_OUTPUT.PUT_LINE('-------->' || VNombre || ' CONTRA ' || VEquipo_visitante || ':' || VGolesLocal || '-' || VGolesVisitante || '<--------');
                IF c_resultado_local%NOTFOUND THEN
                    VCheck:=1;
                END IF;
           ELSE
            IF VCheck2 = 0 THEN
                VCheck2:=1;
                DBMS_OUTPUT.PUT_LINE('========================================================');          
                DBMS_OUTPUT.PUT_LINE('RESULTADOS DE ' || VNombre ||' SIENDO VISITANTE');
                DBMS_OUTPUT.PUT_LINE('========================================================');    
            END IF;
            
            FETCH c_resultado_visitante INTO VGolesLocal, VGolesVisitante, VEquipo_local ;
            DBMS_OUTPUT.PUT_LINE('-------->' || VEquipo_local || ' CONTRA ' || VNombre || ':' || VGolesLocal || '-' || VGolesVisitante || '<--------');
            EXIT WHEN c_resultado_visitante%NOTFOUND;
            END IF;
         END LOOP;
         
        CLOSE c_resultado_visitante;
        CLOSE c_resultado_local;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(' ');
END;

EXECUTE Clasificacion_temporada(1,'España');




--PROCEDIMIENTO 2

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
 
 EXECUTE RecorteAumentoPresupuestario('FC Barcelona');
 EXECUTE RecorteAumentoPresupuestario(null,'FC Barcelona');
 EXECUTE RecorteAumentoPresupuestario(null, null);
 EXECUTE RecorteAumentoPresupuestario('Real Madrid CF', 'FC Barcelona');
 EXECUTE RecorteAumentoPresupuestario('EquipoNoExiste1','EquipoNoExiste1');