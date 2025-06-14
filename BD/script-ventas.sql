USE [dbVentas]
GO
/****** Object:  UserDefinedTableType [dbo].[EDetalle_Compra]    Script Date: 2/6/2025 16:36:11 ******/
CREATE TYPE [dbo].[EDetalle_Compra] AS TABLE(
	[IdProducto] [int] NULL,
	[PrecioCompra] [decimal](18, 2) NULL,
	[PrecioVenta] [decimal](18, 2) NULL,
	[Cantidad] [int] NULL,
	[MontoTotal] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[EDetalle_Venta]    Script Date: 2/6/2025 16:36:11 ******/
CREATE TYPE [dbo].[EDetalle_Venta] AS TABLE(
	[IdProducto] [int] NULL,
	[PrecioVenta] [decimal](18, 2) NULL,
	[Cantidad] [int] NULL,
	[SubTotal] [decimal](18, 2) NULL
)
GO
/****** Object:  Table [dbo].[CATEGORIA]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](200) NULL,
	[Estado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
	[Nombre] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLIENTE]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[NumeroDocumento] [varchar](50) NULL,
	[NombreCompleto] [varchar](50) NULL,
	[Correo] [varchar](20) NULL,
	[Telefono] [varchar](20) NULL,
	[Estado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COMPRA]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMPRA](
	[IdCompra] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[IdProveedor] [int] NULL,
	[TipoDocumento] [varchar](50) NULL,
	[NumeroDocumento] [varchar](50) NULL,
	[MontoTotal] [decimal](10, 2) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_COMPRA]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_COMPRA](
	[IdDetalleCompra] [int] IDENTITY(1,1) NOT NULL,
	[IdCompra] [int] NULL,
	[IdProducto] [int] NULL,
	[IdProveedor] [int] NULL,
	[PrecioCompra] [decimal](10, 2) NULL,
	[PrecioVenta] [decimal](10, 2) NULL,
	[Cantidad] [int] NULL,
	[MnontoTotal] [decimal](10, 2) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DETALLE_VENTA]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_VENTA](
	[IdDetalleVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdVenta] [int] NULL,
	[IdProducto] [int] NULL,
	[PrecioVenta] [decimal](10, 2) NOT NULL,
	[Cantidad] [int] NULL,
	[SubTotal] [decimal](10, 2) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NEGOCIO]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NEGOCIO](
	[IdNegocio] [int] NOT NULL,
	[Nombre] [varchar](60) NULL,
	[RUC] [varchar](60) NULL,
	[Direccion] [varchar](60) NULL,
	[Logo] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNegocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NOTIFICACION_NOTIFICACION]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NOTIFICACION_NOTIFICACION](
	[IdNotificacionProducto] [int] IDENTITY(1,1) NOT NULL,
	[IdProducto] [int] NULL,
	[FechaNotificacion] [datetime] NULL,
	[FechVencimientoProducto] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNotificacionProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NOTIFICACION_STOCK]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NOTIFICACION_STOCK](
	[IdNotificacionProducto] [int] IDENTITY(1,1) NOT NULL,
	[IdProducto] [int] NULL,
	[FechaNotificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNotificacionProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERMISO]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERMISO](
	[IdPermiso] [int] IDENTITY(1,1) NOT NULL,
	[idRol] [int] NULL,
	[NombreMenu] [varchar](100) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTO]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[IdCategoria] [int] NULL,
	[Stock] [int] NOT NULL,
	[PrecioCompra] [decimal](10, 2) NULL,
	[PrecioVenta] [decimal](10, 3) NULL,
	[Estado] [bit] NULL,
	[FechaVencimiento] [datetime] NULL,
	[FechaRegistro] [datetime] NULL,
	[Descripcion] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVEEDOR]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROVEEDOR](
	[IdProveedor] [int] IDENTITY(1,1) NOT NULL,
	[Documento] [varchar](50) NULL,
	[RazonSocial] [varchar](50) NULL,
	[Correo] [varchar](20) NULL,
	[Telefono] [varchar](20) NULL,
	[Estado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROL]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROL](
	[IdRol] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Documento] [varchar](50) NULL,
	[NombreCompleto] [varchar](50) NULL,
	[Correo] [varchar](20) NULL,
	[Clave] [varchar](50) NULL,
	[idRol] [int] NULL,
	[Estado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VENTA]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VENTA](
	[IdVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[TipoDocumento] [varchar](50) NULL,
	[NumeroDocumento] [varchar](50) NULL,
	[NombreCliente] [varchar](100) NULL,
	[DocumentoCliente] [varchar](50) NULL,
	[MontoPago] [decimal](10, 2) NULL,
	[MontoCambio] [decimal](10, 2) NULL,
	[MontoTotal] [decimal](10, 2) NULL,
	[FechaVenta] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CATEGORIA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[COMPRA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[detalle_COMPRA] ADD  DEFAULT ((0)) FOR [PrecioCompra]
GO
ALTER TABLE [dbo].[detalle_COMPRA] ADD  DEFAULT ((0)) FOR [PrecioVenta]
GO
ALTER TABLE [dbo].[detalle_COMPRA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[DETALLE_VENTA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[NOTIFICACION_NOTIFICACION] ADD  DEFAULT (getdate()) FOR [FechaNotificacion]
GO
ALTER TABLE [dbo].[NOTIFICACION_STOCK] ADD  DEFAULT (getdate()) FOR [FechaNotificacion]
GO
ALTER TABLE [dbo].[PERMISO] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((0)) FOR [PrecioCompra]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((0)) FOR [PrecioVenta]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[PROVEEDOR] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[ROL] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[USUARIO] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[VENTA] ADD  DEFAULT (getdate()) FOR [FechaVenta]
GO
ALTER TABLE [dbo].[COMPRA]  WITH CHECK ADD FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[PROVEEDOR] ([IdProveedor])
GO
ALTER TABLE [dbo].[COMPRA]  WITH CHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[USUARIO] ([IdUsuario])
GO
ALTER TABLE [dbo].[detalle_COMPRA]  WITH CHECK ADD FOREIGN KEY([IdCompra])
REFERENCES [dbo].[COMPRA] ([IdCompra])
GO
ALTER TABLE [dbo].[detalle_COMPRA]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[detalle_COMPRA]  WITH CHECK ADD FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[PROVEEDOR] ([IdProveedor])
GO
ALTER TABLE [dbo].[DETALLE_VENTA]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[DETALLE_VENTA]  WITH CHECK ADD FOREIGN KEY([IdVenta])
REFERENCES [dbo].[VENTA] ([IdVenta])
GO
ALTER TABLE [dbo].[NOTIFICACION_NOTIFICACION]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[NOTIFICACION_STOCK]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[PERMISO]  WITH CHECK ADD FOREIGN KEY([idRol])
REFERENCES [dbo].[ROL] ([IdRol])
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[CATEGORIA] ([IdCategoria])
GO
ALTER TABLE [dbo].[USUARIO]  WITH CHECK ADD FOREIGN KEY([idRol])
REFERENCES [dbo].[ROL] ([IdRol])
GO
ALTER TABLE [dbo].[VENTA]  WITH CHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[USUARIO] ([IdUsuario])
GO
/****** Object:  StoredProcedure [dbo].[SP_EditarCategoria]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_EditarCategoria](
@IdCategoria int ,
@Descripcion varchar (50),
@Estado bit ,
@Resultado bit output,
@Mensaje varchar (500) output
)

as 
begin 
  set @Resultado = 1 
  if not exists (select * from CATEGORIA where Descripcion =@Descripcion and IdCategoria !=@IdCategoria)

  update CATEGORIA set
  Descripcion = @Descripcion,
  Estado = @Estado
  where IdCategoria = @IdCategoria
  else
  begin
  set @Resultado = 0 
  set @Mensaje = 'No se puede repetir la descripcion de una Categoria'
  end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_EditarUSUARIO]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_EditarUSUARIO](

@IdUsuario int ,
@Documento varchar (50),
@NombreCompleto varchar (100),
@Correo varchar (100),
@Clave varchar (100),
@IdRol int ,
@Estado bit,
@Respuesta bit  output,
@Mensaje varchar  (500) output 
)
as begin

set @Respuesta = 0
set @Mensaje = ''

if not exists (select * from USUARIO where Documento = @Documento AND IdUsuario != @IdUsuario)
begin 
    update  USUARIO set 
	Documento = @Documento,
	NombreCompleto = @NombreCompleto,
	Correo= @Correo,
	Clave=@Clave,
	idRol=@IdRol,
	Estado=@Estado
	where IdUsuario = @IdUsuario
	

    set @Respuesta = 1
	
end
else 
    set @Mensaje = 'NO SE PUEDE REPETIR EL DOCUMENTO PARA MAS DE UN USUARIO'

end
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarCategoria]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_EliminarCategoria](
@IdCategoria int ,
@Resultado bit output,
@Mensaje varchar (500) output
)

as 
begin 
  set @Resultado = 1 
  if not exists (
  select * from CATEGORIA  c
  inner join PRODUCTO p on p.IdCategoria = c.IdCategoria
  where c.IdCategoria = @IdCategoria)
  begin
  delete top(1) from CATEGORIA where IdCategoria = @IdCategoria
  end 
  else
  BEGIN
     set @Resultado = 0 
     set @Mensaje = 'La categoria encuentra relacionada a un producto'
  end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarProducto]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_EliminarProducto](
@IdProducto int ,
@Respuesta bit output,
@Mensaje varchar (500) output
)
as
begin
     set @Respuesta = 0
	 set @Mensaje = ''
	 declare @pasoreglas bit = 1

	 if exists (select * from detalle_COMPRA dc
	 inner join PRODUCTO p on p.IdProducto = dc.IdProducto
	 where p.IdProducto= @IdProducto
	 )
begin
     set @pasoreglas = 0
	 set @Respuesta = 0
	 set @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una compra\n'

	 end
	 if exists (select * from DETALLE_VENTA dv
	 inner join PRODUCTO p on p.IdProducto = dv.IdProducto
	 where p.IdProducto = @IdProducto
	 )

begin
     set @pasoreglas = 0
	 set @Respuesta = 0
	 set @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionada a una venta\n'

    end

	if(@pasoreglas = 1)
begin
    delete from PRODUCTO where IdProducto = @IdProducto
	set @Respuesta = 1
	end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarProveedor]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_EliminarProveedor](
@IdProveedor int ,
@Resultado bit output,
@Mensaje varchar (500) output 
)as

begin  
     set @Resultado = 1 
	 if not exists (select * from PROVEEDOR p inner join 
	 COMPRA c  on  p.IdProveedor = c.IdProveedor
	 where p.IdProveedor = @IdProveedor)
	 begin
	      delete top (1) from PROVEEDOR WHERE IdProveedor = @IdProveedor
		  end
		  else
		   begin
		       set @Resultado = 0
			   set @Mensaje = 'El proveedor se encuentra relacionado a una compra'
			   end
	end
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarUSUARIO]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_EliminarUSUARIO](

@IdUsuario int ,
@Respuesta bit  output,
@Mensaje varchar  (500) output 
)
as
begin

set @Respuesta = 0
set @Mensaje = ''
DECLARE @pasoreglas bit = 1

if exists (select * from COMPRA c
inner join USUARIO u on u.IdUsuario = c.IdUsuario
where u.IdUsuario= @IdUsuario)
BEGIN

   set @pasoreglas = 0
   set @Respuesta = 0
   set @Mensaje =  @Mensaje + 'NO SE PUEDE ELIMINAR PORQUE EL USUARIO SE ENCUNTRA RELACIONADO A UNA COMPRA\n'

END

if exists (select * from VENTA v
inner join USUARIO u on u.IdUsuario = v.IdUsuario
where u.IdUsuario= @IdUsuario)
BEGIN
   set @pasoreglas = 0
   set @Respuesta = 0
   set @Mensaje =  @Mensaje + 'NO SE PUEDE ELIMINAR PORQUE EL USUARIO SE ENCUNTRA RELACIONADO A UNA VENTA\n'

END

if( @pasoreglas = 1)
begin
   delete from USUARIO where IdUsuario =@IdUsuario
    set @Respuesta = 1
  
end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ModificaProveedor]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_ModificaProveedor] (
	@IdProveedor int,
	@Documento varchar (50),
    @RazonSocial varchar (50),
    @Correo varchar (50),
    @Telefono varchar (50),
	@Estado bit ,
    @Resultado bit output,
    @Mensaje varchar (500) output
	) as

	begin
	     set @Resultado = 1
		 declare @IDPERSONA  INT 
		 if not exists (select * from PROVEEDOR where Documento = @Documento and IdProveedor = @IdProveedor)
		 begin

		 update PROVEEDOR SET
		 Documento = @Documento,
		 RazonSocial = @RazonSocial,
		 Correo = @Correo,
		 Telefono = @Telefono,
		 Estado = @Estado 
		 where IdProveedor = @IdProveedor
		 end
		    else
			    begin
				     set @Resultado = 0
					 set @Mensaje = 'El numero de documento ya existe '
					 end
		end
GO
/****** Object:  StoredProcedure [dbo].[SP_ModificarCliente]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_ModificarCliente](
  @IdCliente int,
  @NumeroDocumento varchar (50),
  @NombreCompleto varchar (50),
  @Correo varchar (50),
  @Telefono varchar (50),
  @Estado bit,
  @Resultado bit output,
  @Mensaje varchar (500) output
  )
  as
  begin
       set @Resultado = 1
	   declare @IDPERSONA INT 

	   IF NOT EXISTS (SELECT * FROM CLIENTE where NumeroDocumento = @NumeroDocumento and IdCliente != @IdCliente)
	   begin
	   update CLIENTE SET
	   NumeroDocumento = @NumeroDocumento,
	   NombreCompleto = @NombreCompleto,
	   Correo = @Correo,
	   Telefono = @Telefono,
	   Estado = @Estado

	   WHERE IdCliente = @IdCliente
	   END

	   ELSE
	       BEGIN 
		        SET @Resultado = 0
				SET @Mensaje ='EL Numero de documento de cliente ya existe'
		end

end
GO
/****** Object:  StoredProcedure [dbo].[SP_ModificarProducto]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ModificarProducto](
@IdProducto int ,
@Codigo varchar (20),
@Nombre varchar (30),
@Descripcion varchar (30),
@IdCategoria int,
@Stock int ,
@PrecioVenta DECIMAL(10, 3),
@FechaVencimiento datetime,
@Estado bit,
@Resultado bit output,
@Mensaje varchar(500) output
)

as
begin
     set @Resultado =1
	 if not exists (select * from PRODUCTO where Codigo = @Codigo and IdProducto != @IdProducto)

	 update PRODUCTO set
	 Codigo = @Codigo,
	 Nombre = @Nombre,
	 Descripcion = @Descripcion,
	 IdCategoria = @IdCategoria,
	 Stock = @Stock ,
	 PrecioVenta = @PrecioVenta,
	 FechaVencimiento = @FechaVencimiento,
	 Estado = @Estado

	 where IdProducto = @Idproducto
	else
	begin 
	      set @Resultado = 0 
		  set @Mensaje = 'Ya existe un poducto con el mismo codigo'
    end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_RegistrarCategoria]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_RegistrarCategoria](
@Descripcion varchar (50),
@Resultado int output,
@Estado bit ,
@Mensaje varchar (500) output)
as
begin 
  set @Resultado = 0 
  if not exists (select * from CATEGORIA WHERE Descripcion = @Descripcion)
  BEGIN
   insert into CATEGORIA(Descripcion,Estado) values (@Descripcion,@Estado)
   set @Resultado = SCOPE_IDENTITY()

   end
   else
    set @Mensaje = 'No se puede repetir la descripcion de una categoria'
end
GO
/****** Object:  StoredProcedure [dbo].[SP_RegistrarCliente]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_RegistrarCliente](
@NumeroDocumento varchar (50),
@NombreCompleto varchar (50),
@Correo varchar (50),
@Telefono varchar (50),
@Estado bit,
@Resultado int output,
@Mensaje varchar (500) output
) as
begin
     set @Resultado = 0
	 declare @IDPERSONA INT
	 if not exists (select * from CLIENTE WHERE NumeroDocumento = @NumeroDocumento)

	 begin

	 insert into CLIENTE (NumeroDocumento,NombreCompleto,Correo,Telefono,Estado)VALUES 
	 (@NumeroDocumento,@NombreCompleto,@Correo,@Telefono,@Estado)


	 SET @Resultado = SCOPE_IDENTITY()

	 END

	 ELSE 
	     SET @Mensaje ='El Numero de Documento de usuario ya existe'

end
GO
/****** Object:  StoredProcedure [dbo].[SP_RegistrarCompra]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_RegistrarCompra] (
@IdUsuario int ,
@IdProveedor int ,
@TipoDocumento varchar(500),
@NumeroDocumento varchar(500),
@MontoTotal decimal(18,2),
@DetalleCompra [EDetalle_Compra] readonly,
@Resultado bit output,
@Mensaje varchar (500) output
)
as
   begin
        begin try
		         declare @IdCompra int = 0
				 set @Resultado = 1
				 set @Mensaje = ''
		begin transaction registro

		insert into  COMPRA (IdUsuario,IdProveedor,TipoDocumento,NumeroDocumento,MontoTotal)
		VALUES(@IdUsuario,@IdProveedor,@TipoDocumento,@NumeroDocumento,@MontoTotal)

		set @IdCompra = SCOPE_IDENTITY()

		insert into detalle_COMPRA (IdCompra,IdProducto,PrecioCompra,PrecioVenta,Cantidad,MnontoTotal)
		SELECT @IdCompra,IdProducto,PrecioCompra,PrecioVenta,Cantidad,MontoTotal from @DetalleCompra


		update p set p.Stock = p.Stock + dc.Cantidad,
		p.PrecioCompra = dc.PrecioCompra,
		p.PrecioVenta = dc.PrecioVenta
		from
		PRODUCTO p
		inner join @DetalleCompra dc on dc.IdProducto = p.IdProducto


		commit transaction registro

		end try
		begin catch

		set @Resultado = 0
		set @Mensaje = ERROR_MESSAGE()

		rollback transaction registro
		
		end catch

end
GO
/****** Object:  StoredProcedure [dbo].[SP_RegistrarProducto]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_RegistrarProducto](
@Codigo varchar (20),
@Nombre varchar (30),
@Descripcion varchar (30),
@IdCategoria int ,
@Stock int ,
@PrecioVenta DECIMAL(10, 3), -- Agregar el parámetro PrecioVenta
@FechaVencimiento datetime,
@Estado bit,
@Resultado int output,
@Mensaje varchar(500) output
)
as
begin
     set @Resultado = 0
	 set @Mensaje = ''
	 if not exists (select * from PRODUCTO WHERE Codigo = @Codigo)

	 begin
           insert into PRODUCTO(Codigo,Nombre,Descripcion,IdCategoria,Stock,PrecioVenta,FechaVencimiento,Estado) values (@Codigo,@Nombre,@Descripcion,@IdCategoria,@Stock,@PrecioVenta,@FechaVencimiento,@Estado)

		   seT @Resultado = SCOPE_IDENTITY()

		   end
		   else
		   begin
		    set @Mensaje = 'Ya existe un producto con el mismo codigo'
         end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_RegistrarProveedor]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_RegistrarProveedor](
@Documento varchar (50),
@RazonSocial varchar (50),
@Correo varchar (50),
@Telefono varchar (50),
@Estado bit ,
@Resultado int output,
@Mensaje varchar (500) output
)as

begin
     set @Resultado =0 
	 declare @IDPERSONA int
	 if not exists (select * from PROVEEDOR where Documento =@Documento)
	 begin
        
		insert into PROVEEDOR (Documento,RazonSocial,Correo,Telefono,Estado) values
		(@Documento,@RazonSocial,@Correo,@Telefono,@Estado)

		set @Resultado = SCOPE_IDENTITY()

	end
	   else
	       set @Mensaje = 'El numero de documento ya existe'

	end
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRARUSUARIO]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_REGISTRARUSUARIO](

@Documento varchar (50),
@NombreCompleto varchar (100),
@Correo varchar (100),
@Clave varchar (100),
@IdRol int ,
@Estado bit,
@IdUsuarioResultado int output,
@Mensaje varchar  (500) output 
)
as begin

set @IdUsuarioResultado = 0
set @Mensaje = ''

if not exists (select * from USUARIO where Documento = @Documento)
begin 
insert into  USUARIO (Documento,NombreCompleto,Correo,Clave,idRol,Estado)values
(@Documento,@NombreCompleto,@Correo,@Clave,@IdRol,@Estado)


    set @IdUsuarioResultado = SCOPE_IDENTITY()
	
end
else 
    set @Mensaje = 'NO SE PUEDE REPETIR EL DOCUMENTO PARA MAS DE UN USUARIO'

end
GO
/****** Object:  StoredProcedure [dbo].[SP_RegistrarVenta]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_RegistrarVenta](
@IdUsuario int ,
@TipoDocumento varchar(500),
@NumeroDocumento varchar(500),
@DocumentoCliente varchar(500),
@NombreCliente varchar (500),
@MontoPago decimal(18,2),
@MontoCambio decimal(18,2),
@MontoTotal decimal(18,2),
@DetalleVenta [EDetalle_Venta] readonly,
@Resultado bit output,
@Mensaje varchar (500) output
)
as
   begin
        begin try
		         declare @Idventa int = 0
				 set @Resultado = 1
				 set @Mensaje = ''
		begin transaction registro

		insert into  VENTA(IdUsuario,TipoDocumento,NumeroDocumento,NombreCliente,DocumentoCliente,MontoPago,MontoCambio,MontoTotal)
		
		VALUES(@IdUsuario,@TipoDocumento,@NumeroDocumento,@NombreCliente,@DocumentoCliente,@MontoPago,@MontoCambio,@MontoTotal)

		set @Idventa = SCOPE_IDENTITY()

		insert into Detalle_Venta (IdVenta,IdProducto,PrecioVenta,Cantidad,SubTotal)
		SELECT @IdVenta,IdProducto,PrecioVenta,Cantidad,SubTotal from @DetalleVenta


		commit transaction registro

		end try
		begin catch

		set @Resultado = 0
		set @Mensaje = ERROR_MESSAGE()

		rollback transaction registro
		
		end catch

end
GO
/****** Object:  StoredProcedure [dbo].[SP_ReporteCompras]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_ReporteCompras](
@fechainicio date,
@fechafin date,
@idproveedor int
)
as 
begin
 set DATEFORMAT dmy;
 select 
CONVERT(char(10),c.FechaRegistro,103) as [Fecharegistro],
c.TipoDocumento,c.NumeroDocumento, c.MontoTotal,
u.NombreCompleto as [Usuarioregistro],
pr.Documento as[DocumentoProveedor], pr.RazonSocial,
p.Codigo as[CodigoProducto],p.Nombre as [NombreProducto], ca.Descripcion as [Categoria],
dc.PrecioCompra, dc.PrecioVenta, dc.Cantidad, dc.MnontoTotal as[SubTotal]

from COMPRA c 
inner join USUARIO u on u.IdUsuario = c.IdUsuario
inner join PROVEEDOR pr on pr.IdProveedor = c.IdProveedor
inner join detalle_COMPRA dc on dc.IdCompra = c.IdCompra
inner join PRODUCTO p on p.IdProducto = dc.IdProducto
INNER JOIN CATEGORIA ca ON CA.IdCategoria = p.IdCategoria
where Convert(date,c.FechaRegistro, 103 ) between @fechainicio and @fechafin
and pr.IdProveedor = iif (@idproveedor = 0, pr.IdProveedor,@idproveedor)

end
GO
/****** Object:  StoredProcedure [dbo].[SP_ReporteVentas]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_ReporteVentas](
@fechainicio date,
@fechafin date
)
as 
begin
 set DATEFORMAT dmy;
 select 
CONVERT(char(10),v.FechaVenta,103) as [Fecharegistro],
v.TipoDocumento, v.NumeroDocumento, v.MontoTotal,
u.NombreCompleto as [Usuarioregistro],
v.DocumentoCliente, v.NombreCliente,
p.Codigo as[CodigoProducto],p.Nombre as [NombreProducto], ca.Descripcion as [Categoria],
dv.PrecioVenta, dv.Cantidad, dv.SubTotal

from VENTA v
inner join USUARIO u on u.IdUsuario = v.IdUsuario
inner join DETALLE_VENTA dv on dv.IdVenta = v.IdVenta
inner join PRODUCTO p on p.IdProducto = dv.IdProducto
INNER JOIN CATEGORIA ca ON CA.IdCategoria = p.IdCategoria
where Convert(date,v.FechaVenta,103 ) between @fechainicio and @fechafin
end 
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarUsuario]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ValidarUsuario]
    @Documento NVARCHAR(50),
    @Clave NVARCHAR(255)
	
AS
BEGIN
    SET NOCOUNT ON;

    -- Buscar usuario con documento y clave coincidentes
    SELECT IdUsuario, NombreCompleto, IdRol
    FROM Usuario
    WHERE Documento = @Documento AND Clave = @Clave;
END;
GO
/****** Object:  StoredProcedure [dbo].[spbuscar_categoria]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--procedimiento buscar nombre

Create proc [dbo].[spbuscar_categoria]
@textobuscar varchar (50)
as
select * from CATEGORIA
where Descripcion like @textobuscar + '%' --Alt +39
GO
/****** Object:  StoredProcedure [dbo].[speditar_categoria]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--procedimiento Editar

create proc [dbo].[speditar_categoria]
@idCategoria int  output,
@Descripcion varchar (250),
@Estado bit ,
@FechaRegistro datetime ,
@Nombre varchar (50)
as
update CATEGORIA set Nombre=@Nombre,
Descripcion=@Descripcion,
Estado=@Estado
where IdCategoria=@idCategoria
GO
/****** Object:  StoredProcedure [dbo].[speliminar_categoria]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--procedimiento Eliminar 

create proc [dbo].[speliminar_categoria]
@idCategoria int 
as
delete from CATEGORIA
where IdCategoria=@idCategoria

GO
/****** Object:  StoredProcedure [dbo].[spinsertar_categoria]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--procedimiento Insertar

create proc [dbo].[spinsertar_categoria]
@idCategoria int  output,
@Descripcion varchar (250),
@Estado bit ,
@FechaRegistro datetime ,
@Nombre varchar (50)
as
Insert into CATEGORIA (Descripcion,Nombre)
values (@Descripcion,@Nombre)
GO
/****** Object:  StoredProcedure [dbo].[spmostra_categoria]    Script Date: 2/6/2025 16:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--procedimiento mostrar


Create proc [dbo].[spmostra_categoria]
as
select top 200 * from CATEGORIA
ORDER BY IdCategoria desc

GO
