-------------------------------------
------VYMAZANIE TABULIEK/SEKV--------
-------------------------------------
DROP SEQUENCE kino_seq;
DROP SEQUENCE sal_seq;
DROP SEQUENCE sedadlo_seq;
DROP SEQUENCE zaner_seq;
DROP SEQUENCE film_seq;
DROP SEQUENCE projekcia_seq;
DROP SEQUENCE kod_num;
DROP SEQUENCE zamestnanec_seq;

DROP TABLE kino CASCADE CONSTRAINTS;
DROP TABLE sal CASCADE CONSTRAINTS;
DROP TABLE sedadlo CASCADE CONSTRAINTS;
DROP TABLE film CASCADE CONSTRAINTS;
DROP TABLE film_ma_zaner CASCADE CONSTRAINTS;
DROP TABLE projekcia CASCADE CONSTRAINTS;
DROP TABLE zamestnanec CASCADE CONSTRAINTS;
DROP TABLE zaner CASCADE CONSTRAINTS;
DROP TABLE cennik_vek CASCADE CONSTRAINTS;
DROP TABLE cennik_cas CASCADE CONSTRAINTS;
DROP TABLE vstupenka CASCADE CONSTRAINTS ;

-------------------------------------
------VYTVORENIE SEKVENCIÍ SQL-------
-------------------------------------

CREATE SEQUENCE kino_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE sal_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE sedadlo_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE zaner_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE film_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE projekcia_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE zamestnanec_seq
    START WITH 1
    INCREMENT BY 1;


-------------------------------------
------VYTVORENIE TABULIEK SQL--------
-------------------------------------

CREATE TABLE kino(
    ID      INT DEFAULT kino_seq.NEXTVAL PRIMARY KEY,
    adresa  VARCHAR2(50) NOT NULL ,
    nazov   VARCHAR2(50) NOT NULL
);

CREATE TABLE sal(
    ID      INT DEFAULT sal_seq.NEXTVAL PRIMARY KEY,
    cislo   INT NOT NULL ,
    zvuk    VARCHAR2(50) NOT NULL ,
    platno  VARCHAR2(25) NOT NULL,

    kino_ID INT NOT NULL,
    CONSTRAINT sal_kino_fk
                FOREIGN KEY (kino_ID) REFERENCES kino (ID) ON DELETE CASCADE
);

CREATE TABLE zamestnanec(
    ID          INT DEFAULT zamestnanec_seq.NEXTVAL PRIMARY KEY,
    meno        VARCHAR2(50) NOT NULL ,
    heslo       VARCHAR2(50) DEFAULT NULL,
    priezvisko  VARCHAR2(50) NOT NULL ,
    telefon     varchar(50) NOT NULL,
    veduci      INT DEFAULT 0,
    kino_ID INT NOT NULL,
    CONSTRAINT zamestnanec_kino_fk
                FOREIGN KEY (kino_ID) REFERENCES kino (ID) ON DELETE CASCADE
);

CREATE TABLE sedadlo(
    ID      INT DEFAULT sedadlo_seq.NEXTVAL PRIMARY KEY,
    cislo   INT NOT NULL,
    rad     INT NOT NULL,

    sal_ID INT NOT NULL,

    CONSTRAINT sedadlo_sal_fk
                    FOREIGN KEY (sal_ID) REFERENCES sal (ID) ON DELETE CASCADE

);

CREATE TABLE cennik_vek(
    od      INT NOT NULL,
    do      INT NOT NULL,
    PRIMARY KEY (od, do),
    cena    FLOAT NOT NULL
);

CREATE TABLE cennik_cas(
    od      varchar2(15) NOT NULL,
    do      varchar2(15) NOT NULL,
    PRIMARY KEY (od, do),
    cena    FLOAT NOT NULL
);

CREATE TABLE film(
    ID          INT DEFAULT film_seq.NEXTVAL PRIMARY KEY,
    nazov       VARCHAR2(50) NOT NULL,
    minutaz     VARCHAR2(15) NOT NULL,
    popis       VARCHAR2(1500)NOT NULL,
    pristupnost INT NOT NULL
);

CREATE TABLE projekcia(
    ID      INT DEFAULT projekcia_seq.NEXTVAL PRIMARY KEY,
    cas     varchar2(15) NOT NULL,
    datum   varchar2(15) NULL,
    jazyk   VARCHAR2(25) NOT NULL,
    titulky VARCHAR2(25) NOT NULL,
    dimension VARCHAR2(5) NOT NULL,
    cena    FLOAT NOT NULL,

    sal_ID INT NOT NULL,
    CONSTRAINT projekcia_sal_fk
                    FOREIGN KEY (sal_ID) REFERENCES sal (ID) ON DELETE CASCADE,

    film_ID INT NOT NULL,
    CONSTRAINT projekcia_film_fk
                    FOREIGN KEY (film_ID) REFERENCES film (ID) ON DELETE CASCADE
);

CREATE TABLE vstupenka(
    --generovanie kodu cez trigger
    kod         INT DEFAULT NULL PRIMARY KEY,
    meno        VARCHAR2(50) NOT NULL,
    priezvisko  VARCHAR2(50) NOT NULL,
    vek         INT NOT NULL,
    stav        VARCHAR2(25) DEFAULT NULL,
    email       VARCHAR2(25) NOT NULL,
    telefon     INT NOT NULL,
    cena        FLOAT NOT NULL,

    sedadlo_ID INT NOT NULL,
    CONSTRAINT Vstupenka_sedadlo_fk
                    FOREIGN KEY (sedadlo_ID) REFERENCES sedadlo (ID) ON DELETE CASCADE,


    projekcia_ID INT NOT NULL,
    CONSTRAINT vstupenka_projekcia_fk
                    FOREIGN KEY (projekcia_ID) REFERENCES projekcia (ID) ON DELETE CASCADE
);

CREATE TABLE zaner(
    ID      INT DEFAULT zaner_seq.NEXTVAL PRIMARY KEY,
    nazov   VARCHAR2(50) NOT NULL
);

CREATE TABLE film_ma_zaner(
    film_ID     INT NOT NULL,
    zaner_ID    INT NOT NULL,

    CONSTRAINT film_fk
               FOREIGN KEY (film_ID) REFERENCES film (ID) ON DELETE CASCADE,

    CONSTRAINT zaner_fk
               FOREIGN KEY (zaner_ID) REFERENCES zaner (ID) ON DELETE CASCADE,

    PRIMARY KEY (film_ID, zaner_ID)

);
-------------------------------------
------------INSERTY- SQL-------------
-------------------------------------

--KINÁ--
INSERT INTO kino (id ,adresa, nazov)
VALUES (default ,'Prieviza Nedožerská 33', 'Baník');

INSERT INTO kino (id, adresa, nazov)
VALUES (default, 'Prievidza Korzo', 'Cinemaa');

--ZAMESTNANCI--
INSERT INTO zamestnanec (id, meno, priezvisko, telefon, kino_ID, veduci, heslo)    --vedúci
VALUES (default ,'Samuel','Líška', '+421907111222', 1, 1, 'PW1');
INSERT INTO zamestnanec (id, meno, priezvisko, telefon, kino_ID)
VALUES (default ,'Boris','Štrbák', '+421906555423', 1);

INSERT INTO zamestnanec (id, meno, priezvisko, telefon, kino_ID)
VALUES (default ,'Emanuel','Bacigala', '+421987665432', 1);

INSERT INTO zamestnanec (id, meno, priezvisko, telefon, kino_ID)
VALUES (default ,'Dajmemumeno','Vojtech', '+421909876567', 2);

INSERT INTO zamestnanec (id, meno, priezvisko, telefon, kino_ID, veduci, heslo)    --vedúci
VALUES (default ,'John','Doe', '0909876543', 2, 1, 'PW2');

INSERT INTO zamestnanec (id, meno, priezvisko, telefon, kino_ID)
VALUES (default ,'Samo','Líšk', '0909879432', 2);


--SÁLY--
INSERT INTO SAL (id, cislo, zvuk, platno, kino_ID)
VALUES (default, 1, 'Dolby Digital 5.1', '16m', 1);

INSERT INTO SAL (id, cislo, zvuk, platno, kino_ID)
VALUES (default, 2, 'Dolby Digital 5.1', '22m', 1);

INSERT INTO SAL (id, cislo, zvuk, platno, kino_ID)
VALUES (default, 3, 'Dolby Digital 5.1', '16m', 1);

INSERT INTO SAL (id, cislo, zvuk, platno, kino_ID)
VALUES (default, 1, 'Dolby Digital 5.1', '16m', 2);

INSERT INTO SAL (id, cislo, zvuk, platno, kino_ID)
VALUES (default, 2, 'Dolby Digital 5.1', '16m', 2);


--SEDADLÁ--

--kino 1 sal 1
INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 1, 1, 1);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 2, 1, 1);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 3, 1, 1);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 1, 2, 1);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 2, 2, 1);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 3, 2, 1);
--kino 1 sal 2
INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 1, 1, 2);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 2, 1, 2);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 3, 1, 2);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 1, 2, 2);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 2, 2, 2);

INSERT INTO sedadlo(id, cislo, rad, sal_id)
VALUES (default, 3, 2, 2);

--CENNÍKY--
INSERT INTO cennik_cas(od, do, cena)
VALUES ('12:00', '17:00', 5.99);

INSERT INTO cennik_cas(od, do, cena)
VALUES ('17:00', '22:00', 6.99);

INSERT INTO cennik_vek(od, do, cena)
VALUES ('0', '15', 0.00);

INSERT INTO cennik_vek(od, do, cena)
VALUES ('15', '26', 1.00);

INSERT INTO cennik_vek(od, do, cena)
VALUES ('26', '62', 2.00);

INSERT INTO cennik_vek(od, do, cena)
VALUES ('62', '150', 1.00);

--FILMY--
INSERT INTO film(id, nazov, minutaz, popis, pristupnost)
VALUES(default, 'Bídníci', '105min' ,'Stéphane se nedávno připojil ke zvláštní kriminální jednotce v Montfermeilu, na předměstí Paříže. Spolu se svými kolegy Chrisem a Gwadou - oběma zkušenými členy týmu - rychle postřehne zvyšující se napětí mezi sousedními gangy. Když se v průběhu zatýkání ocitnou na útěku, dron zachytí každý jejich pohyb, každou akci…', 16);

INSERT INTO film(id, nazov, minutaz, popis, pristupnost)
VALUES(default,'Frčíme', '103min', 'Snímek Frčíme nás zavede do světa fantazie, ve kterém se představí dva elfští teenageři, kteří se vydají na pozoruhodnou výpravu, aby zjistili, zda ve světě zůstalo aspoň kousek toho magického.', 12);

INSERT INTO film(id, nazov, minutaz, popis, pristupnost)
VALUES(default, 'Neviditelný', '125min', 'Když Cecilia (Elisabeth Moss) pochopila, že chodí s psychopatem, bylo už pozdě. Izolovaná v luxusním sídle majetnického vynálezce si uvědomí, že má-li přežít, musí utéct. To se jí podaří..', 18);

INSERT INTO film(id, nazov, minutaz, popis, pristupnost)
VALUES(default, 'Fast and furious', '155min', 'Nuda nechodte tam ..', 16);

INSERT INTO film(id, nazov, minutaz, popis, pristupnost)
VALUES(default, 'Krstný otec', '220min', 'Gangsterské drama Kmotr, natočené podle stejnojmenného bestselleru Maria Puza, patří mezi přelomová díla tzv. Nového Hollywoodu, a to jak komerčně, tak umělecky..', 18);

INSERT INTO film(id, nazov, minutaz, popis, pristupnost)
VALUES(default, 'Krstný otec2', '240min', 'Gangsterské drama Kmotr, natočené podle stejnojmenného bestselleru Maria Puza, patří mezi přelomová díla tzv. Nového Hollywoodu, a to jak komerčně, tak umělecky..', 18);

INSERT INTO film(id, nazov, minutaz, popis, pristupnost)
VALUES(default, 'Krstný otec3', '250min', 'Gangsterské drama Kmotr, natočené podle stejnojmenného bestselleru Maria Puza, patří mezi přelomová díla tzv. Nového Hollywoodu, a to jak komerčně, tak umělecky..', 18);
--ŽÁNRE--
INSERT INTO zaner(id, nazov)
VALUES(default, 'Fantasy');

INSERT INTO zaner(id, nazov)
VALUES(default, 'Sci-fi');

INSERT INTO zaner(id, nazov)
VALUES(default, 'Komédia');

INSERT INTO zaner(id, nazov)
VALUES(default, 'Horror');

INSERT INTO zaner(id, nazov)
VALUES(default, 'Dráma');

--FILM-ŽÁNER--
INSERT INTO film_ma_zaner(film_ID, zaner_ID)
VALUES(1,1);

INSERT INTO film_ma_zaner(film_ID, zaner_ID)
VALUES(2,3);

INSERT INTO film_ma_zaner(film_ID, zaner_ID)
VALUES(3,2);

--PROJEKCIE--
INSERT INTO projekcia(id, cas, datum, jazyk, titulky, dimension, cena, sal_ID, film_ID)
VALUES(default, '15:00', '2020-21-04', 'cz', 'ziadne', '2D', '5,99', 1, 1);

INSERT INTO projekcia(id, cas, datum, jazyk, titulky, dimension, cena, sal_ID, film_ID)
VALUES(default, '18:00', '2020-21-04', 'en', 'cz', '3D', '6,99', 2, 2);

INSERT INTO projekcia(id, cas, datum, jazyk, titulky, dimension, cena, sal_ID, film_ID)
VALUES(default, '18:00', '2020-15-04', 'en', 'cz', '3D', '6,99', 2, 3);

INSERT INTO projekcia(id, cas, datum, jazyk, titulky, dimension, cena, sal_ID, film_ID)
VALUES(default, '18:00', '2020-30-04', 'en', 'cz', '2D', '6,99', 2, 4);

INSERT INTO projekcia(id, cas, datum, jazyk, titulky, dimension, cena, sal_ID, film_ID)
VALUES(default, '18:00', '2020-01-05', 'en', 'cz', '2D', '6,99', 2, 5);

--VSTUPENKY--
INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('John', 'Doe', 22, 'POTVRDENE', 'sample@email.com', '0909876543', 5.99, 1, 1);

INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('John', 'Doe', 22, 'POTVRDENE', 'sample@email.com', '0909876543', 5.99, 2, 1);

INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('John', 'Doe', 22, 'POTVRDENE', 'sample@email.com', '0909876543', 5.99, 3, 1);

INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('name3', 'subname3', 32, 'POTVRDENE', 'sample3@email.com', '0909876541', 5.99, 3, 2);

INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('name4', 'subname4', 25, 'POTVRDENE', 'sample4@email.com', '0909876545', 5.99, 4, 2);

INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('name5', 'subname5', 70, 'POTVRDENE', 'sampl5e@email.com', '0909876546', 5.99, 5, 2);

INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('name3', 'subname3', 12, 'POTVRDENE', 'sample3@email.com', '0909876541', 5.99, 3, 2);

INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('name4', 'subname4', 15, 'POTVRDENE', 'sample4@email.com', '0909876545', 5.99, 4, 2);

INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('name5', 'subname5', 17, 'POTVRDENE', 'sampl5e@email.com', '0909876546', 5.99, 5, 2);

INSERT INTO vstupenka(meno, priezvisko, vek, stav, email, telefon, cena, sedadlo_ID, projekcia_ID)
VALUES('name6', 'subname6', 70, 'Čaká na schválenie.', 'sampl5e@email.com', '0909876546', 6.99, 5, 2);

-------------------------------------
------------SELECTS- SQL-------------
-------------------------------------

--select vedúcich
SELECT * FROM zamestnanec WHERE veduci=1;
--select zamestnancov ktorý niesu vedúci iba v kine s ID 1
SELECT Meno, priezvisko FROM zamestnanec WHERE veduci=0 AND kino_ID=1;
--výpis lístkov na zamestnancovo telefónne číslo  -- spojenie 2 tabuliek
SELECT * FROM vstupenka INNER JOIN zamestnanec z on vstupenka.telefon = z.telefon;
--výpis projekcií filmov -- spojenie 2 tabuliek
SELECT Cas, Datum, Nazov FROM projekcia LEFT JOIN film f on projekcia.film_ID = f.ID;
--vypis sedadiel na jednotlivé projekcie
SELECT Cas, Datum, jazyk, titulky, dimension, cena, projekcia.sal_ID, cislo,rad FROM projekcia LEFT JOIN SEDADLO S on projekcia.sal_ID = S.SAL_ID;
--spojenie 3 tabuliek, vstupenky na projekciu-> projekcia daneho filmu -> detaily na vstupenku
SELECT kod, meno, priezvisko, email, telefon, p.cena, cas, datum, jazyk, nazov, minutaz, pristupnost FROM vstupenka INNER JOIN projekcia p on vstupenka.projekcia_ID = p.ID INNER JOIN film f on p.film_ID = f.ID;
--GROUP by s agregátnou funkciou count, Selectne počet kúpených vstupeniek na danú projekciu
SELECT
        projekcia_ID,
        COUNT(cena) bought
FROM
        vstupenka
GROUP BY
        projekcia_ID;
--Spojenie 3 tabuliek
--spojenie filmu a žánru, prepojenie prjekcií
-- a vstupeniek a následný výpočet zárobku na danom žánri
SELECT
       z.nazov,
       COUNT(z.nazov),
       SUM(v.cena)
FROM
     film
INNER JOIN film_ma_zaner fmz on film.ID = fmz.film_ID
INNER JOIN zaner z on fmz.zaner_ID = z.ID
INNER JOIN projekcia p on film.ID = p.film_ID
INNER JOIN vstupenka v on p.ID = v.projekcia_ID

GROUP BY
        z.nazov;
--Select zamestnanca, ktorý kúpil viac ako 2 vstupenky na svoje telefónne číslo(použitie exists)
SELECT *
FROM zamestnanec z
WHERE
    EXISTS(
            SELECT
                COUNT(*)
            FROM
                vstupenka v
            WHERE
                z.telefon = v.telefon
            GROUP BY
                z.Meno
            HAVING
                COUNT (*) > 2
        );
--Výpis filmov, na ktoré existuje projekcia
SELECT nazov
FROM film f
WHERE ID
    IN(
        SELECT p.film_ID
        FROM projekcia p
      );

-------------------------------------
------------TRIGGERY- SQL------------
-------------------------------------
--trigger na generovanie kodu pre tickety
CREATE SEQUENCE kod_num;
CREATE OR REPLACE TRIGGER kod_num
    BEFORE INSERT ON vstupenka
    FOR EACH ROW
BEGIN
    IF :NEW.kod IS NULL THEN
        :NEW.kod := kod_num.NEXTVAL+1000;
    END IF;
END;

--trigger
--Ak je zamestnanec vedúci -> musí mať prístup do systému zamestnancov takže potrebuje heslo(zahashované)
CREATE OR REPLACE TRIGGER adm
    BEFORE INSERT ON zamestnanec
    FOR EACH ROW
    WHEN(new.veduci = 1)
BEGIN
    IF :NEW.heslo IS NOT NULL THEN
        :NEW.heslo :=
        DBMS_OBFUSCATION_TOOLKIT.MD5(
            input => UTL_I18N.STRING_TO_RAW(:NEW.heslo)
        );
    END IF;
END;

--------------Triggery výpis----------
--vstupenky sa indexujú podľa triggeru vyššie od 1000 + (každá nová má o 1 váčší kód)
SELECT * FROM vstupenka;

--vedúci pobočky, musí mať aj heslo pre prístup do systému.(trigger to zistí a zahashuje)
SELECT meno,priezvisko,heslo from zamestnanec WHERE veduci = 1;


-------------------------------------
-----------Procedúry- SQL------------
-------------------------------------

--Procedúra "film_earnings" spočíta zárobok daného filmu (podľa ID)
--SELECT film,ID FROM film;

CREATE OR REPLACE PROCEDURE film_earnings(film_id NUMBER) AS
  BEGIN
    DECLARE CURSOR cursor_cost is
    SELECT f.nazov, P.cena
    FROM  projekcia P, film F
    WHERE P.id = film_id AND F.id = film_id;
            name film.nazov%type;
            cost projekcia.cena%TYPE;
            total_cost projekcia.cena%TYPE;
            BEGIN
                total_cost := 0;
                OPEN cursor_cost;
                LOOP
                    FETCH cursor_cost INTO name, cost;
                    EXIT WHEN cursor_cost%NOTFOUND;
                    total_cost := total_cost + cost;
                END LOOP;
                CLOSE cursor_cost;
                DBMS_OUTPUT.put_line('Film: ' || name || ' ,celkový zárobok:' || total_cost || '€');
            END;
    END;
--použitie procedúry:
BEGIN film_earnings(1); END;

--profedúra na výpočet percentuálnej návšetevnosti detí.
--pri filmoch od 18+ vracia exception.
CREATE OR REPLACE PROCEDURE under18_attendance(ID_film NUMBER)
AS
    total_tickets NUMBER;
    young_tickets NUMBER;
    young_percentage NUMBER;
BEGIN
    SELECT COUNT(*) INTO total_tickets FROM vstupenka, projekcia WHERE projekcia.film_ID=ID_film;
    SELECT COUNT(*) INTO young_tickets FROM vstupenka INNER JOIN projekcia P on vstupenka.projekcia_ID = P.ID AND P.film_ID=ID_film WHERE vstupenka.vek < 18;

    young_tickets := young_tickets*100;
    young_percentage := young_tickets / total_tickets;

    DBMS_OUTPUT.put_line(
        'Percentuálna návštevnosť mladších ako 18 na danú projekciu je: ' || young_percentage);
    EXCEPTION WHEN ZERO_DIVIDE THEN
    BEGIN
        IF young_tickets = 0 THEN
            DBMS_OUTPUT.put_line('Žiaden návštevník mladší ako 18 nebol nájdeny.');
        END IF;
    END;
END;
--použitie procedúry:
BEGIN under18_attendance(2); END;

-------------------------------------
-----------EXPLAIN  PLAN-------------
-------------------------------------
DROP INDEX index_telefon;

EXPLAIN PLAN FOR
SELECT Z.meno,Z.priezvisko,count(*) AS count_tickets
FROM zamestnanec Z, vstupenka V
WHERE Z.telefon = V.telefon
GROUP BY Z.meno, Z.priezvisko;
SELECT * FROM TABLE(DBMS_XPLAN.display());

CREATE INDEX index_telefon ON vstupenka(telefon);
--optimalizovane použitím indexu
EXPLAIN PLAN FOR
SELECT Z.meno,Z.priezvisko,count(*) AS count_tickets
FROM zamestnanec Z, vstupenka V
WHERE Z.telefon = V.telefon
GROUP BY Z.meno, Z.priezvisko;
SELECT * FROM TABLE(DBMS_XPLAN.display());

-------------------------------------
-----------UDELENIE PRÁV-------------
-------------------------------------
--pre tabuľky
GRANT ALL ON cennik_cas TO xstrba05;
GRANT ALL ON cennik_vek TO xstrba05;
GRANT ALL ON film TO xstrba05;
GRANT ALL ON film_ma_zaner TO xstrba05;
GRANT ALL ON kino TO xstrba05;
GRANT ALL ON projekcia TO xstrba05;
GRANT ALL ON sal TO xstrba05;
GRANT ALL ON sedadlo TO xstrba05;
GRANT ALL ON vstupenka TO xstrba05;
GRANT ALL ON zamestnanec TO xstrba05;
GRANT ALL ON zaner TO xstrba05;

--pre procedúry
GRANT EXECUTE ON film_earnings TO xstrba05;
GRANT EXECUTE ON under18_attendance TO xstrba05;

-------------------------------------
------MATERIALIZOVANÝ POHĽAD---------
-------------------------------------
DROP MATERIALIZED VIEW zamestnanci;
DROP MATERIALIZED VIEW LOG ON zamestnanec;

CREATE MATERIALIZED VIEW LOG ON zamestnanec WITH PRIMARY KEY,ROWID(meno)INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW zamestnanci
CACHE                        --postupne optimalizuje čítanie z pohľadu
BUILD IMMEDIATE              --naplní hned po vytvorení
REFRESH FAST ON COMMIT       --optimalizu čítanie
AS SELECT id,meno, priezvisko as zamestnanec_info FROM zamestnanec;

GRANT ALL ON zamestnanci TO xstrba05;

SELECT * from zamestnanci;
INSERT INTO zamestnanec (meno,priezvisko, telefon, veduci, kino_ID) VALUES ('Patrik', 'Kotula', '0918765234', 0, 2);
COMMIT;
SELECT * from zamestnanci;