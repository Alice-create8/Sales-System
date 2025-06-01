using CapaDatos;
using CapaEntidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class CN_Reporte
    {

        private CD_Reporte objcd_reporte = new CD_Reporte();

        public List<ReporteCompra> Compras(DateTime fechainicio, DateTime fechafin, int idproveedor)
        {
            return objcd_reporte.Compras( fechainicio, fechafin, idproveedor);
        }

        public List<ReporteVenta> Ventas(DateTime fechainicio, DateTime fechafin)
        {
            return objcd_reporte.Ventas(fechainicio, fechafin);
        }
    }
}
