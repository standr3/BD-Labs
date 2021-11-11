----seminar 7 JONCTIUNI
--Tipuri de jonctiuni> interna (inner join), externa (left outer join, right outer join, full outer join)

--***Jonctiunea interna
--SQL-Oracle
select a.nume, a.salariul, d.denumire_departament
from angajati a, departamente d
where a.id_departament=d.id_departament; --cond de jonctiune

--SQL-standard
select a.nume, a.salariul, d.denumire_departament
from angajati a INNER JOIN departamente d
on a.id_departament=d.id_departament--cond de jonctiune
where salariul>1000;

--***Jonctiunea externa
--LEFT
--afis info despre ang inclusi in dept, dar si cei care nu fac parte din niciun dep
--SQL-standard
select a.nume, a.salariul, d.denumire_departament
from angajati a LEFT OUTER JOIN departamente d
on a.id_departament=d.id_departament--cond de jonctiune
where salariul>1000;

--SQL-Oracle
select a.nume, a.salariul, d.denumire_departament
from angajati a, departamente d
where a.id_departament=d.id_departament(+); --cond de jonctiune

--RIGHT
--afis info despre ang inclusi in dept, dar si DESPRE DEP FARA ANG
--SQL-standard
select a.nume, a.salariul, d.denumire_departament
from angajati a RIGHT OUTER JOIN departamente d
on a.id_departament=d.id_departament--cond de jonctiune
where salariul>1000;

--SQL-Oracle
select a.nume, a.salariul, d.denumire_departament
from angajati a, departamente d
where a.id_departament(+)=d.id_departament; --cond de jonctiune

--FULL
--afis info despre ang inclusi in dept, dar si DESPRE DEP FARA ANG+ANG FARA DEP
--SQL-standard
select a.nume, a.salariul, d.denumire_departament
from angajati a FULL OUTER JOIN departamente d
on a.id_departament=d.id_departament--cond de jonctiune
where salariul>1000;

--SQL-Oracle
select a.nume, a.salariul, d.denumire_departament
from angajati a, departamente d
where a.id_departament(+)=d.id_departament
UNION
select a.nume, a.salariul, d.denumire_departament
from angajati a, departamente d
where a.id_departament=d.id_departament(+)
; --cond de jonctiune

--***
SELECT a.nume||' '||a.prenume as nume_complet, round(((sysdate-data_angajare)/365),2) as vechimea, f.denumire_functie, d.denumire_departament
from angajati a, functii f, departamente d
where a.id_functie=f.id_functie and a.id_departament=d.id_departament;

select a.id_angajat, a.nume, a.salariul, a.id_manager, m.nume, m.id_angajat
from angajati a, angajati m --self join
where a.id_manager=m.id_angajat;

select a.id_angajat, a.nume, a.salariul, a.id_manager, m.nume nume_manager
from angajati a left join angajati m --self join
where a.id_manager=m.id_angajat;
