

-- ALTER
-- ADAUGARE COLOANE TABEL
ALTER TABLE abonati
ADD (
telefon VARCHAR2(10) UNIQUE,
email VARCHAR2(20)
);
-- MODIFICARE COLOANA TABELA: MARIT DIMENSIUNE + ADD CONSTRAINT
ALTER TABLE abonati
MODIFY (adresa VARCHAR2(40) NOT NULL);
-- REDENUMIRE COLOANE
ALTER TABLE abonati
RENAME COLUMN adresa TO domiciliu;
-- STERGERE COLOANE
ALTER TABLE abonati
DROP COLUMN domiciliu;
-- ADAUGARE RESTRICTIE
ALTER TABLE abonati
ADD CONSTRAINT  nn_email CHECK(email IS NOT NULL);
--sau
ALTER TABLE abonati
MODIFY (email NOT NULL);

-- sa se adauge o restrictie coloanei email prin care sa se verifice formatul standard de adresa de email

ALTER TABLE abonati 
ADD CONSTRAINT verifica_email CHECK(email LIKE '%@%.%');

-- sa se adauge o restrictie coloanei telefon prin care sa se verifice lungimea sirului introdus (=10)

ALTER TABLE abonati
ADD CONSTRAINT telefon_check CHECK(LENGTH(telefon)=10);   -- telefonul este de tip VARCHAR2


-- sa se adauge o restrictie coloanei cnp prin care sa se verifice lungimea sirului introdus (=13)

ALTER TABLE abonati
ADD CONSTRAINT cnp_check CHECK(LENGTH(TRIM(cnp))=13);  -- CNP este de tip CHAR

ALTER TABLE abonati
DROP CONSTRAINT UQ_CNP;   --indicati un nume valid de restrictie, verificand denumirile din tab-ul Constraints

ALTER TABLE abonati
DISABLE CONSTRAINT nn_nume;

ALTER TABLE abonati
ENABLE CONSTRAINT nn_nume;

ALTER TABLE fise 
RENAME TO fise_imprumut;

--INSERT
--INSERT INTO tabela VALUES (..., ..., ....);
DESCRIBE abonati;

INSERT INTO abonati VALUES ('A1','1234567891234','Ionescu','Ion','Iasi','1234567891','ion@a.ro');

INSERT INTO abonati (nr_abonat, nume, prenume, email) VALUES ('A2','Ionescu','Ioana','a@a.ro');

ALTER TABLE abonati
MODIFY (nume DEFAULT 'Anonim');

INSERT INTO abonati (nr_abonat, prenume, email) VALUES ('A3','Maria','m@a.ro');

INSERT INTO abonati (nr_abonat, prenume, email) VALUES ('&a', '&b', '&c');  --citire de la tastatura prin variabile de substitutie

-- UPDATE
--UPDATE tabela
--SET coloana1=valoare, coloana2=valoare
--WHERE conditii;

-- sa se modifice localitatea (=Bucuresti) pentru abonatii care nu au telefonul completat
UPDATE abonati
SET localitate='Bucuresti' 
WHERE telefon IS NULL;

rollback;

--DELETE
--DELETE FROM tabela WHERE conditii;

DELETE FROM abonati;

-- daca avem legatura 1:n stergem mai intai tabela cu n legaturi (tabela copil)
-- DROP 
DROP TABLE abonati CASCADE CONSTRAINTS; -- CASCADE CONSTRAINTS sterge restrictiile si apoi tabelele devenite independente
DROP TABLE carti CASCADE CONSTRAINTS;
DROP TABLE fise CASCADE CONSTRAINTS;
DROP TABLE detalii_fise CASCADE CONSTRAINTS;

FLASHBACK TABLE abonati TO BEFORE DROP;

/*
--crearea tabelei Abonati cu indicarea restrictiilor in-line (la nivel de coloana)
CREATE TABLE abonati (
    nr_abonat CHAR(3) CONSTRAINT pk_abonati PRIMARY KEY,
    cnp CHAR(13) CONSTRAINT uq_cnp UNIQUE,
    nume VARCHAR2(25) CONSTRAINT nn_nume NOT NULL,
    prenume VARCHAR2(25) NOT NULL,
    adresa VARCHAR2(30),
    localitate VARCHAR2(20)
);

--crearea tabelei Fise cu indicarea restrictiilor out-of-line (la nivel de tabela)
CREATE TABLE fise (
    nr_fisa          NUMBER,
    data_imprumut    DATE,
    nr_abonat        CHAR(3),
    CONSTRAINT pk_fise PRIMARY KEY (nr_fisa),
    CONSTRAINT nn_data CHECK (data_imprumut IS NOT NULL),
    CONSTRAINT fk_abonati FOREIGN KEY (nr_abo>nat) REFERENCES abonati(nr_abonat)
);

--crearea tabelei Carti cu indicarea sumara a restrictiilor (fara a scrie sintaxa completa: CONSTRAINT...)
CREATE TABLE carti (
    ISBN   CHAR(10) PRIMARY KEY,
    titlu_carte  VARCHAR2(20),
    autori  VARCHAR2(60) NOT NULL,
    CHECK (titlu_carte IS NOT NULL)
);

--crearea tabelei Detalii_fise
CREATE TABLE detalii_fise (
    ISBN CHAR(10) CONSTRAINT fk_carti REFERENCES carti(ISBN), --definirea in-line a restrictiei de cheie externa !! FARA indicarea explicita a tipului de restrictie FOREIGN KEY
    nr_fisa NUMBER,
    data_retur Date,
    CONSTRAINT fk_fise FOREIGN KEY (nr_fisa) REFERENCES fise(nr_fisa), --definirea out-of-line a restrictiei de cheie externa
    CONSTRAINT pk_detalii PRIMARY KEY (ISBN, nr_fisa) -- definirea cheii primare compuse !! se poate numai out-of-line
);
*/
