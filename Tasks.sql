
-- a)------------------------------------------------------------------------

alter table TechStaff
add constraint age_constraint check (age >10 and age <125);

alter table Soundtrack
add constraint song_constraint check ([duration(sec)] > 0);


-- b)---------------------------------------------------------
alter table Actors
add fname char(255)

alter table Actors
add lname char(255)

update Actors
set lname = left(name, charindex(',',name)-1)
where charindex(',',name)>1

update Actors
set fname =right (name, 255-charindex(',',name)-1)
where charindex(',',name) >=1

update Actors
set fname =right (name, 255-charindex(',',name))
where charindex(',',name)=0


--c)----------------------------------------------------------------

update Studio
set employees = tp_table.tp_emp from(
select studioID, count(sin) as tp_emp
from TechStaff
group by studioID)as tp_table
where studio.studioID = tp_table.studioID

--d)----------------------------------------------------------




create trigger tr_employee
on TechStaff 
after insert,delete
as
begin
	update Studio 
	set employees = tp_table.tp_emp from(
	select studioID, count(sin) as tp_emp
	from TechStaff
	group by studioID)as tp_table
	where studio.studioID = tp_table.studioID
end

--e)-------------------------------------------------------------------------------------------
create trigger td_studio
on Studio
after delete
as
begin
if not exists (select * FROM INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'FoldedStudios')
	begin
	create table FoldedStudios
	(
		studioName varchar(50),
		fired integer
		)
	end
	declare @tc varchar(50)
	declare @td integer
	select @tc= studioName from deleted
	select @td = employees from deleted
	insert into FoldedStudios(studioName,fired)
	values (@tc, @td)
end

--select * from Studio
--insert into Studio values(10, 'Mark', 12,34546753,1243)
--delete from Studio where studioID = 10

--select * from TechStaff
--select * from FoldedStudios
--drop table FoldedStudios
--drop trigger td_studio

--f)-----------------------------------------------------------------------------------------
create proc spSearchString
@st varchar(20)
as
begin
	select title from Keywords 
	where keyword like @st+'% '
end

--drop proc spSearchString
--declare @O varchar(20)
--execute spSearchString, @O output
--print @O

--declare @st ='ha'
 







