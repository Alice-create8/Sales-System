using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CN_Producto
    {
        private CD_Producto objcd_Producto = new CD_Producto();

        public List<Producto> Listar()
        {
            return objcd_Producto.Listar();

        }

        

        public int Registrar(Producto obj, out string Mensaje)
        {
            Mensaje = string.Empty;
            // Verificar si la categoría es null antes de acceder a su descripción
            if  (obj.oCategoria != null && !string.IsNullOrEmpty(obj.oCategoria.Descripcion))
               
            {

                // Determinamos si el producto requiere fecha de vencimiento
                obj.RequiereFechaVencimiento = CategoriaRequiereFechaVencimiento(obj.oCategoria.Descripcion);

                Console.WriteLine($"Categoría: {obj.oCategoria.Descripcion}, Requiere Fecha: {obj.RequiereFechaVencimiento}");
            }
            else
            {
                obj.RequiereFechaVencimiento = false; // Si no hay categoría, asumimos que no requiere fecha de vencimiento
               
            }

            Console.WriteLine($"Fecha Vencimiento Inicial: {obj.FechaVencimiento}");
            if (string.IsNullOrEmpty(obj.Codigo))
            {
                Mensaje += "Es necesario el código del Producto\n";
            }
            if (string.IsNullOrEmpty(obj.Nombre))
            {
                Mensaje += "Es necesario el nombre del Producto\n";
            }
            if (string.IsNullOrEmpty(obj.Descripcion))
            {
                Mensaje += "Es necesaria la descripción del Producto\n";
            }
            if (obj.RequiereFechaVencimiento) 
            {
                if (!obj.FechaVencimiento.HasValue )
                {
                    Mensaje += "Es necesaria la fecha de vencimiento del Producto\n";
                }
                  else if (obj.FechaVencimiento <= DateTime.Now )
                  {
                        Mensaje += "La fecha de vencimiento del producto debe ser una fecha futura\n";
                  }
           
            }
            else
            {
                obj.FechaVencimiento = null;
            }

            // Mensaje de depuración después de la validación
            //Console.WriteLine($"Fecha Vencimiento Validada: {obj.FechaVencimiento}");



            if (!string.IsNullOrEmpty(Mensaje))
            {
                return 0;
            }
            else
            {
                return objcd_Producto.Registrar(obj, out Mensaje);
            }
        }
        public bool CategoriaRequiereFechaVencimiento(string Categoria)
        {
            // Lista de categorías que no requieren fecha de vencimiento
            var categoriasSinFechaVencimiento = new List<string> { "Merceria", "Regaleria", "Libreria" };

            if (string.IsNullOrEmpty(Categoria))
            {
                return false;
            }

            return !categoriasSinFechaVencimiento.Contains(Categoria);

        }


        public bool Editar(Producto obj, out string Mensaje)
        {
            
            Mensaje = string.Empty;
            // Verificar si la categoría es null antes de acceder a su descripción
            if (obj.oCategoria != null)
            {
                obj.RequiereFechaVencimiento = CategoriaRequiereFechaVencimiento(obj.oCategoria.Descripcion);
            }
            else
            {
                obj.RequiereFechaVencimiento = false; // Si no hay categoría, asumimos que no requiere fecha de vencimiento
            }

            if (string.IsNullOrEmpty(obj.Codigo))
            {
                Mensaje += "Es necesario el código del Producto\n";
            }
            if (string.IsNullOrEmpty(obj.Nombre))
            {
                Mensaje += "Es necesario el nombre del Producto\n";
            }
            if (string.IsNullOrEmpty(obj.Descripcion))
            {
                Mensaje += "Es necesaria la descripción del Producto\n";
            }
            if (obj.RequiereFechaVencimiento == true)
            {
                if (obj.FechaVencimiento == DateTime.MinValue)
                {
                    Mensaje += "Es necesaria la fecha de vencimiento del Producto\n";
                }
                else if (obj.FechaVencimiento <= DateTime.Now)
                {
                    Mensaje += "La fecha de vencimiento del producto debe ser una fecha futura\n";
                }
            }

            if (!string.IsNullOrEmpty(Mensaje))
            {
                return false;
            }
            else
            {
                return objcd_Producto.Editar(obj, out Mensaje);
            }

        }
        public bool Eliminar(Producto obj, out string Mensaje)
        {


            return objcd_Producto.Eliminar(obj, out Mensaje);

        }
       
    }
}
