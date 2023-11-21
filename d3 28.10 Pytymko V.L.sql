use Academy
go

alter table GroupsLectures
add  DayOfWeek int  not null default 1 check (DayOfWeek>=1 and DayOfWeek<=7);
go

select *from GroupsLectures
go

update GroupsLectures
set DayOfWeek=4
where Id = 1;
go

select *from Departments
go

update Departments
set Name = 'Software Development'
where id=3;
go

--1. Вивести кількість викладачів кафедри «Software Development».
SELECT COUNT (distinct t.id) AS Кількість_викладачів
from Groups g
join Departments d on g.DepartmentId=d.Id
join GroupsLectures gl on g.Id=gl.GroupId
join Lectures l on gl.LectureId=l.Id
join Teachers t on l.TeacherId=t.Id
where d.Name= 'Software Development';
go
	
--2. Вивести кількість лекцій, які читає викладач “Dave McQueen”.

select count(*) as кількість_лекцій_Dave_McQueen
from Lectures l
join Teachers t on l.TeacherId=t.Id
where t.Name= 'Dave' and t.Surname='McQueen'

--3. Вивести кількість занять, які проводяться в аудиторії “D201”.

select count(*) as кількість_лекцій_в_аудиторії_D201
from Lectures l
join Subjects s on l.SubjectId=s.Id
where l.LectureRoom= 'D201' 

--4. Вивести назви аудиторій та кількість лекцій, що проводяться в них.

select l.LectureRoom as аудиторія,
count(*) as лекція
from Lectures l
group by l.LectureRoom;

--5. Вивести кількість студентів, які відвідують лекції викладача “Jack Underhill”.
--(в данній версії бд Академія немає інформаціі про студентів,
--тому буде виведено назву груп для яких читає лекції викладач Jack Underhill )

select g.Name as GroupName_для_якої_читає_лекції_викладач_Jack_Underhill
from Groups g
join GroupsLectures gl  on g.Id=gl.GroupId
join Lectures l on gl.LectureId=l.Id
join Teachers t on l.TeacherId=t.Id
where t.Name = 'Jack' and t.Surname='Underhill'


--6. Вивести середню ставку викладачів факультету Computer Science.

select avg(t.Salary) as середня_ставка_викладачів_факультету_Computer_Science
from Faculties f
join Departments d on f.Id=d.FacultyId
join Groups g on d.Id=g.DepartmentId
join GroupsLectures gl on g.id=gl.GroupId
join Lectures l on gl.LectureId=l.id
join Teachers t on l.TeacherId=t.id
where f.Name='Computer Science';

--7. Вивести мінімальну та максимальну кількість студентів серед усіх груп.
--- в цій версії бд Acadamy вітсутня інформація про студентів.

--8. Вивести середній фонд фінансування кафедр.
select avg (d.Financing) as середній_фонд_фінансування_кафедр
from Departments d 


--9. Вивести повні імена викладачів та кількість читаних ними дисциплін.

select t.Name +' '+ t.Surname  as повні_імена_викладачів,
count(l.Id) as кількість_дисциплін
from Teachers t
join Lectures l on l.Id	=l.TeacherId
group by t.Id, t.name, t.Surname  ;

--10. Вивести кількість лекцій щодня протягом тижня.
select  DayOfWeek, COUNT (*) as кількість_лекцій
from GroupsLectures gl
join Lectures l on gl.LectureId=l.Id
group by DayOfWeek;

--11. Вивести номери аудиторій та кількість кафедр, чиї лекції в них читаються.

select l.LectureRoom AS номери_аудиторій,
count(distinct d.Id) as кількість_кафедр
from Lectures l
join GroupsLectures gl on l.Id=gl.LectureId
join Groups g on gl.GroupId=g.Id
join Departments d on g.DepartmentId=d.Id
group by l.LectureRoom;

--12. Вивести назви факультетів та кількість дисциплін, які на них читаються.
select f.Name as  назвa_факультетів, 
count(distinct s.id) as кількість_дисциплін
from Faculties f
join Departments d on f.Id=d.FacultyId
join Groups g on d.id= g.DepartmentId
join GroupsLectures gl on g.Id=gl.GroupId
join Lectures l on gl.LectureId=l.Id
join Subjects s on l.SubjectId=s.Id
group by f.Name;

--13. Вивести кількість лекцій для кожної пари викладач-аудиторія.
select t.Name + ' ' + t.Surname as викладач,
l.LectureRoom as аудиторія,
count(*) as кількість_лекцій
from Lectures l
join Teachers t on l.TeacherId = t.Id
join GroupsLectures gl on l.Id = gl.LectureId
group by  t.Id, t.Name, t.Surname, l.LectureRoom;
