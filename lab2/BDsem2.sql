-- BAZA DE DATE : ansamblu de tabele interconectate + dictionarul datelor (contine metadata)

--crearea tabelei Abonati cu indicarea restrictiilor in-line (la nivel de coloana)
CREATE TABLE abonati ( -- numele e unic
    nr_abonat CHAR(3) CONSTRAINT pk_abonati PRIMARY KEY, -- numele e unic
    cnp CHAR(13) CONSTRAINT uq_cnp UNIQUE, -- restrictie INLINE
    nume VARCHAR2(25) CONSTRAINT nn_nume NOT NULL,
    prenume VARCHAR2(25) NOT NULL, -- prescurtarea restrictiei; numele e alocat automat; nu poate fi specificat decat la nivelul coloanei
    adresa VARCHAR2(30),
    localitate VARCHAR2(20)
    -- CONSTRAINT nume_restrictie TIP_RESTRICTIE (<coloana asociata/diverse conditii>) -> IN LINE
);

-- restrictiile la nivel de coloana -> definire IN LINE
-- restrictiile la nivel de tabela ->  definire OUT OF LINE



--crearea tabelei Carti cu indicarea sumara a restrictiilor (fara a scrie sintaxa completa: CONSTRAINT...)
CREATE TABLE carti (
    ISBN   CHAR(10),
    titlu_carte  VARCHAR2(20),
    autori  VARCHAR2(60), -- NOT NULL,
--    CHECK (titlu_carte IS NOT NULL),
    CONSTRAINT pk_carti PRIMARY KEY (ISBN),
    CONSTRAINT nn_titlu CHECK(titlu_carte IS NOT NULL)
);


--crearea tabelei Fise cu indicarea restrictiilor out-of-line (la nivel de tabela)
CREATE TABLE fise (
    nr_fisa          NUMBER PRIMARY KEY,
    data_imprumut    DATE NOT NULL,
    nr_abonat        CHAR(3), -- IN LINE: <CONSTRAINT fk_abonati> REFERENCES abonati(nr_abonat)
--    CONSTRAINT pk_fise PRIMARY KEY (nr_fisa),
--    CONSTRAINT nn_data CHECK (data_imprumut IS NOT NULL),
    CONSTRAINT fk_abonati FOREIGN KEY (nr_abonat) REFERENCES abonati(nr_abonat)
);

--crearea tabelei Detalii_fise
CREATE TABLE detalii_fise (
    ISBN CHAR(10) CONSTRAINT fk_carti REFERENCES carti(ISBN), --definirea in-line a restrictiei de cheie externa !! FARA indicarea explicita a tipului de restrictie FOREIGN KEY
    nr_fisa NUMBER,
    data_retur Date,
    CONSTRAINT fk_fise FOREIGN KEY (nr_fisa) REFERENCES fise(nr_fisa), --definirea out-of-line a restrictiei de cheie externa
    CONSTRAINT pk_detalii PRIMARY KEY (ISBN, nr_fisa) -- definirea cheii primare compuse !! se poate numai out-of-line
);
