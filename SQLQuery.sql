
--a)------------------------------------------
select name, count(title) as Number
from ActedIn
group by name
ORDER by Number DESC

--B)--------------------------------------------------------
select name, count(title) as Number
from ActedIn
group by name
having count(title)>=2
ORDER by Number DESC


--c)--------------------------------------------------------------------------------
select *
into #tb
from (select name, COUNT(title) as Number
from ActedIn
group by name )as tt
select name, Number 
from #tb  
where Number = (select max(Number)from #tb)
DROP TABLE #tb

--d)---------------------------------------------------------------------------
select distinct M.title
from Movie M, Keywords K
where M.title =K.title and genre = 'action' and K.keyword like '%war%'
 and not exists( select K.keyword from Keywords K where K.keyword like '%star%' and K.title = M.title)



--e)--------------------------------------------------------------------------------
select DISTINCT S.songID, S.rank
FROM Soundtrack S, Keywords K
where K.title =S.title and (K.keyword ='computer' or K.keyword ='computer-animation')
order by S.rank 

--f)-----------------------------------------------------------------------------------
select *
from TechStaff T, Actors A
where T.fname = A.fname and T.lname = A.lname

--g)-------------------------------------------------------------------------------------
select S.studioName, avg(A.salary)as avg_salary, avg(T.salary) as avg_income
from Studio S, Actors A, TechStaff T, ActedIn AI, Movie M
where T.studioID =S.studioID 
AND T.studioID=M.studioID 
AND  S.studioID = M.studioID 
AND A.name=AI.name
AND AI.title=M.title 
group by S.studioName