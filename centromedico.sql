USE [master]
GO
/****** Object:  Database [CentroMedico]    Script Date: 5/24/2025 11:52:42 AM ******/
CREATE DATABASE [CentroMedico]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CentroMedico', FILENAME = N'C:\SQLData\CentroMedico\CentroMedico.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CentroMedico_log', FILENAME = N'C:\SQLData\CentroMedico\CentroMedico_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CentroMedico] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CentroMedico].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CentroMedico] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CentroMedico] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CentroMedico] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CentroMedico] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CentroMedico] SET ARITHABORT OFF 
GO
ALTER DATABASE [CentroMedico] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CentroMedico] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CentroMedico] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CentroMedico] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CentroMedico] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CentroMedico] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CentroMedico] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CentroMedico] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CentroMedico] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CentroMedico] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CentroMedico] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CentroMedico] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CentroMedico] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CentroMedico] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CentroMedico] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CentroMedico] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CentroMedico] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CentroMedico] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CentroMedico] SET  MULTI_USER 
GO
ALTER DATABASE [CentroMedico] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CentroMedico] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CentroMedico] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CentroMedico] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CentroMedico] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CentroMedico] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CentroMedico] SET QUERY_STORE = ON
GO
ALTER DATABASE [CentroMedico] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CentroMedico]
GO
/****** Object:  User [imtommy]    Script Date: 5/24/2025 11:52:43 AM ******/
CREATE USER [imtommy] FOR LOGIN [imtommy] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [imtommy]
GO
/****** Object:  UserDefinedDataType [dbo].[historia]    Script Date: 5/24/2025 11:52:43 AM ******/
CREATE TYPE [dbo].[historia] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[medico]    Script Date: 5/24/2025 11:52:43 AM ******/
CREATE TYPE [dbo].[medico] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[observacion]    Script Date: 5/24/2025 11:52:43 AM ******/
CREATE TYPE [dbo].[observacion] FROM [varchar](1000) NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[paciente]    Script Date: 5/24/2025 11:52:43 AM ******/
CREATE TYPE [dbo].[paciente] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[pais]    Script Date: 5/24/2025 11:52:43 AM ******/
CREATE TYPE [dbo].[pais] FROM [char](3) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[turno]    Script Date: 5/24/2025 11:52:43 AM ******/
CREATE TYPE [dbo].[turno] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedFunction [dbo].[concatenar]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[concatenar] (
				@apellido varchar(50),
				@nombre varchar(50)
				)
RETURNS varchar(100)

AS
BEGIN
	declare @resultado varchar(100)
	set @resultado = @apellido + ', ' + @nombre
	return @resultado	

END
GO
/****** Object:  UserDefinedFunction [dbo].[FCN_FechaTexto]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[FCN_FechaTexto] (@fecha datetime)

RETURNS VARCHAR(60)

AS
BEGIN

declare @dia varchar(20)
declare @mes varchar(20)
declare @fechatexto varchar(50)

set @dia = (CASE WHEN datepart(dw,@fecha) = 1 THEN 'Domingo ' + convert(char(2),datepart(dd,@fecha))
				WHEN datepart(dw,@fecha) = 2 THEN 'Lunes ' + convert(char(2),datepart(dd,@fecha))	
				WHEN datepart(dw,@fecha) = 3 THEN 'Martes ' + convert(char(2),datepart(dd,@fecha))	
				WHEN datepart(dw,@fecha) = 4 THEN 'Miércoles ' + convert(char(2),datepart(dd,@fecha))	
				WHEN datepart(dw,@fecha) = 5 THEN 'Jueves ' + convert(char(2),datepart(dd,@fecha))	
				WHEN datepart(dw,@fecha) = 6 THEN 'Viernes ' + convert(char(2),datepart(dd,@fecha))	
				WHEN datepart(dw,@fecha) = 7 THEN 'Sábado ' + convert(char(2),datepart(dd,@fecha))	
			END)


set @mes = (CASE WHEN datepart(mm,@fecha) = 1 THEN 'Enero'
				WHEN datepart(mm,@fecha) = 2 THEN 'Febrero'
				WHEN datepart(mm,@fecha) = 3 THEN 'Marzo'
				WHEN datepart(mm,@fecha) = 4 THEN 'Abril'
				WHEN datepart(mm,@fecha) = 5 THEN 'Mayo'
				WHEN datepart(mm,@fecha) = 6 THEN 'Junio'
				WHEN datepart(mm,@fecha) = 7 THEN 'Julio'
				WHEN datepart(mm,@fecha) = 8 THEN 'Agosto'
				WHEN datepart(mm,@fecha) = 9 THEN 'Septiembre'
				WHEN datepart(mm,@fecha) = 10 THEN 'Octubre'
				WHEN datepart(mm,@fecha) = 11 THEN 'Noviembre'
				WHEN datepart(mm,@fecha) = 12 THEN 'Diciembre'
			END)

set @fechatexto = @dia + ' de ' + @mes
RETURN @fechatexto

END
GO
/****** Object:  UserDefinedFunction [dbo].[listaPaises]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[listaPaises]()
RETURNS @paises TABLE(idpais char(3), pais varchar(50))
AS
BEGIN
	
	INSERT INTO @paises values('ESP','España')
	INSERT INTO @paises values('MEX','Mexico')
	INSERT INTO @paises values('CHI','Chile')
	INSERT INTO @paises values('PER','Perú')
	INSERT INTO @paises values('ARG','Argentina')

	RETURN

END
GO
/****** Object:  UserDefinedFunction [dbo].[nombrefun]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[nombrefun] (@var int)
RETURNS int

AS

BEGIN
	set @var = @var * 5
	return @var
END
GO
/****** Object:  UserDefinedFunction [dbo].[nombrefunc]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[nombrefunc] (@var int)
returns int
as 
	begin
set @var = @var * 5
return @var
end
GO
/****** Object:  UserDefinedFunction [dbo].[obtenerPais]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[obtenerPais](
				@idpaciente paciente
				)
RETURNS varchar(50)

AS
BEGIN
	declare @pais varchar(50)
	SET @pais = (SELECT PA.pais From paciente P
					INNER JOIN Pais PA
					ON PA.idPais = P.idPais
					WHERE idPaciente=@idpaciente)
	
	RETURN @pais
END
GO
/****** Object:  Table [dbo].[Turno]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Turno](
	[idTurno] [dbo].[turno] IDENTITY(1,1) NOT NULL,
	[fechaTurno] [datetime] NULL,
	[estado] [smallint] NULL,
	[observacion] [dbo].[observacion] NULL,
 CONSTRAINT [PK_Turno] PRIMARY KEY CLUSTERED 
(
	[idTurno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paciente]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paciente](
	[idPaciente] [dbo].[paciente] IDENTITY(1,1) NOT NULL,
	[dni] [varchar](20) NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
	[fNacimineto] [date] NULL,
	[domicilio] [varchar](50) NULL,
	[idPais] [char](3) NULL,
	[telefono] [varchar](20) NULL,
	[email] [varchar](30) NULL,
	[observacion] [varchar](1000) NULL,
 CONSTRAINT [PK_Paciente] PRIMARY KEY CLUSTERED 
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TurnoPaciente]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TurnoPaciente](
	[idTurno] [dbo].[turno] NOT NULL,
	[idPaciente] [dbo].[paciente] NOT NULL,
	[idMedico] [dbo].[medico] NOT NULL,
 CONSTRAINT [PK_TurnoPaciente] PRIMARY KEY CLUSTERED 
(
	[idTurno] ASC,
	[idPaciente] ASC,
	[idMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PacientesTurnosPendientes]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PacientesTurnosPendientes]
AS
SELECT        p.idPaciente, p.nombre, p.apellido, T.idTurno, T.estado
FROM            dbo.Paciente AS p INNER JOIN
                         dbo.TurnoPaciente AS TP ON TP.idPaciente = p.idPaciente INNER JOIN
                         dbo.Turno AS T ON T.idTurno = TP.idTurno
WHERE        (ISNULL(T.estado, 0) = 0)
GO
/****** Object:  View [dbo].[VistaPrueba]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaPrueba]
AS
SELECT        dbo.Turno.idTurno, dbo.TurnoPaciente.idPaciente, dbo.Paciente.nombre, dbo.Paciente.apellido, dbo.Turno.estado
FROM            dbo.Turno INNER JOIN
                         dbo.TurnoPaciente ON dbo.Turno.idTurno = dbo.TurnoPaciente.idTurno INNER JOIN
                         dbo.Paciente ON dbo.TurnoPaciente.idPaciente = dbo.Paciente.idPaciente
WHERE        (ISNULL(dbo.Turno.estado, 0) = 0)
GO
/****** Object:  Table [dbo].[Medico]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medico](
	[idMedico] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
 CONSTRAINT [PK_Medico] PRIMARY KEY CLUSTERED 
(
	[idMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicoEspecialidad]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicoEspecialidad](
	[idMedico] [int] NOT NULL,
	[idEspecialidad] [int] NOT NULL,
	[descripcion] [varchar](30) NULL,
 CONSTRAINT [PK_MedicoEspecialidad] PRIMARY KEY CLUSTERED 
(
	[idMedico] ASC,
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VIEW_MedicosEspecialidades]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_MedicosEspecialidades] AS

select M.idmedico,M.nombre,M.apellido,ME.idEspecialidad,Me.descripcion from Medico M
inner join MedicoEspecialidad ME
on ME.idmedico = M.idMedico
GO
/****** Object:  Table [dbo].[Concepto]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Concepto](
	[idConcepto] [tinyint] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NULL,
 CONSTRAINT [PK_Concepto] PRIMARY KEY CLUSTERED 
(
	[idConcepto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Especialidad]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especialidad](
	[idEspecialidad] [int] IDENTITY(1,1) NOT NULL,
	[especialidad] [varchar](30) NULL,
 CONSTRAINT [PK_Especialidad] PRIMARY KEY CLUSTERED 
(
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Historia]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Historia](
	[idHistoria] [dbo].[historia] IDENTITY(1,1) NOT NULL,
	[fechaHistoria] [datetime] NULL,
	[observacion] [varchar](2000) NULL,
 CONSTRAINT [PK_Historia] PRIMARY KEY CLUSTERED 
(
	[idHistoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoriaPaciente]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoriaPaciente](
	[idHistoria] [dbo].[historia] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idMedico] [int] NOT NULL,
 CONSTRAINT [PK_HistoriaPaciente] PRIMARY KEY CLUSTERED 
(
	[idHistoria] ASC,
	[idPaciente] ASC,
	[idMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PacienteLog]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PacienteLog](
	[idpaciente] [dbo].[paciente] NOT NULL,
	[idpais] [dbo].[pais] NULL,
	[fechacarga] [datetime] NULL,
 CONSTRAINT [PK_PacienteLog] PRIMARY KEY CLUSTERED 
(
	[idpaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pago]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pago](
	[idPago] [int] IDENTITY(1,1) NOT NULL,
	[concepto] [tinyint] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[monto] [money] NOT NULL,
	[estado] [tinyint] NULL,
	[observacion] [varchar](1000) NULL,
 CONSTRAINT [PK_Pago] PRIMARY KEY CLUSTERED 
(
	[idPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PagoPaciente]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PagoPaciente](
	[idPago] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idTurno] [int] NOT NULL,
 CONSTRAINT [PK_PagoPaciente] PRIMARY KEY CLUSTERED 
(
	[idPago] ASC,
	[idPaciente] ASC,
	[idTurno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[idPais] [char](3) NOT NULL,
	[pais] [char](3) NULL,
 CONSTRAINT [PK_Pais] PRIMARY KEY CLUSTERED 
(
	[idPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TurnoEstado]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TurnoEstado](
	[idestado] [smallint] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK__TurnoEst__5406DDABD1FE8D8A] PRIMARY KEY CLUSTERED 
(
	[idestado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Especialidad] ON 

INSERT [dbo].[Especialidad] ([idEspecialidad], [especialidad]) VALUES (1, N'CLINICA MEDICA')
INSERT [dbo].[Especialidad] ([idEspecialidad], [especialidad]) VALUES (2, N'TRAUMATOLOGIA')
INSERT [dbo].[Especialidad] ([idEspecialidad], [especialidad]) VALUES (3, N'DIABETOLOGA')
INSERT [dbo].[Especialidad] ([idEspecialidad], [especialidad]) VALUES (4, N'DERMATOLOGÍA')
SET IDENTITY_INSERT [dbo].[Especialidad] OFF
GO
SET IDENTITY_INSERT [dbo].[Historia] ON 

INSERT [dbo].[Historia] ([idHistoria], [fechaHistoria], [observacion]) VALUES (1, CAST(N'1905-07-07T00:00:00.000' AS DateTime), N'xd')
INSERT [dbo].[Historia] ([idHistoria], [fechaHistoria], [observacion]) VALUES (2, CAST(N'1905-07-06T00:00:00.000' AS DateTime), N'xd')
INSERT [dbo].[Historia] ([idHistoria], [fechaHistoria], [observacion]) VALUES (4, CAST(N'1900-03-09T00:00:00.000' AS DateTime), N'xd')
INSERT [dbo].[Historia] ([idHistoria], [fechaHistoria], [observacion]) VALUES (5, CAST(N'1905-06-30T00:00:00.000' AS DateTime), N'hola q tal')
INSERT [dbo].[Historia] ([idHistoria], [fechaHistoria], [observacion]) VALUES (6, CAST(N'1905-06-30T00:00:00.000' AS DateTime), N'hola q tal')
SET IDENTITY_INSERT [dbo].[Historia] OFF
GO
SET IDENTITY_INSERT [dbo].[Medico] ON 

INSERT [dbo].[Medico] ([idMedico], [nombre], [apellido]) VALUES (2, N'pedro', N'porro')
INSERT [dbo].[Medico] ([idMedico], [nombre], [apellido]) VALUES (3, N'gerardo', N'martinez')
SET IDENTITY_INSERT [dbo].[Medico] OFF
GO
INSERT [dbo].[MedicoEspecialidad] ([idMedico], [idEspecialidad], [descripcion]) VALUES (2, 2, N'medico clinico')
INSERT [dbo].[MedicoEspecialidad] ([idMedico], [idEspecialidad], [descripcion]) VALUES (3, 1, N'medico residente')
GO
SET IDENTITY_INSERT [dbo].[Paciente] ON 

INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (1, NULL, N'Jogre', N'Ramirez', CAST(N'2019-01-18' AS Date), NULL, N'ESP', NULL, NULL, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (4, NULL, N'Jean', N'Darros', CAST(N'2017-01-04' AS Date), N'montes 435', N'ESP', N'', N'jeand@gmailcom', N'observacion modificada')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (5, NULL, N'Roberto', N'Perez', CAST(N'2017-01-04' AS Date), N'piedra buena 21', N'ESP', N'', N'', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (6, NULL, N'Roberto', N'Perez', CAST(N'2017-01-04' AS Date), N'piedra buena 21', N'ESP', N'-3363', N'', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (7, NULL, N'Roberto', N'Perez', CAST(N'2017-01-04' AS Date), N'piedra buena 21', N'ESP', N'', N'', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (12, N'2324323', N'pedro', N'pascal', CAST(N'2018-05-19' AS Date), N'calle 2', N'arg', N'', N'pedropascal@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (17, N'2324326', N'pedrito', N'lopez', CAST(N'2019-06-17' AS Date), N'calle 2', N'per', N'', N'pedritolopez@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (20, N'2324321', N'martin', N'fedelobo', CAST(N'2019-06-12' AS Date), N'calle 3', N'MEX', N'', N'elfedeobo@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (21, N'3625625522', N'Arnol ', N'Espitaleta Sierra', CAST(N'1979-10-22' AS Date), N'Calle 12', N'MEX', N'324324343', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (22, N'5125421215', N'Jonathan', N'Matamoros', CAST(N'1979-10-23' AS Date), N'Calle 13', N'COL', N'435345345', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (24, N'5441214842', N'Francisco', N'Rios', CAST(N'1979-10-25' AS Date), N'Calle 15', N'MEX', N'', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (26, N'2164949494', N'juan ', N'León ', CAST(N'1979-10-27' AS Date), N'Calle 17', N'PER', N'', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (27, N'5497945111', N'Brian', N'González ', CAST(N'1979-10-28' AS Date), N'Calle 18', N'ARG', N'43545567678', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (28, N'3156148498', N'Emmanuel', N'Vazquez', CAST(N'1979-10-29' AS Date), N'Calle 19', N'MEX', N'', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (29, N'6119849844', N'Diego ', N'Silva ', CAST(N'1979-10-30' AS Date), N'Calle 20', N'MEX', N'423878', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (30, N'1844949484', N'Jose', N'Carlos', CAST(N'1979-10-31' AS Date), N'Calle 21', N'PER', N'34234', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (32, N'5464848484', N'Julio', N'Rodríguez', CAST(N'1979-11-02' AS Date), N'Calle 23', N'PER', N'76786575', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (33, N'4975497974', N'Michael', N'Guevara Morales', CAST(N'1979-11-03' AS Date), N'Calle 24', N'MEX', N'23213232', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (35, N'5451231119', N'Angel', N'González Osorio', CAST(N'1979-11-05' AS Date), N'Calle 26', N'PER', N'655', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (37, N'2161986541', N'Edenilson', N'Crespin', CAST(N'1979-11-07' AS Date), N'Calle 28', N'MEX', N'', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (39, N'1611148797', N'Alexis', N'Torres', CAST(N'1979-11-09' AS Date), N'Calle 30', N'PER', N'56', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (40, N'1879798777', N'Jorge', N'Moreno', CAST(N'1979-11-10' AS Date), N'Calle 31', N'MEX', N'56546', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (41, N'2151647747', N'Jesus ', N'Arriaga omonte', CAST(N'1979-11-11' AS Date), N'Calle 32', N'COL', N'', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (42, N'8989849777', N'Jorge', N'Moreno', CAST(N'1979-11-12' AS Date), N'Calle 33', N'MEX', N'5465456564', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (43, N'9787545555', N'Arturo ', N'Meneses ', CAST(N'1979-11-13' AS Date), N'Calle 34', N'COL', N'', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (44, N'2132165484', N'Geovanny', N'Sierra', CAST(N'1979-11-14' AS Date), N'Calle 35', N'COL', N'', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (45, N'5498878779', N'jose', N'maldonado', CAST(N'1979-11-15' AS Date), N'Calle 36', N'COL', N'', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (46, N'3216488484', N'Luis Ismael ', N'Díaz de León Ruiz ', CAST(N'1979-11-16' AS Date), N'Calle 37', N'COL', N'5464566', N'prueba@gmail.com', N'')
INSERT [dbo].[Paciente] ([idPaciente], [dni], [nombre], [apellido], [fNacimineto], [domicilio], [idPais], [telefono], [email], [observacion]) VALUES (47, N'4947897978', N'Danny', N'Ruiz', CAST(N'1979-11-17' AS Date), N'Calle 38', N'COL', N'546787989', N'prueba@gmail.com', N'')
SET IDENTITY_INSERT [dbo].[Paciente] OFF
GO
INSERT [dbo].[PacienteLog] ([idpaciente], [idpais], [fechacarga]) VALUES (20, N'MEX', CAST(N'2023-05-08T15:26:15.137' AS DateTime))
INSERT [dbo].[PacienteLog] ([idpaciente], [idpais], [fechacarga]) VALUES (21, N'MEX', CAST(N'2023-05-12T15:59:50.180' AS DateTime))
INSERT [dbo].[PacienteLog] ([idpaciente], [idpais], [fechacarga]) VALUES (24, N'MEX', CAST(N'2023-05-12T15:59:50.183' AS DateTime))
INSERT [dbo].[PacienteLog] ([idpaciente], [idpais], [fechacarga]) VALUES (28, N'MEX', CAST(N'2023-05-12T15:59:50.183' AS DateTime))
INSERT [dbo].[PacienteLog] ([idpaciente], [idpais], [fechacarga]) VALUES (29, N'MEX', CAST(N'2023-05-12T15:59:50.183' AS DateTime))
INSERT [dbo].[PacienteLog] ([idpaciente], [idpais], [fechacarga]) VALUES (33, N'MEX', CAST(N'2023-05-12T15:59:50.187' AS DateTime))
INSERT [dbo].[PacienteLog] ([idpaciente], [idpais], [fechacarga]) VALUES (37, N'MEX', CAST(N'2023-05-12T15:59:50.187' AS DateTime))
INSERT [dbo].[PacienteLog] ([idpaciente], [idpais], [fechacarga]) VALUES (40, N'MEX', CAST(N'2023-05-12T15:59:50.187' AS DateTime))
INSERT [dbo].[PacienteLog] ([idpaciente], [idpais], [fechacarga]) VALUES (42, N'MEX', CAST(N'2023-05-12T15:59:50.187' AS DateTime))
GO
INSERT [dbo].[Pais] ([idPais], [pais]) VALUES (N'ARG', N'arg')
INSERT [dbo].[Pais] ([idPais], [pais]) VALUES (N'BRA', N'bra')
INSERT [dbo].[Pais] ([idPais], [pais]) VALUES (N'COL', N'col')
INSERT [dbo].[Pais] ([idPais], [pais]) VALUES (N'ESP', N'esp')
INSERT [dbo].[Pais] ([idPais], [pais]) VALUES (N'MEX', N'MEX')
INSERT [dbo].[Pais] ([idPais], [pais]) VALUES (N'PER', N'per')
GO
SET IDENTITY_INSERT [dbo].[Turno] ON 

INSERT [dbo].[Turno] ([idTurno], [fechaTurno], [estado], [observacion]) VALUES (1, CAST(N'2020-03-02T13:00:00.000' AS DateTime), 2, N'')
INSERT [dbo].[Turno] ([idTurno], [fechaTurno], [estado], [observacion]) VALUES (2, CAST(N'2020-03-03T14:00:00.000' AS DateTime), 2, N'')
INSERT [dbo].[Turno] ([idTurno], [fechaTurno], [estado], [observacion]) VALUES (7, CAST(N'2019-08-13T08:15:00.000' AS DateTime), 2, N'el paceinte no estaba en ayunas')
INSERT [dbo].[Turno] ([idTurno], [fechaTurno], [estado], [observacion]) VALUES (8, CAST(N'2019-08-14T09:15:00.000' AS DateTime), 2, N'el paceinte no estaba en ayunas')
INSERT [dbo].[Turno] ([idTurno], [fechaTurno], [estado], [observacion]) VALUES (9, CAST(N'2019-07-14T09:15:00.000' AS DateTime), 2, N'el paciente ha sido atendido')
INSERT [dbo].[Turno] ([idTurno], [fechaTurno], [estado], [observacion]) VALUES (11, CAST(N'2020-07-13T05:15:00.000' AS DateTime), 2, N'nada')
INSERT [dbo].[Turno] ([idTurno], [fechaTurno], [estado], [observacion]) VALUES (22, CAST(N'2023-06-12T00:00:00.000' AS DateTime), 1, N'clave')
SET IDENTITY_INSERT [dbo].[Turno] OFF
GO
INSERT [dbo].[TurnoEstado] ([idestado], [descripcion]) VALUES (0, N'Pendiente')
INSERT [dbo].[TurnoEstado] ([idestado], [descripcion]) VALUES (1, N'Realizado')
INSERT [dbo].[TurnoEstado] ([idestado], [descripcion]) VALUES (2, N'Cancelado')
GO
INSERT [dbo].[TurnoPaciente] ([idTurno], [idPaciente], [idMedico]) VALUES (1, 3, 3)
INSERT [dbo].[TurnoPaciente] ([idTurno], [idPaciente], [idMedico]) VALUES (11, 4, 2)
GO
ALTER TABLE [dbo].[HistoriaPaciente]  WITH CHECK ADD  CONSTRAINT [FK_HistoriaPaciente_Historia] FOREIGN KEY([idHistoria])
REFERENCES [dbo].[Historia] ([idHistoria])
GO
ALTER TABLE [dbo].[HistoriaPaciente] CHECK CONSTRAINT [FK_HistoriaPaciente_Historia]
GO
ALTER TABLE [dbo].[HistoriaPaciente]  WITH CHECK ADD  CONSTRAINT [FK_HistoriaPaciente_Medico] FOREIGN KEY([idMedico])
REFERENCES [dbo].[Medico] ([idMedico])
GO
ALTER TABLE [dbo].[HistoriaPaciente] CHECK CONSTRAINT [FK_HistoriaPaciente_Medico]
GO
ALTER TABLE [dbo].[HistoriaPaciente]  WITH CHECK ADD  CONSTRAINT [FK_HistoriaPaciente_Paciente] FOREIGN KEY([idPaciente])
REFERENCES [dbo].[Paciente] ([idPaciente])
GO
ALTER TABLE [dbo].[HistoriaPaciente] CHECK CONSTRAINT [FK_HistoriaPaciente_Paciente]
GO
ALTER TABLE [dbo].[MedicoEspecialidad]  WITH CHECK ADD  CONSTRAINT [FK_MedicoEspecialidad_Especialidad] FOREIGN KEY([idEspecialidad])
REFERENCES [dbo].[Especialidad] ([idEspecialidad])
GO
ALTER TABLE [dbo].[MedicoEspecialidad] CHECK CONSTRAINT [FK_MedicoEspecialidad_Especialidad]
GO
ALTER TABLE [dbo].[MedicoEspecialidad]  WITH CHECK ADD  CONSTRAINT [FK_MedicoEspecialidad_Medico] FOREIGN KEY([idMedico])
REFERENCES [dbo].[Medico] ([idMedico])
GO
ALTER TABLE [dbo].[MedicoEspecialidad] CHECK CONSTRAINT [FK_MedicoEspecialidad_Medico]
GO
ALTER TABLE [dbo].[Paciente]  WITH CHECK ADD  CONSTRAINT [FK_Paciente_Pais] FOREIGN KEY([idPais])
REFERENCES [dbo].[Pais] ([idPais])
GO
ALTER TABLE [dbo].[Paciente] CHECK CONSTRAINT [FK_Paciente_Pais]
GO
ALTER TABLE [dbo].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Pago_Concepto] FOREIGN KEY([concepto])
REFERENCES [dbo].[Concepto] ([idConcepto])
GO
ALTER TABLE [dbo].[Pago] CHECK CONSTRAINT [FK_Pago_Concepto]
GO
ALTER TABLE [dbo].[PagoPaciente]  WITH CHECK ADD  CONSTRAINT [FK_PagoPaciente_Paciente] FOREIGN KEY([idPago])
REFERENCES [dbo].[Paciente] ([idPaciente])
GO
ALTER TABLE [dbo].[PagoPaciente] CHECK CONSTRAINT [FK_PagoPaciente_Paciente]
GO
ALTER TABLE [dbo].[PagoPaciente]  WITH CHECK ADD  CONSTRAINT [FK_PagoPaciente_Pago] FOREIGN KEY([idPago])
REFERENCES [dbo].[Pago] ([idPago])
GO
ALTER TABLE [dbo].[PagoPaciente] CHECK CONSTRAINT [FK_PagoPaciente_Pago]
GO
ALTER TABLE [dbo].[PagoPaciente]  WITH CHECK ADD  CONSTRAINT [FK_PagoPaciente_Turno] FOREIGN KEY([idTurno])
REFERENCES [dbo].[Turno] ([idTurno])
GO
ALTER TABLE [dbo].[PagoPaciente] CHECK CONSTRAINT [FK_PagoPaciente_Turno]
GO
ALTER TABLE [dbo].[Turno]  WITH CHECK ADD  CONSTRAINT [FK_Turno_TurnoEstado] FOREIGN KEY([estado])
REFERENCES [dbo].[TurnoEstado] ([idestado])
GO
ALTER TABLE [dbo].[Turno] CHECK CONSTRAINT [FK_Turno_TurnoEstado]
GO
ALTER TABLE [dbo].[TurnoPaciente]  WITH CHECK ADD  CONSTRAINT [FK_TurnoPaciente_Medico] FOREIGN KEY([idMedico])
REFERENCES [dbo].[Medico] ([idMedico])
GO
ALTER TABLE [dbo].[TurnoPaciente] CHECK CONSTRAINT [FK_TurnoPaciente_Medico]
GO
ALTER TABLE [dbo].[TurnoPaciente]  WITH CHECK ADD  CONSTRAINT [FK_TurnoPaciente_Paciente] FOREIGN KEY([idPaciente])
REFERENCES [dbo].[Paciente] ([idPaciente])
GO
ALTER TABLE [dbo].[TurnoPaciente] CHECK CONSTRAINT [FK_TurnoPaciente_Paciente]
GO
ALTER TABLE [dbo].[TurnoPaciente]  WITH CHECK ADD  CONSTRAINT [FK_TurnoPaciente_Turno] FOREIGN KEY([idTurno])
REFERENCES [dbo].[Turno] ([idTurno])
GO
ALTER TABLE [dbo].[TurnoPaciente] CHECK CONSTRAINT [FK_TurnoPaciente_Turno]
GO
/****** Object:  StoredProcedure [dbo].[ALTA_Especialidad]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from especialidad

--EXEC alta_especialidad 'DERMATOLOGÍA'

CREATE proc [dbo].[ALTA_Especialidad](
			@especialidad varchar(30)
			)

as

set nocount on

IF NOT EXISTS(SELECT TOP 1 idespecialidad from Especialidad WHERE especialidad = @especialidad)
BEGIN
	INSERT INTO Especialidad (especialidad)
	VALUES (@especialidad)
	print 'La especialidad se agregó correctamente'
	return
END
ELSE
BEGIN
	print 'La especialidad ya existe.'
	return
END
GO
/****** Object:  StoredProcedure [dbo].[ALTA_Medico]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ALTA_Medico](

	@nombre varchar(50),
	@apellido varchar(20),
	@idEspecialidad int,
	@descripcion  varchar(50)
			)
as

set nocount on

if not exists (select top 1 idmedico from medico where nombre = @nombre and apellido= @apellido)
begin

insert into Medico (nombre,apellido)
values (@nombre,@apellido)

declare @auxidmedico medico
set @auxidmedico =  @@identity

insert into MedicoEspecialidad (idmedico,idespecialidad,descripcion)
values (@auxidmedico,@idEspecialidad,@descripcion)

print 'el medico se agrego correctamente'
	return
	end
else 
	begin
print 'el medico ya exitse'
	return
	end
GO
/****** Object:  StoredProcedure [dbo].[ALTA_Turno]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ALTA_Turno](

	@fecha char(14),
	@idPaciente paciente,
	@idMedico medico,
	@observacion observacion
			)
as
/*estado 0 = pendiente
estado 1 realizado
estado 2 cancelado
*/
if not exists (select top 1 idturno from Turno where fechaTurno =@fecha)
begin

insert into Turno  (fechaTurno,estado,observacion)
values (@fecha,0,@observacion)

declare @auxidturno turno
set @auxidturno =  @@identity

insert into TurnoPaciente (idTurno,idPaciente,idMedico)
values (@auxidturno,@idPaciente,@idMedico)

print 'el turno se agregor correctamente'
	return
	end
else 
	begin
print 'el turno ya exitse'
	return
	end
GO
/****** Object:  StoredProcedure [dbo].[DEL_Turno]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DEL_Turno](
				@idturno turno				)

AS
set nocount on


if exists(SELECT * from Turno
			WHERE idturno = @idturno)
BEGIN	
	DELETE FROM TurnoPaciente WHERE idturno = @idturno
	DELETE FROM Turno WHERE idturno = @idturno
END
ELSE
	SELECT 0 as resultado
GO
/****** Object:  StoredProcedure [dbo].[paciente_alta]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[paciente_alta](

			@dni varchar(20),
			@nombre varchar(50),
			@apellido varchar(50),
			@fNacimiento varchar(8),
			@domicilio varchar (50),
			@idPais char(3),
			@tel varchar (20)='',
			@email varchar (30),
			@observacion observacion =''
			)
as

if not exists (select * from Paciente where dni =@dni)
begin

insert into Paciente (dni,nombre,apellido,fNacimineto,domicilio,idPais,telefono,email,observacion)
values (@dni,@nombre,@apellido,@fNacimiento,@domicilio,@idPais,@tel,@email,@observacion)
print 'el paciente se agregor correctamente'
	return
	end
else 
	begin
print 'el paciente ya exitse'
	return
	end


	exec paciente_alta'2324324','jorge','lopez''20180518','calle 1','per','','jorgelopez@gmail.com',''
		exec paciente_alta '2324323','pedro','pascal','20180519','calle 2','arg','','pedropascal@gmail.com',''

	select * from Paciente

GO
/****** Object:  StoredProcedure [dbo].[S_paciente]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[S_paciente](
@idPaciente int
)
as 
select * from Paciente where idPaciente=@idPaciente
GO
/****** Object:  StoredProcedure [dbo].[SEL_EspecialidadesMedica]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--exec SEL_EspecialidadesMedica

CREATE PROC [dbo].[SEL_EspecialidadesMedica]

AS
set nocount on

--select * from especialidad


if exists(SELECT * from especialidad)
	SELECT * from especialidad
else
	select 0 as resultado
GO
/****** Object:  StoredProcedure [dbo].[SEL_HistoriaPaciente]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROC [dbo].[SEL_HistoriaPaciente](
				@idpaciente paciente)
				
AS
set nocount on

/*
select * from historia
select * from historiapaciente

*/

IF exists(SELECT * from Paciente P
				INNER JOIN HistoriaPaciente HP
				ON HP.idPaciente = P.idPaciente
				INNER JOIN Historia H
				ON H.idHistoria = HP.idHistoria
				INNER JOIN MedicoEspecialidad ME
				ON ME.idMedico = HP.idMedico
				INNER JOIN Medico M
				ON M.idMedico = ME.idMedico
				WHERE P.idPaciente = @idpaciente)
	SELECT * from Paciente P
	INNER JOIN HistoriaPaciente HP
	ON HP.idPaciente = P.idPaciente
	INNER JOIN Historia H
	ON H.idHistoria = HP.idHistoria
	INNER JOIN MedicoEspecialidad ME
	ON ME.idMedico = HP.idMedico
	INNER JOIN Medico M
	ON M.idMedico = ME.idMedico
	WHERE P.idPaciente = @idpaciente
ELSE
	--print 'No existen historias clinicas para el paciente'
	select 0 as resultado
GO
/****** Object:  StoredProcedure [dbo].[SELECT_TurnosPaciente]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec SELECT_turnospaciente 6 

CREATE PROC [dbo].[SELECT_TurnosPaciente](
				@idpaciente paciente
				)

AS
set nocount on

IF exists(SELECT * from Paciente P
				INNER JOIN TurnoPaciente TP
				ON TP.idPaciente = P.idPaciente
				INNER JOIN Turno T
				ON T.idTurno = TP.idTurno
				INNER JOIN MedicoEspecialidad M
				ON M.idMedico = TP.idMedico
				WHERE P.idpaciente = @idpaciente
				)
	SELECT * from Paciente P
	INNER JOIN TurnoPaciente TP
	ON TP.idPaciente = P.idPaciente
	INNER JOIN Turno T
	ON T.idTurno = TP.idTurno
	INNER JOIN MedicoEspecialidad M
	ON M.idMedico = TP.idMedico
	WHERE P.idpaciente = @idpaciente
else
	select 0 as resultado
GO
/****** Object:  StoredProcedure [dbo].[UPD_Paciente]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UPD_Paciente](
				@idpaciente paciente,
				@nombre varchar(50),
				@apellido varchar(50),
				@domicilio varchar(50),
				@email varchar(30))

AS
set nocount on

if exists(SELECT * from Paciente
			WHERE idPaciente = @idpaciente)
	UPDATE Paciente SET nombre = @nombre,
					apellido = @apellido,
					domicilio = @domicilio,
					email = @email
	WHERE idpaciente = @idpaciente


ELSE
	SELECT 0 as resultado
GO
/****** Object:  StoredProcedure [dbo].[UPD_Turno]    Script Date: 5/24/2025 11:52:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UPD_Turno](
				@idturno turno,
				@estado tinyint,
				@observacion observacion)

AS
set nocount on

if exists(SELECT * from Turno
			WHERE idturno = @idturno)
	UPDATE Turno SET estado = @estado,
					observacion = @observacion
	WHERE idturno = @idturno


ELSE
	SELECT 0 as resultado
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -107
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TP"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 120
               Left = 246
               Bottom = 250
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PacientesTurnosPendientes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PacientesTurnosPendientes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Paciente"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Turno"
            Begin Extent = 
               Top = 63
               Left = 237
               Bottom = 193
               Right = 407
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TurnoPaciente"
            Begin Extent = 
               Top = 6
               Left = 445
               Bottom = 119
               Right = 615
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaPrueba'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VistaPrueba'
GO
USE [master]
GO
ALTER DATABASE [CentroMedico] SET  READ_WRITE 
GO
