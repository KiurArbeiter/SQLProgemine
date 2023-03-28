-- komm
-- teeb andmbeaasi ehk db
create database TARpe22

-- kustutab db
drop database TARpe22

-- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

---- andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

--- sama Id väärtusega rida ei saa sisestada
select * from Gender

--- teeme uue tabeli
create table Person
(
	Id int not null primary key,
	Name nvarchar(30),
	Email nvarchar(30),
	GenderId int
)

--- vaatame Person tabeli sisu
select * from Person

--- andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 'superman@mail.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'ww@mail.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'bm@mail.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'am@mail.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'cw@mail.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (8, NULL, NULL, 2)

select * from Person

-- võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderID_FK
foreign key (GenderId) references Gender(Id)

--- kui sisestad uue rea andmeid ja ei ole sisestatud GenderId all väärtust, siis
--- see automaatselt sisestab tabelisse väärtuse 3 ja selleks on Unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Person (Id, Name, Email)
values (9, 'Ironman', 'i@i.com')

select * from Person

-- piirangu maha võtmine
alter table Person
drop constraint DF_Persons_GenderId

--- lisame uue veeru
alter table Person
add Age nvarchar(10)

--- lisame vanuse piirangu sisestamisel
--- ei saa lisada suuremat väärtust kui 801
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 801)

-- rea kustutamine
-- kui paned vale id, siis ei muuda midagi
delete from Person where Id = 9

select * from Person

-- kuidas uuendada andmeid tabelis
update Person
set Age = 50
where Id = 1

-- lisame juurde uue veeru
alter table Person
add City nvarchar(50)

-- kõik, kes elavad gothami linnas
select * from Person where City = 'Gotham'
-- kõik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
-- teine variant
select * from Person where not City = 'Gotham'
-- kolmas variant
select * from Person where City <> 'Gotham'

-- naitab teatud vanusega inimes
select * from Person where Age = 800 or Age = 35 or Age = 27
select * from Person where Age in (800, 35, 27)

-- naitab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 20 and 35

-- wildcard ehk naitab koik g-tahega linnad
select * from Person where City like 'g%'
-- naitab koik emailid, milles on @ mark
select * from Person where Email like '%@%'

--- näitab kõiki, kellel ei ole @-märki emailis
select * from Person where Email not like '%@%'

--- naitab kellel on emailis ees ja peale @-märki
select * from Person where Email like '_@_.com'

-- koik, kellel ei ole nimes esimene taht W, A, C
select * from Person where Name like '[^WAC]%'

--- kes elavad Gothamis ja New Yorkis
select * from Person where (City= 'Gotham' or City = 'New York')

-- koik kes elavad Gothamis ja New Yorkis ning
-- alla 30 eluaastat
select * from Person where 
(City= 'Gotham' or City = 'New York')
and Age <= 30

--- kuvab tahestikulises jarjekorras inimesi ja vütab aluseks nime
select * from Person order by Name
-- kuvab ´vastupidises jarjekorras inimesi ja vütb aluseks nime
select * from Person order by Name desc

-- votab kolm esimest rida
select TOP 3 * from Person


--- 2 tund jahjah
--- muudab age muutuja int-iks ja naitab vanulises jarjekorras
select * from Person order by CAST(Age as int)

--- koikide isikute koondvanus
select SUM(CAST(Age as int)) from Person

--- naitab koige nooremat isikut
select MIN(CAST(Age as int)) from Person

--- naitab koige vaneamt isikut
select MAX(CAST(Age as int)) from Person


--- näeme konkreetses linnades olevate isikute koondvanust
--- enne oli age string, aga päringu ajhal muutsime sele int-ks
select City, SUM(cast(Age as int)) as TotalAge from Person group by City

--- kuidas saab koodiga muuta tabeli andmetüüpi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

alter table Person
alter column Age int

--- kuvab esimeses reas välja toodud järjestuses ja muudab Age-i TotalAge-ks
--- teeb järjestuse vaatesse: City, GenderId ja järjestab omakorda City veeru järgi
select City, GenderId, SUM(Age) as TotalAge from Person
group by City, GenderId order by City

--- naitab, et mitu rida on selles tabelis
select COUNT(*) from Person

--- veergude lugemine
SELECT COUNT(*)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Person'

--- naitab tulemust, et mitu inimest on genderid 
--- väärtusega 2 konkreetses linnas
--- arvutab kokku vanuse
select GenderId, City, SUM(Age) as TotalAge, COUNT(Id) as  [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--- naitab, et mitu inimest on vanemad kui 41 ja kui palju igas linnas 
select GenderId, City, SUM(Age) as TotalAge, COUNT(Id) as  [Total Person(s)]
from Person
group by GenderId, City having SUM(Age) > 41

--- loome uued tabelid
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Department (Id, DepartmentName, Location, DepartmentHead) values
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

insert into Employees (Id, Name, Gender, Salary, DepartmentId) values
(1, 'Tom', 'Male', '4000', 1),
(2, 'Pam', 'Female', '3000', 3),
(3, 'John', 'Male', '3500', 1),
(4, 'Sam', 'Male', '4500', 2),
(5, 'Todd', 'Male', '2800', 2),
(6, 'Ben', 'Male', '7000', 1),
(7, 'Sara', 'Female', '4800', 3),
(8, 'Valarie', 'Female', '5500', 1),
(9, 'James', 'Male', '6500', NULL),
(10, 'Russell', 'Male', '8800', NULL)

select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--- lisame veeru nimega City
alter table Employees
add City nvarchar(50)

select * from Employees

--- arvutame ühe kuu palgafondi kokku
select SUM(cast(Salary as int)) from Employees
--- min palga saaja ja kuitahame max palga saajat, siis kasutame MIN asemele MAX panna
select MIN(cast(Salary as int)) from Employees
--- ühe kuu palgafond linnade lõikes
select City, SUM(cast(Salary as int)) as TotalSalary from Employees 
group by City

--- linnad on tahestikulises jarjestuses
select City, SUM(cast(Salary as int)) as TotalSalary from Employees 
group by City, Gender
order by City

--- loeb ara mitu inimest on nimekirjas
select COUNT(*) from Employees

--- vaatame mitu tootajat on soo ja linna kaupa
select Gender, City, SUM(cast(Salary as int)) as TotalSalary,
COUNT(Id) as [Total Employee(s)]
from Employees
group by Gender, City

--- näidata kõiki mehi linnade kaupa
select Gender, City, SUM(cast(Salary as int)) as TotalSalary,
COUNT(Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

--- näidata kõiki naisi linnade kaupa
select Gender, City, SUM(cast(Salary as int)) as TotalSalary,
COUNT(Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'


--- vigane päring
select * from Employees where SUM(CAST(Salary as int)) > 4000

--- töötav variant
select Gender, City, SUM(CAST(Salary as int)) as [Total Salary],
COUNT(Id) as [Total Employee(s)]
from Employees group by Gender, City
having SUM(CAST(Salary as int)) > 4000

--- loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)

insert into Test1 values('X')

select * from Test1

--- inner join
--- kuvab neid, kellel on DepartmentName all olemas vaartus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--- left join
--- kuidas saada koik andmed Employees-st katte
select Name, Gender, Salary, DepartmentName
from Employees
left join Department --- voib kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

--- naitab koik tootajad Employee tabelist ja Department tabelist
--- osakonnad, kuhu ei ole kedagi maaratud
select Name, Gender, Salary, DepartmentName
from Employees
right join Department --- voib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

--- kuidas saada koikide tabelite vaartused uhte paringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

---votab kaks allpool olevat tabelit kokku ja korrutab need omavahel labi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--- kuidas kuvada need isikud, kellel on Department NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--- teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

--- kuidas saame department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--- full join
--- molema tabeli mitte-kattuvad vaartustega read kuvab valja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

select * from dbo.DimEmployee
--- tahan teada saada, mis tahendab SalesTerritoryKey DimEmployee tabelis
--- inner join-i kasutada
select FirstName, LastName, Phone, SalesTerritoryCountry, SalesTerritoryGroup, SalesTerritoryRegion
from dbo.DimEmployee
inner join dbo.DimSalesTerritory
on dbo.DimEmployee.SalesTerritoryKey = dbo.DimEmployee.SalesTerritoryKey

--- tabeli muutmine koodiga, alguses vana tabeli nimi ja siis soovitud nimi
sp_rename 'Department', 'department123'

select E.Name as Employees, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id


---alter table Employees
---add Veerunimi int

--- inner join
--- näitab ainult managerId all olevate isikute väärtuseid
select E.Name as Employees, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--- kõik saavad kõikide ülemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

select ISNULL('Asdasdasd', 'No Manager') as Manager

--- NULL asemel kuvad no manager
select coalesce(NULL, 'No Manager') as Manager

--- neil kellel ei ole ülemus, siis paneb neile no Manager teksti
select E.Name as Employee, ISNUll(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id


--- lisame tabelisse uued veerudõ
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)


select * from Employees
--- uuendame koodia väärtuseid
update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3
update Employees
set FirstName = 'SAM', MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from employees

--- igast reast võtab esimeses täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

--- loome 2 tabelit
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

--- sisestame tabelisse andmeid
insert into IndianCustomers(Name, Email) values
('Raj', 'R@R.com'),
('Sam','S@S.com')

insert into UKCustomers(Name, Email) values
('Ben', 'B@B.com'),
('Sam','S@S.com')

select * from IndianCustomers
select * from UKCustomers

--- kasutame union all, mis näitab kõiki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers


--- korduvate väärutstega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers


--- kuidas sorteerida tulemust nime järgi
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers
order by Name

--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from employees
end


--- nüüd saab kasutada selle nimelist stored procedurit
spGetEmployees
exec spGetEmployees
execute spGetEmployees

create proc spGetEmployeesByGenderAndDepartment
--- muutujad defineeritakse @ märgiga
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees
	where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--- kindlasti tuleb sellele panna parameeter lõppu muidu annab errori
--- kindlasti peab jalgima jarjekorda mis on pandud sp-le
---parameetrite osas
spGetEmployeesByGenderAndDepartment 'Male', 1



spGetEmployeesByGenderAndDepartment
@DepartmentId = 1, @Gender = 'Male'

--- saab vaadata sp sisu
sp_helptext spGetEmployeesByGenderAndDepartment


select PersonType, NameStyle, FirstName, MiddleName, LastName
from Person.Person
cross join Person.PersonPhone

select SalesQuota, Bonus, Name 
from Sales.SalesPerson
RIGHT JOIN Sales.SalesTerritory
on Sales.SalesPerson.TerritoryID = Sales.SalesTerritory.TerritoryID
