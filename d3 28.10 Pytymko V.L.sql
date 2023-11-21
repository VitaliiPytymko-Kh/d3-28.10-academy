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

--1. ������� ������� ���������� ������� �Software Development�.
SELECT COUNT (distinct t.id) AS ʳ������_����������
from Groups g
join Departments d on g.DepartmentId=d.Id
join GroupsLectures gl on g.Id=gl.GroupId
join Lectures l on gl.LectureId=l.Id
join Teachers t on l.TeacherId=t.Id
where d.Name= 'Software Development';
go
	
--2. ������� ������� ������, �� ���� �������� �Dave McQueen�.

select count(*) as �������_������_Dave_McQueen
from Lectures l
join Teachers t on l.TeacherId=t.Id
where t.Name= 'Dave' and t.Surname='McQueen'

--3. ������� ������� ������, �� ����������� � ������� �D201�.

select count(*) as �������_������_�_�������_D201
from Lectures l
join Subjects s on l.SubjectId=s.Id
where l.LectureRoom= 'D201' 

--4. ������� ����� �������� �� ������� ������, �� ����������� � ���.

select l.LectureRoom as ��������,
count(*) as ������
from Lectures l
group by l.LectureRoom;

--5. ������� ������� ��������, �� �������� ������ ��������� �Jack Underhill�.
--(� ����� ���� �� ������� ���� ���������� ��� ��������,
--���� ���� �������� ����� ���� ��� ���� ���� ������ �������� Jack Underhill )

select g.Name as GroupName_���_���_����_������_��������_Jack_Underhill
from Groups g
join GroupsLectures gl  on g.Id=gl.GroupId
join Lectures l on gl.LectureId=l.Id
join Teachers t on l.TeacherId=t.Id
where t.Name = 'Jack' and t.Surname='Underhill'


--6. ������� ������� ������ ���������� ���������� Computer Science.

select avg(t.Salary) as �������_������_����������_����������_Computer_Science
from Faculties f
join Departments d on f.Id=d.FacultyId
join Groups g on d.Id=g.DepartmentId
join GroupsLectures gl on g.id=gl.GroupId
join Lectures l on gl.LectureId=l.id
join Teachers t on l.TeacherId=t.id
where f.Name='Computer Science';

--7. ������� �������� �� ����������� ������� �������� ����� ��� ����.
--- � ��� ���� �� Acadamy ������� ���������� ��� ��������.

--8. ������� ������� ���� ������������ ������.
select avg (d.Financing) as �������_����_������������_������
from Departments d 


--9. ������� ���� ����� ���������� �� ������� ������� ���� ��������.

select t.Name +' '+ t.Surname  as ����_�����_����������,
count(l.Id) as �������_��������
from Teachers t
join Lectures l on l.Id	=l.TeacherId
group by t.Id, t.name, t.Surname  ;

--10. ������� ������� ������ ����� �������� �����.
select  DayOfWeek, COUNT (*) as �������_������
from GroupsLectures gl
join Lectures l on gl.LectureId=l.Id
group by DayOfWeek;

--11. ������� ������ �������� �� ������� ������, �� ������ � ��� ���������.

select l.LectureRoom AS ������_��������,
count(distinct d.Id) as �������_������
from Lectures l
join GroupsLectures gl on l.Id=gl.LectureId
join Groups g on gl.GroupId=g.Id
join Departments d on g.DepartmentId=d.Id
group by l.LectureRoom;

--12. ������� ����� ���������� �� ������� ��������, �� �� ��� ���������.
select f.Name as  ����a_����������, 
count(distinct s.id) as �������_��������
from Faculties f
join Departments d on f.Id=d.FacultyId
join Groups g on d.id= g.DepartmentId
join GroupsLectures gl on g.Id=gl.GroupId
join Lectures l on gl.LectureId=l.Id
join Subjects s on l.SubjectId=s.Id
group by f.Name;

--13. ������� ������� ������ ��� ����� ���� ��������-��������.
select t.Name + ' ' + t.Surname as ��������,
l.LectureRoom as ��������,
count(*) as �������_������
from Lectures l
join Teachers t on l.TeacherId = t.Id
join GroupsLectures gl on l.Id = gl.LectureId
group by  t.Id, t.Name, t.Surname, l.LectureRoom;
