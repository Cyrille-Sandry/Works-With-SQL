use PortfolioProjectSQL;



 /* See how data look like */

 -- The first table

select * 
from PortfolioProjectSQL.dbo.Table1;

-- The second table

select * 
from PortfolioProjectSQL.dbo.Table2;



/* Number of rows into our tables */

-- Number of rows into the first table
select count(*)
from PortfolioProjectSQL.dbo.Table1;

-- Number of rows into the second table
select count(*)
from PortfolioProjectSQL.dbo.Table2;

/* Data from the state Jharkhand and bihar */

select *
from PortfolioProjectSQL.dbo.Table1
where lower(State) in ('jharkhand', 'bihar');  



/* Population in Indian */

select sum(population) as population
from PortfolioProjectSQL.dbo.Table2;




/* Average growth of Indian  population */
select round(avg(Growth),4) as Average_growth
from PortfolioProjectSQL.dbo.Table1;



/* Average growth of Indian  population by state */

select State,
       round(avg(Growth),4) as Average_growth
from PortfolioProjectSQL.dbo.Table1
group by State
order by Average_growth desc;



-- The top 5 growth states

select top(5) State,
       round(avg(Growth),4) as Average_growth
from PortfolioProjectSQL.dbo.Table1
group by State
order by Average_growth desc;



/* Average Sex_Ratio of Indian  population by state */

select State,
       round(avg(Sex_Ratio),4) as Average_Sex_Ratio
from PortfolioProjectSQL.dbo.Table1
group by State
order by Average_Sex_Ratio desc;


-- The bottom 5 states showing the lowest Sex ratio

select top 5 State,
       round(avg(Sex_Ratio),4) as Average_growth
from PortfolioProjectSQL.dbo.Table1
group by State
order by Average_growth asc;





/* Average literacy of Indian  population by state */

select State,
       round(avg(Literacy),4) as Average_literacy
from PortfolioProjectSQL.dbo.Table1
group by State
order by Average_literacy desc;


-- The bottow 5 states showing the lowest Sex ratio

select top 5 State,
       round(avg(Literacy),4) as Average_literacy
from PortfolioProjectSQL.dbo.Table1
group by State
order by Average_literacy desc;


-- Another way of selecting the top 5 countries with highest average literacy using the with statement combined with row_number()

with cte as
(select  *,
		ROW_NUMBER() over (order by Average_literacy desc ) as RowNum
from (
select state,
       avg(Literacy) as Average_literacy
from PortfolioProjectSQL.dbo.Table1      
group by State
) tab
)
select State,
       Average_literacy
from cte
where RowNum<=5m^m:


--- Using  temp table for selecting the top 5 countries with highest average literacy


drop table if exists #top5states;
create table #top5states(
State nvarchar(255),
topstate float)

insert into #top5states
select state,
       round(avg(Literacy),2) as Average_literacy
from PortfolioProjectSQL.dbo.Table1 
group by State
order by Average_literacy desc;



select  top 3 *
from #top5states
order by topstate desc;





--- Using temp table for selecting the 5 countries with lower average literacy

drop table if exists #bottom5states;
create table #bottom5states(
State nvarchar(255),
topstate float)

insert into #bottom5states
select state,
       round(avg(Literacy),2) as Average_literacy
from PortfolioProjectSQL.dbo.Table1 
group by State
order by Average_literacy asc;


select  top 5 *
from #bottom5states
order by topstate asc;


-- Combine the 5 top countries with the 5 bottom countries

select *
from (
select  top 3 *
from #top5states
order by topstate desc) as Top5
union all
select *
from (
select  top 5 *
from #bottom5states
order by topstate asc) as Bottom5



/* State starting with letter A */

select distinct State
from PortfolioProjectSQL.dbo.Table1 
where upper(State) like 'A%'





/* Compute the number of Males and the number of Females in the Indian population */


select t1.District,
       t1.State,
       t1.Sex_Ratio,
	   t2.population
from PortfolioProjectSQL.dbo.Table1   t1
Join PortfolioProjectSQL.dbo.Table2   t2
     on t1.District=t2.District;


       --- Gender ratio is the total number of Females divided by the total number of Males (Sex_Ratio= total Female/total Male)

       ---  Total Male= Population/(1+Sex_Ratio) and Total Female= (Population . Sex_Ratio)/(1+Sex_Ratio)


       --- Total Males and Total Females by district
select t.District,
       t.State,
	   round(t.population/(1+ t.Sex_Ratio),0) as Males,
	   round((t.population*t.Sex_Ratio)/(1+t.Sex_Ratio),0) as Females,
	   t.Sex_Ratio,
	   t.population
from (
select t1.District,
       t1.State,
       t1.Sex_Ratio/1000 as Sex_Ratio,
	   t2.population
from PortfolioProjectSQL.dbo.Table1   t1
Join PortfolioProjectSQL.dbo.Table2   t2
     on t1.District=t2.District)  t

--- Total Males and Total Females by state

select 
       tab.State,
	   sum(tab.Males) as Total_males,
	   sum(tab.Females) as Total_females,
	   sum(tab.population) as population,
	   round((sum(tab.Females))/sum(tab.Males),3) as SexRatioByState
from (
select t.District,
       t.State,
	   round(t.population/(1+ t.Sex_Ratio),0) as Males,
	   round((t.population*t.Sex_Ratio)/(1+t.Sex_Ratio),0) as Females,
	   t.Sex_Ratio,
	   t.population
from (
select t1.District,
       t1.State,
       t1.Sex_Ratio/1000 as Sex_Ratio,
	   t2.population
from PortfolioProjectSQL.dbo.Table1   t1
Join PortfolioProjectSQL.dbo.Table2   t2
     on t1.District=t2.District)  t
) tab
group by tab.State



-- Total Males and Total females in Indian

select sum(ftab.Total_males) as TotalMalesInIndia,
       sum(ftab.Total_females) as TotalFemalesInIndia,
	  round( sum(ftab.Total_females)/sum(ftab.Total_males),2) as SexRatioInIndia,
	  sum(ftab.population) as TotalPopulationInIndia
from (
select 
       tab.State,
	   sum(tab.Males) as Total_males,
	   sum(tab.Females) as Total_females,
	   sum(tab.population) as population,
	   round((sum(tab.Females))/sum(tab.Males),3) as SexRatioByState
from (
select t.District,
       t.State,
	   round(t.population/(1+ t.Sex_Ratio),0) as Males,
	   round((t.population*t.Sex_Ratio)/(1+t.Sex_Ratio),0) as Females,
	   t.Sex_Ratio,
	   t.population
from (
select t1.District,
       t1.State,
       t1.Sex_Ratio/1000 as Sex_Ratio,
	   t2.population
from PortfolioProjectSQL.dbo.Table1   t1
Join PortfolioProjectSQL.dbo.Table2   t2
     on t1.District=t2.District)  t
) tab
group by tab.State ) ftab









--- Compute the total literacy people and the total of illiteracy people in Indian by state

---- literacy = total literacy/ population

select
      d.State,
	  sum(d.LiteracyPeople) as LiteracyPeopleByState,
	  sum(d.IlliteracyPeople) as IlliteracyPeopleByState,
	  sum(d.population) as PopulationByState
from
(select c.District,
       c.State,
       round(c.Literacy_Ratio*c.population,0) as LiteracyPeople,
	   round( (1-c.Literacy_Ratio)*c.population,0) as IlliteracyPeople,
	   c.population
from (
select a.District,
       a.state,
	   a.Literacy/100 as Literacy_Ratio,
	   b.population
from PortfolioProjectSQL.dbo.Table1   a
Join PortfolioProjectSQL.dbo.Table2  b
     on a.District=b.District) c
	 ) d
group by d.state


-- Literacy and Illiteracy people in Indian

select 
      sum(e.LiteracyPeopleByState) as TotalLiteracyPeopleInIndia,
	  sum(e.IlliteracyPeopleByState) as TotalIlliteracyPeopleInIndia,
	  sum(e.PopulationByState) as TotalPopulationInIndia
from
(select
      d.State,
	  sum(d.LiteracyPeople) as LiteracyPeopleByState,
	  sum(d.IlliteracyPeople) as IlliteracyPeopleByState,
	  sum(d.population) as PopulationByState
from
(select c.District,
       c.State,
       round(c.Literacy_Ratio*c.population,0) as LiteracyPeople,
	   round( (1-c.Literacy_Ratio)*c.population,0) as IlliteracyPeople,
	   c.population
from (
select a.District,
       a.state,
	   a.Literacy/100 as Literacy_Ratio,
	   b.population
from PortfolioProjectSQL.dbo.Table1   a
Join PortfolioProjectSQL.dbo.Table2  b
     on a.District=b.District) c
	 ) d
group by d.state) e


/* Compute de population in the previous census 

 We now that population= previous population + Growth * previous population

 */

select d.State,
        sum(d.PreviousPopulation) as PreviousPopulationByState,
		round(sum(d.population)/sum(d.PreviousPopulation)-1,2) as GrowthPercentageByState,
		sum(d.population) as PopulationByState
from
(select 
      c.District,
	  c.State,
	  c.GrowthPercentage,
	  round(c.population/(1+c.GrowthPercentage),0) as PreviousPopulation,
	  c.population
from(
select a.District,
       a.state,
	   a.Growth as GrowthPercentage,
	   b.population
from PortfolioProjectSQL.dbo.Table1   a
Join PortfolioProjectSQL.dbo.Table2  b
     on a.District=b.District) c) d
group by d.state


--- Previous census in Indian


select
      sum(e.PreviousPopulationByState) as PreviousCensusPopulation,
	  avg(e.GrowthPercentageByState) as AverageStateGrowth,
	  round( sum(e.PopulationByState)/sum(e.PreviousPopulationByState)-1,2) as GrowthPercentatge,
	  sum(e.PopulationByState) as CurrentcensusPopulation
from 
(select d.State,
        sum(d.PreviousPopulation) as PreviousPopulationByState,
		round(sum(d.population)/sum(d.PreviousPopulation)-1,2) as GrowthPercentageByState,
		sum(d.population) as PopulationByState
from
(select 
      c.District,
	  c.State,
	  c.GrowthPercentage,
	  round(c.population/(1+c.GrowthPercentage),0) as PreviousPopulation,
	  c.population
from(
select a.District,
       a.state,
	   a.Growth as GrowthPercentage,
	   b.population
from PortfolioProjectSQL.dbo.Table1   a
Join PortfolioProjectSQL.dbo.Table2  b
     on a.District=b.District) c) d
group by d.state) e



/* Population vs area */



-- Indian area

select sum(area_km2) as IndianAreakm2
from PortfolioProjectSQL.dbo.Table2;





select j.IndianAreakm2/j.PreviousCensusPopulation as PreviousCensusPopulationvsArea,
       j.IndianAreakm2/j.CurrentCensusPopulation as CurrentCensusPopulationvsArea
from 
(select h.*,
       i.IndianAreakm2
from 
(select '1' as keyy, 
        f.*
from 
(
select
      sum(e.PreviousPopulationByState) as PreviousCensusPopulation,
	  avg(e.GrowthPercentageByState) as AverageStateGrowth,
	  round( sum(e.PopulationByState)/sum(e.PreviousPopulationByState)-1,2) as GrowthPercentage,
	  sum(e.PopulationByState) as CurrentCensusPopulation
from 
(select d.State,
        sum(d.PreviousPopulation) as PreviousPopulationByState,
		round(sum(d.population)/sum(d.PreviousPopulation)-1,2) as GrowthPercentageByState,
		sum(d.population) as PopulationByState
from
(select 
      c.District,
	  c.State,
	  c.GrowthPercentage,
	  round(c.population/(1+c.GrowthPercentage),0) as PreviousPopulation,
	  c.population
from(
select a.District,
       a.state,
	   a.Growth as GrowthPercentage,
	   b.population
from PortfolioProjectSQL.dbo.Table1   a
Join PortfolioProjectSQL.dbo.Table2  b
     on a.District=b.District) c) d
group by d.state) e
) f
) h
join 
(select '1' as keyy,
        g.*
from 
(
select sum(area_km2)  as IndianAreakm2
from PortfolioProjectSQL.dbo.Table2 
) g
) i
on h.keyy=i.keyy) j;



/* Window functions */

--- Top 3 districts whithin state with highest literacy rate

     -- table

select * 
from PortfolioProjectSQL.dbo.Table1;

     --  Rank window function 

select a.*
from
(select District,
      State,
	  Literacy,
	  rank() over (partition by State  order by Literacy desc) Ranking
from PortfolioProjectSQL.dbo.Table1 ) a
where a.ranking in (1,2,3)

-- In this situation, we got the same result using Dense_rank() and row_number() combined with partition by state

   -- Danse_rank function

select District,
      State,
	  Literacy,
	  Dense_rank() over (partition by State  order by Literacy desc) DenseRanking
from PortfolioProjectSQL.dbo.Table1 

    -- row_number()

select District,
      State,
	  Literacy,
	  row_number() over (partition by State  order by Literacy desc) RowNumber
from PortfolioProjectSQL.dbo.Table1 







select District,
      State,
	  Literacy,
	  Dense_rank() over ( order by Literacy desc) DenseRanking
from PortfolioProjectSQL.dbo.Table1 








