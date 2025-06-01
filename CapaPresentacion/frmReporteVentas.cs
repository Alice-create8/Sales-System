using CapaEntidad;
using CapaNegocio;
using CapaPresentacion.Utilidades;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using LicenseContext = OfficeOpenXml.LicenseContext;

namespace CapaPresentacion
{
    public partial class frmReporteVentas : Form
    {
        public frmReporteVentas()
        {
            InitializeComponent();
        }

        private void frmReporteVentas_Load(object sender, EventArgs e)
        {
            foreach (DataGridViewColumn columna in dgvdata.Columns)
            {
                cbobusqueda1.Items.Add(new OpcionCombo() { Valor = columna.Name, Texto = columna.HeaderText });

            }
            cbobusqueda1.DisplayMember = "Texto";
            cbobusqueda1.ValueMember = "Valor";
            cbobusqueda1.SelectedIndex = 0;
        }

        private void cbobuscar_Click(object sender, EventArgs e)
        {
            DateTime fechainicio = txtfechainicio.Value.Date;
            DateTime fechafin = txtfechafin.Value.Date;

            List<ReporteVenta> lista = new CN_Reporte().Ventas(fechainicio, fechafin);

            dgvdata.Rows.Clear();

            foreach(ReporteVenta rv in lista)
            {
                dgvdata.Rows.Add(new object[] {
                    rv.FechaRegistro,
                    rv.TipoDocumento,
                    rv.NumeroDocumento,
                    rv.MontoTotal,
                    rv.UsuarioRegistro,
                    rv.DocumentoCliente,
                    rv.NombreCliente,
                    rv.CodigoProducto,
                    rv.NombreProducto,
                    rv.Categoria,
                    rv.PrecioVenta,
                    rv.cantidad,
                    rv.SubTotal

                });
            }
        }

        private void Btnbuscar_Click(object sender, EventArgs e)
        {
            string columnaFiltro = ((OpcionCombo)cbobusqueda1.SelectedItem).Valor.ToString();

            if (dgvdata.Rows.Count > 0)
            {
                foreach (DataGridViewRow row in dgvdata.Rows)
                {
                    if (row.Cells[columnaFiltro].Value.ToString().Trim().ToUpper().Contains(txtbusqueda.Text.Trim().ToUpper()))

                        row.Visible = true;
                    else

                        row.Visible = false;

                }
            }
        }

        private void iconButton1_Click(object sender, EventArgs e)
        {
            txtbusqueda.Text = "";
            foreach (DataGridViewRow row in dgvdata.Rows)
            {
                row.Visible = true;
            }
        }

        private void btnexcel_Click(object sender, EventArgs e)
        {
            if (dgvdata.Rows.Count < 1)
            {
                MessageBox.Show("No hay registros para exportar", "Mensaje", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            SaveFileDialog savefile = new SaveFileDialog();
            savefile.FileName = string.Format("ReporteVentas_{0}.xlsx", DateTime.Now.ToString("ddMMyyyyHHmmss"));
            savefile.Filter = "Excel Files | *.xlsx";

            if (savefile.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Establecer el contexto de la licencia

                    using (ExcelPackage pck = new ExcelPackage())
                    {
                        ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Informe");

                        // Agregar encabezados
                        for (int j = 0; j < dgvdata.Columns.Count; j++)
                        {
                            ws.Cells[1, j + 1].Value = dgvdata.Columns[j].HeaderText;
                        }

                        // Agregar filas
                        for (int i = 0; i < dgvdata.Rows.Count; i++)
                        {
                            for (int j = 0; j < dgvdata.Columns.Count; j++)
                            {
                                ws.Cells[i + 2, j + 1].Value = dgvdata.Rows[i].Cells[j].Value?.ToString();
                            }
                        }

                        // Ajustar columnas automáticamente
                        ws.Cells[ws.Dimension.Address].AutoFitColumns();

                        // Guardar el archivo de Excel
                        FileInfo fi = new FileInfo(savefile.FileName);
                        pck.SaveAs(fi);
                    }
                    MessageBox.Show("Reporte Generado", "Mensaje", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error al generar reporte: " + ex.Message, "Mensaje", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
        }
    }
}
