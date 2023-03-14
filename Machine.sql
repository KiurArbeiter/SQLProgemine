--- loome andmebaasi nimega Machine
create database Machine

--- loome tabeli nimega Car
create table Car
(
Id int not null primary key,
Color nvarchar(30) not null,
EnginePower nvarchar(30) not null,
CarTypeId int
)

--- loome tabeli nimega CarType
create table CarType
(
Id int not null primary key,
CarType nvarchar(20) not null,
)

--- andmete sisestamine CarType tabelisse
insert into CarType(Id, CarType)
values (1, 'Sedan')
insert into CarType(Id, CarType)
values (2, 'Coupe')
insert into CarType(Id, CarType)
values (3, 'Hatchback')
insert into CarType(Id, CarType)
values (4, 'Station Wagon')
insert into CarType(Id, CarType)
values (5, 'Sport')

--- andmete sisestamine Car tabelisse
insert into Car(Id, Color, EnginePower, CarTypeId)
values (1, 'Black', '150 hp; 112 kW', 1)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (2, 'White', '261 hp; 194 kW', 2)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (3, 'Grey', '261 hp; 194 kW', 4)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (4, 'Brown', '182 hp; 136 kW', 4)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (5, 'Red', '241 hp; 179 kW', 3)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (6, 'White', '517 hp; 386 kW', 5)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (7, 'White', '217 hp; 162 kW', 1)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (8, 'Red', '212 hp; 158 kW', 3)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (9, 'Blue', '471 hp; 351 kW', 5)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (10, 'Yellow', '168 hp; 125 kW', 1)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (11, 'Black', '289 hp; 215 kW', 2)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (12, 'Grey', '258 hp; 192 kW', 3)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (13, 'Orange', '555 hp; 414 kW', 5)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (14, 'Red', '281 hp; 209 kW', 2)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (15, 'Black', '196 hp; 146 kW', 4)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (16, 'Black', '276 hp; 205 kW', 2)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (17, 'White', '458 hp; 341 kW', 5)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (18, 'Brown', '187 hp; 139 kW', 1)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (19, 'Brown', '201 hp; 149 kW', 4)
insert into Car(Id, Color, EnginePower, CarTypeId)
values (20, 'Yellow', '251 hp; 187 kW', 2)