--------------------------------------------
--------- CONSULTAS MANOLETE  --------------
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
/
EXECUTE Clasificacion_temporada(1,'España');
EXECUTE Clasificacion_temporada(1,NULL);
EXECUTE Clasificacion_temporada(NULL, 'España');
EXECUTE Clasificacion_temporada(NULL, 'NULL');



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
 EXECUTE RecorteAumentoPresupuestario(null, null);
 EXECUTE RecorteAumentoPresupuestario('Real Madrid CF', 'FC Barcelona');
 EXECUTE RecorteAumentoPresupuestario('EquipoNoExiste1','EquipoNoExiste1');


 -------------------------------------------
------------ TRIGGERS MANOLETE  ------------
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
END;

