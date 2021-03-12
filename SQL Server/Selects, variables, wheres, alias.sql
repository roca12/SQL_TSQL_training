-- seleccionando la base de datos a usar y 
-- cargar los 10 primeros campos ordenados por CompanyName 
use Northwind
go
select top 10 * from Customers
order by CompanyName;

--seleccionando datos usando la sintaxis completamente calificada
select top 10 * from Northwind.dbo.Customers
order by CompanyName;

-- seleccionando datos de otra tabla usando la sintaxis anterior
select top 10 * from pubs.dbo.authors
order by city;

-- seleccionando datos de una tabla en la cual una columna 
select top 10 [Date] from dbo.MyLogTable
order by [Date] desc;

-- prefijos n para selects
select top 10 * from Northwind.dbo.Customers
where CompanyName like N'AL%'
order by CompanyName;

-- joins 
select top 10 Territories.*, Region.RegionDescription
from Territories
inner join Region 
on  Territories.RegionID=Region.RegionID
order by TerritoryDescription;

--join usando alias
select top 10 T.*, R.RegionDescription
from Territories T
inner join Region  R
on  T.RegionID=R.RegionID
order by TerritoryDescription;

-- union de tablas no relacionadas
select FirstName+' '+LastName as ContactName, Address, City from Employees
union
select ContactName, Address, City from Customers;

-- variables  para almacenamiento temporal, se debe llamar antes de los dos siguientes bloques
declare @Region table(
	RegionID INT,
	RegionDesciption Nchar(50)
);

-- poblando la tabla variable desde una tabla existente
insert into @Region
select * from dbo.Region where RegionID=2;

-- Seleccionando datos usando un join de la tabla real y la tabla variable
select * from Territories t
join @Region r on t.RegionID=r.RegionID;

-- borrando todos los registros de una tabla
delete from Northwind.dbo.Customers;
truncate table Northwind.dbo.Customers;

-- imprimiendo lineas por consola
print 'Impresion por consola';

-- selects con condiciones complejas
select FirstName, Age
from Users
where LastName='Smith' and (City ='New York' or City ='Los Angeles');

-- actualizar todas las columnas
update Scores
set score=score+1;

--retornando version
select @@VERSION;

--retornando nombre de la instancia
select @@SERVERNAME

--retornando nombre del servicio
select @@SERVICENAME

--retornando nombre de la maquina fisica
select SERVERPROPERTY('ComputerNamePhysicalNetBIOS');

--retornando nombres de los nodos de un cluster si es un cluster, vacio si no lo es
select * from fn_virtualservernodes();

-- de una tabla antigua a una nueva
select * INTO new from old;

-- usando transacciones para insertar datos seguramente
if not exists (select * from sysobjects where name='test' and xtype='U')
    create database test;
go
use test;
go

create table test_transaction (column_1 varchar(10));
go

insert into test.dbo.test_transaction(column_1) 
values ('a');

begin transaction 
update test.dbo.test_transaction
set column_1 ='b'
output INSERTED.*
where column_1='a';

rollback transaction

select * from test.dbo.test_transaction;
drop table test.dbo.test_transaction;


-- convirtiendo datos con tryparse
declare @fakedate as varchar(10);
declare @realdate as varchar(10);
set @fakedate ='nosoyunafecha';
set @realdate ='13/04/2022';
select try_parse(@fakedate as date)
select try_parse(@realdate as date)
select try_parse(@realdate as date using 'Es-CO');


-- convirtiendo datos con tryconvert
declare @fakedate as varchar(10);
declare @realdate as varchar(10);
set @fakedate ='123344';
set @realdate ='13/04/2022';
select try_convert(int, @fakedate);
select try_convert(datetime, @fakedate);
select try_convert(datetime, @realdate,111);

-- convirtiendo datos con trycast
declare @sampletext as varchar(10);
set @sampletext = '12345';
select try_cast(@sampletext as int);
select try_cast(@sampletext as date);


--cast
declare @a varchar(2);
declare @b varchar(2);
set @a='25a';
set @b='15';
select cast(@a as int) + cast(@b as int) as Resultado
declare @c varchar(2)='a'
select cast(@c as int) as Resultado

--convert
select convert(varchar(20),getdate(),108);

--select basico
select * from sys.objects;

--filtrando selects con where
select * from sys.objects
where type='IT';

--ordenando por alguna columna
select * from sys.objects
where type='IT' order by create_date;

--agrupando por resultados
select type, count(*) as c
from sys.objects
group by type;

--agrupando y removiendo por condiciones con having
select type, count(*) as c
from sys.objects
group by type
having count(*)<10;

--seleccionando las primeras 10 lineas saltando algunas
select *
from sys.objects
order by object_id
offset 50 rows fetch next 10 rows only;

-- saltar las primeras 50 lineas
select *
from sys.objects
order by object_id
offset 50 rows;

-- seleccionando sin from 
declare @var int =17;
select @var as c, @var +2 as b, @var as a;


-- seleccionando de un grupo el primero no nulo
select coalesce(null,null,3);

-- select con cases
declare @date date='2020/5/5';
select case when @date = null then 1
	when @date <> null then 2
	when @date < null then 3
	when @date > null then 4
	when @date is null then 5
	when @date is not null then 6 
	else 7
	end;

-- tabla variable
declare @Employee table(
	EmployeeID int not null primary key,
	FirstName nvarchar(50) not null,
	LastName nvarchar(50) not null,
	ManagerID int null
);

--seleccionando de tablas variables debe ser con alias
declare @table1 table (example int);
declare @table2 table (example int);
select *
from @table1 t1
inner join @table2 t2 on t1.example =t2.example;
