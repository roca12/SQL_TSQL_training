--creando tabla
create table HelloWorld (
	Id int identity,
	Descripcion varchar(1000)
);

-- insertando valores en una tabla
insert into HelloWorld (Descripcion) values ('hola mundo');

-- seleccionando todo de una tabla
select * from HelloWorld;

-- seleccionando una columna especifica de una tabla
select Descripcion from HelloWorld;

-- contando la cantidad de registros en una tabla
select Count(*) from HelloWorld;

-- actualizando un registro especifico de una tabla 
update HelloWorld set Descripcion='Buenas tardes' where Id=1;






