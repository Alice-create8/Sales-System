# 🛒 Sistema de Ventas



<p align="center">
  <img src="media/demo2.gif" width="600" alt="Vista previa del sistema" />
</p>




Este es un sistema de ventas de escritorio desarrollado en **C# con .NET**, utilizando arquitectura en capas y bases de datos relacionales. Permite gestionar productos, stock, clientes, ventas y compras, ideal para negocios medianos con un alto volumen de productos.

> 🔧 Este sistema es una base funcional que puede ampliarse o personalizarse según las necesidades del negocio. Ideal para quienes desean practicar, mejorar o adaptar un sistema real de gestión de ventas.

> ⚠️ **Nota:** Este repositorio no incluye archivos binarios de base de datos (.bak o .mdf) para evitar problemas de compatibilidad. Sin embargo, se incluye un **script SQL** en la carpeta `DB` para que puedas generar y poblar la base de datos manualmente.

---

##  Características principales

- Gestión de productos y categorías  
- Control de stock y fechas de vencimiento  
- Módulo de compras y ventas  
- Gestión de clientes y proveedores  
- Reportes y paneles administrativos  
- Gestión de usuarios con distintos roles

---

##  Credenciales de acceso

Este sistema no incluye credenciales predeterminadas. Para poder probarlo, debes crear un usuario en la base de datos. Aquí te dejo un ejemplo de inserción manual desde SQL Server:

INSERT INTO Usuario (Documento, NombreCompleto, Clave, Estado, IdRol)
VALUES ('101010', 'Admin Prueba', '123456', 1, 1);

---

##  Tecnologías utilizadas

- Lenguaje: **C# (.NET Framework)**  
- Arquitectura: **Capas (Presentación, Negocio, Datos, Entidad)**  
- Base de datos: **SQL Server**  
- IDE: **Visual Studio 2022**

---

##  Estructura del proyecto

El sistema está organizado con una arquitectura en capas para mejorar la mantenibilidad y escalabilidad:

- `CapaPresentacion/`: Interfaz gráfica del sistema (Windows Forms)  
- `CapaNegocio/`: Lógica de negocio y validaciones  
- `CapaDatos/`: Acceso a la base de datos (CRUD)  
- `CapaEntidad/`: Definición de entidades (modelos)  
- `DB/`: Script SQL para crear y poblar la base de datos

---

##  Configuración inicial

1. Clona el Repositorio:
   ```bash
   git clone https://github.com/Alice-create8/Sales-System.git
   
2. Crea la base de datos en SQL Server:
   Abre SQL Server Management Studio (SSMS).
   Ejecuta el script DB/dbVentas.sql para crear la base de datos dbVentas y sus tablas.
   Ingresa manualmente algunos datos (productos, usuarios, etc.) para poder probar el sistema

3. Configura la cadena de conexión:
   Abre el archivo App.config en el proyecto CapaPresentacion.
   Edita el valor de Data Source en la cadena de conexión para que coincida con tu instancia de SQL Server, por ejemplo:
   
   <connectionStrings>
  <add name="cadena_conexion"
       connectionString="Data Source=TU_SERVIDOR\SQLEXPRESS;Initial Catalog=dbVentas;Integrated Security=True;"
       providerName="System.Data.SqlClient" />
  </connectionStrings>
  
4. Ejecuta el sistema desde Visual Studio(establece CapaPresentacion como proyecto de inicio):
   Haz click derecho sobre la CapaPresentacion y elige la opcion: Establecer como proyecto de inicio
   
5. Ejecuta el sistema presiona f5 o haz click en "Iniciar"

   
   
