

/*

           SQL EXERCISES 

*/


USE dbslide;



-- Exercice 1.2

DROP TABLE IF EXISTS T_MAINTENANCE_MTN;

CREATE TABLE T_MAINTENANCE_MTN(
Jour varchar(3),
Machine varchar(20),
Numéro int NOT NULL,
Vitesse int,
Température int,
Heure datetime, 
Evénement varchar(50),
CONSTRAINT PK_primary_key PRIMARY KEY(Jour, Numéro, Heure),
CONSTRAINT UK_mtn UNIQUE(Numéro),
CHECK(Vitesse>0)
);


-- Looking for different tables

select* from course
select * from grade
select * from professor
select * from student
select * from section;




-- PART II : SELECT.. FROM..WHERE..ORDER BY





--Exercise 2.1

select last_name, first_name 
from student;


select * from section
select * from professor
select s.section_id, s.section_name,p.professor_name
from section s
left join professor p on p.section_id=s.section_id;


-- Exercise 2.1.2

select concat(last_name, ' ',first_name) as "Nom de l'étudiant",
       birth_date  as "Date de naissance",
	   login,
	   year_result as " Résultat de l'année"
from student;


-- Exercise 2.1.3

select concat(last_name, ' ',first_name) as "Nom complet",
       student_id,
	   cast(birth_date as char(11)) as "Date de naissance"
from student;


-- Exercise 2.1.4

SELECT CONCAT(student_id, '|', first_name, '|', last_name, '|', CAST(birth_date as char(10)), '|', login, '|', section_id, '|', year_result, '|', course_id) AS "Info Etudiant"
FROM student;

-- Exercise 2.2.1


select login,
       year_result
from student
where year_result >16;



-- Exercise 2.2.2

select last_name,
       section_id
from student
where first_name like 'Georges';


-- Exercise 2.2.3

select last_name,
       year_result
from student
where year_result between 12 and 16;



-- Exercise 2.2.4

select last_name,
       section_id,
       year_result
from student
where section_id not in (1010,1020,1110);


-- Exercise 2.2.5

select last_name,
       section_id
from student
where last_name like '%r';
   

-- Exercise 2.2.6

select last_name,
       year_result
from student
where last_name like '__n%' and year_result>10;


-- Exercise 2.2.7

select last_name,
       year_result
from student
where year_result<=3
order by year_result desc;



-- Exercise 2.2.8

select concat(first_name,last_name) as 'Nom complet',
       year_result
from student
where section_id=1010
order by last_name;


-- Exercise 2.2.9

select last_name as 'Nom',
       section_id,
       year_result
from student
where (section_id in (1010,1020)) and (year_result not between 12 and 18)
order by  section_id, year_result desc;




-- Exercise 2.2.10

select last_name as 'Nom',
       section_id,
       year_result*5 as 'Résultat sur 100'
from student
where (section_id like '13%') and  (year_result*5<=60)
order by 'Résultat sur 100' desc;




--- Partie III :  LES FONCTIONS

--- Exercice 2.3.7

select avg(year_result) as 'Résultat moyen'
from student;


--- Exercice 2.3.8

select max(year_result) as 'Plus haut résultat'
from student;


--- Exercice 2.3.9

select sum(year_result) as 'Somme des résultat annuel'
from student;

--- Exercice 2.3.10

select min(year_result) as 'Plus faible résultat annuel'
from student;

-- Exercice 2.3.11

select count(*) as 'Nombre de ligne de la table student'
from student;




-- Exercice 2.3.12

select login,
       substring(cast(birth_date as char(11)), 7,11) as 'Année de naissance'
from student
where substring(cast(birth_date as char(11)), 7,11) > 1970;



-- Exercice 2.3.13

select login,
       last_name as "Nom de l'étudiant"
from student
where len(last_name) >=8;


-- Exercice 2.3.14

select upper(last_name) as 'Nom de famille',
       first_name as 'Prenom',
	   year_result
from student
where year_result >=16
order by year_result desc;



-- Exercice 2.3.15

select last_name as 'Nom',
       first_name as 'Prenom',
	   login,
	   lower(concat(substring(first_name, 1,2), substring(last_name,1,4))) as 'Nouveau login'
from student
where year_result between 6 and 10;


select getdate();


-- Exercice 2.3.16

select last_name as 'Nom',
       first_name as 'Prenom',
	   substring(cast(birth_date as char(11)),8,11) as 'Année de naissance',
	   login,
	   concat(right(first_name, 4),substring(cast(getdate()-birth_date as char(11)),10,11)) as 'Nouveau login'
from student
where year_result in (10,12,14);


-- Exercice 2.3.17

select last_name,
       login,
	   year_result
from student
where (upper(substring(last_name,1,1)) like 'D%') or (upper(substring(last_name,1,1)) like 'M%') or (upper(substring(last_name,1,1)) like 'D%')
order by birth_date ;



-- Exercice 2.3.18

select last_name,
       login,
	   year_result
from student
where (year_result%2=1) and (year_result >10)
order by year_result desc;

-- Exercice 2.3.19

select count(last_name) as "Nombre d'étudiant"
from student
where len(last_name)>=7;

-- Exercice 2.3.20

select last_name as 'Nom',
       year_result as 'Résultat annuel',
case 
    when year_result>=12 then 'OK'
	else 'KO'
end as 'Statut'	    
from student
where substring(cast(birth_date as char(11)),8,11)< 1955;


-- Exercice 2.3.21


select last_name as 'Nom',
       year_result as 'Résultat annuel',
case 
    when year_result<10 then 'inférieure'
	when year_result=10 then 'neutre'
	else 'supérieure'
end as 'Catégorie'	    
from student
where substring(cast(birth_date as char(11)),8,11) between 1955 and 1965;


-- Exercice 2.3.22

select last_name,
       year_result,
	   cast(birth_date as char(11)) as 'Date de naissance'
from student
where substring(cast(birth_date as char(11)),8,11) between 1975 and 1985;


-- Exercice 2.3.23


select last_name as 'Nom',
       month(birth_date) as 'Mois de naissance',
	   year_result as 'Résultat annuel', 
	   NULLIF(year_result,4) as 'Résultat annuel corrigé'
from student
where (month(birth_date) not between 1 and 3) and (year_result <7);







-- PARTIE IV: GROUP BY....HAVING

-- Exercice 2.4.7

select section_id,
       max(year_result) as 'Résultat maximum'
from student
group by section_id;


-- Exercice 2.4.8

select section_id,
       avg(cast(year_result as float)) as 'Moyenne'
from student
where left(section_id,2) like '10%'
group by section_id;



-- Exercice 2.4.9

select month(birth_date) as 'Mois de naissance',
       avg(cast(year_result as float)) as 'Moyenne'
from student
where year(birth_date) between 1970 and 1985
group by month(birth_date);




-- Exercice 2.4.10

select section_id,
       avg(cast(year_result as float)) as 'Moyenne'
from student
group by section_id
having count(section_id)>3;


-- Exercice 2.4.11

select section_id,
       avg(year_result) as 'Moyenne',
	   max(year_result) as 'Résultat Maximum'
from student
group by section_id
having avg(year_result)>8;




-- PARTIE V: CUBE ET ROLLUP

-- Exercice 2.5.6

select section_id,
       course_id,
	   avg(cast(year_result as float)) as 'Moyenne'
from student
where section_id in (1010,1320)
group by  section_id, course_id with rollup;

-- Exercice 2.5.7


select course_id,
       section_id,
	   avg(cast(year_result as float)) as 'Moyenne'
from student
where section_id in (1010,1320)
group by cube (course_id, section_id);



-- Partie VI: LES JOINTURES


-- Exercice 2.6.1
select * from section
select* from course
select * from professor;

select c.course_name as 'Nom_cours',
       Nom_section,
	   Nom_prof
from (select  s.section_name as 'Nom_section',
	    p.professor_name as 'Nom_prof',
		professor_id
from professor p
join section s on s.section_id=p.section_id) t
join course c on t.professor_id=c.professor_id;
       


select c.course_name,
       s.section_name,
	   p.professor_name
from course c
join professor p on c.professor_id=p.professor_id
join section s on s.section_id=p.section_id;




-- Exercice 2.6.2

select * from section
select* from student;


select s.section_id,
       s.section_name,
       st.last_name
from section s
join student st on s.delegate_id=st.student_id
order by s.section_id desc;




-- Exercice 2.6.3

select * from section
select * from professor;


select s.section_id,
       s.section_name,
	   p.professor_name
from section s
left join professor p on s.section_id=p.section_id
order by s.section_id desc;



-- Exercice 2.6.4

select s.section_id,
       s.section_name,
	   p.professor_name
from section s
left join professor p on s.section_id=p.section_id
where p.professor_name is not null
order by s.section_id desc;



-- Exercice 2.6.5
select * from student
select * from grade;


select st.last_name,
       st.year_result,
	   g.grade
from student st
join grade g on st.year_result between g.lower_bound and g.upper_bound
where st.year_result >=12
order by g.grade;



-- Exercice 2.6.6


select * from section
select * from professor
select * from course;




select p.professor_name,
       s.section_name,
	   c.course_name,
	   c.course_ects
from professor p
left join course c on p.professor_id=c.professor_id
join section s on p.section_id=s.section_id
order by c.course_ects desc;


-- Exercice 2.6.7

select * from professor
select * from course;


select p.professor_id,
       sum(c.course_ects) as 'ECTS_TOT'
from professor p
left join course c on p.professor_id=c.professor_id
group by p.professor_id
order by 'ECTS_TOT' desc;




-- Exercice 2.6.8



select * from professor
select * from student;

select t.last_name,
       t.first_name,
	   t.Catégorie

from (select last_name,
       first_name,
	   replace(left(last_name,1),left(last_name,1),'S') as 'Catégorie'
from student
union 
select professor_name as 'last_name',
       professor_surname as 'first_name',
       replace(left(professor_name,1),left(professor_name,1),'P') as 'Catégorie'
from professor) as t 
where len(last_name)>8;


-- Exercice 2.6.9


select section_id
from section
where section_id not in (select s.section_id
from section s
join professor p on p.section_id=s.section_id);




--- Partie VII: LES SOUS-REQUETES

-- Exercice 2.7.1

select * from student


select section_id,
       first_name,
	   last_name
from student
where section_id in (select section_id
from student
where upper(last_name) ='ROBERTS') and upper(last_name)!='ROBERTS';



-- Exercice 2.7.2


select first_name,
       last_name,
	   year_result
from student
where year_result >2*(select avg(year_result) 
from student);


-- Exercice 2.7.3

select * from section
select * from professor

select tab.section_id
from(select s.section_id,
       p.professor_name
from section s
left join professor p on s.section_id=p.section_id) as tab
where tab.professor_name is null;



-- Exercice 2.7.4


select * from section
select * from professor

select first_name,
       last_name,
	   cast(birth_date as char(11)) as 'Date de naissance',
	   year_result
from student
where month(birth_date) =(select month(professor_hire_date)
                          from professor
                          where upper(professor_name)='GIOT');




-- Exercice 2.7.5

select * from student
select * from grade

select gr.first_name,
       gr.last_name,
	   gr.year_result
from
(select  st.first_name,
       st.last_name,
	   st.year_result,
	   g.grade
from student st
join grade g on st.year_result between g.lower_bound and g.upper_bound ) as gr
where gr.grade='TB';





-- Exercice 2.7.6

select * from student
select * from section

select section_id,
       first_name,
	   last_name
from student
where section_id=
(select s.section_id
from student st
join section s on s.delegate_id=st.student_id
where  upper(st.last_name)='Marceau');



-- Exercice 2.7.7

select tb.section_id,
       tb.section_name
from
(select count(st.student_id) as 'Nombre',
      st.section_id,
	  s.section_name
from student st
join section s on s.section_id=st.section_id
group by st.section_id, s.section_name
)as tb
where tb.Nombre >4;


-- Exercice 2.7.8


select st.first_name,
       st.last_name,
	   st.year_result,
	   st.section_id
from student st
join
(
select section_id,
	   max(year_result) as 'Note maximale',
	   avg(year_result) as 'Moyenne des résultats'
from student
group by section_id
)  tb on (st.year_result=tb.[Note maximale]) and(st.section_id=tb.section_id)
where tb.[Moyenne des résultats]>=10;



-- Exercice 2.7.8



with moyennes (section_id, moyenne)
as
(
	select section_id, avg(year_result) moyenne
	from student
    group by section_id
)                       
SELECT section_id, moyenne
FROM moyennes
Where moyenne = (select max(moyenne)
				 FROM moyennes);











































