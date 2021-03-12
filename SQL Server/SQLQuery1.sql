-- codigos de formateo de fechas con CONVERT
select GETDATE() as[Resultado]
union select convert(varchar(30),getdate(),100) as [Resultado]
union select convert(varchar(30),getdate(),101) as [Resultado]
union select convert(varchar(30),getdate(),102) as [Resultado]
union select convert(varchar(30),getdate(),103) as [Resultado]
union select convert(varchar(30),getdate(),104) as [Resultado]
union select convert(varchar(30),getdate(),105) as [Resultado]
union select convert(varchar(30),getdate(),106) as [Resultado]
union select convert(varchar(30),getdate(),107) as [Resultado]
union select convert(varchar(30),getdate(),108) as [Resultado]
union select convert(varchar(30),getdate(),109) as [Resultado]
union select convert(varchar(30),getdate(),110) as [Resultado]
union select convert(varchar(30),getdate(),111) as [Resultado]
union select convert(varchar(30),getdate(),112) as [Resultado]
union select convert(varchar(30),getdate(),113) as [Resultado]
union select convert(varchar(30),getdate(),114) as [Resultado]
union select convert(varchar(30),getdate(),120) as [Resultado]
union select convert(varchar(30),getdate(),121) as [Resultado]
union select convert(varchar(30),getdate(),126) as [Resultado]
union select convert(varchar(30),getdate(),127) as [Resultado]
union select convert(varchar(30),getdate(),130) as [Resultado]
union select convert(varchar(30),getdate(),131) as [Resultado];

--formateo de fechas usando format
declare @Date datetime ='2020-09-05 00:01:02:333'
select FORMAT(@Date, N'dddd, MMMM dd, yyyy hh:mm:ss tt');

--funcion que calcula la edad de una persona con fechas especificas
go
create function [dbo].[Calc_edad](@DOB datetime, @calcDate datetime) 
returns int as
	begin
	declare @age int
	if (@calcDate<@DOB)
	return -1
	select @age=year(@calcDate) - year(@DOB)+
	case when DATEADD(year, YEAR(@calcDate)-year(@DOB),@DOB)>@calcDate THEN -1 ELSE 0 END
	RETURN @age
	end
go
select dbo.Calc_edad('1997-09-19',GETDATE());

--rangos de datos recursivo
declare @from date='2021-01-01',
		@to date='2021-02-01';
with DateCte (date) as(
	select @from union all 
	select DATEADD(day,1,date)
	from DateCte
	where date<@to
)
select date from DateCte option (MaxRecursion 0);

--trycatch con levantamiento de errores
declare @msg nvarchar(50)='Aqui hay un problema';
begin try
print'primera sentencia';
raiserror(@msg,11,1);
print'segunda sentencia';
end try
begin catch
	print 'ERROR: '+error_message();
end catch

--trycatch con levantamiento de errores y severidad
begin try
print'primera sentencia';
raiserror('Aqui esta el problema',10,15);
print'segunda sentencia';
end try
begin catch
	print 'ERROR: '+error_message();
end catch

--Relanzando errores en catch
