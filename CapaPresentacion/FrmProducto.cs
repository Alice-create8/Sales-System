using CapaEntidad;
using CapaNegocio;
using CapaPresentacion.Utilidades;
using ClosedXML.Excel;
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
    public partial class FrmProducto : Form
    {
        private CN_Producto _productoNegocio = new CN_Producto();

        public FrmProducto()
        {
            InitializeComponent();
        }

        private void FrmProducto_Load(object sender, EventArgs e)
        {
            cboestado.Items.Add(new OpcionCombo() { Valor = 1, Texto = "ACTIVO" });
            cboestado.Items.Add(new OpcionCombo() { Valor = 0, Texto = "NO ACTIVO" });
            cboestado.DisplayMember = "Texto";
            cboestado.ValueMember = "Valor";
            cboestado.SelectedIndex = 0;



            List<Categoria> listaCategoria = new CN_Categoria().Listar();

            foreach (Categoria item in listaCategoria)
            {
                cbocategoria.Items.Add(new OpcionCombo() { Valor = item.IdCategoria, Texto = item.Descripcion });
            }
            cbocategoria.DisplayMember = "Texto";
            cbocategoria.ValueMember = "Valor";
            cbocategoria.SelectedIndex = 0;

            // Asocia el evento SelectedIndexChanged del ComboBox con su manejador
            cbocategoria.SelectedIndexChanged += cbocategoria_SelectedIndexChanged;

            foreach (DataGridViewColumn columna in dgvdata.Columns)
            {

                if (columna.Visible == true && columna.Name != "btnseleccionar")
                {
                    cbobusqueda1.Items.Add(new OpcionCombo() { Valor = columna.Name, Texto = columna.HeaderText });
                }
            }
            cbobusqueda1.DisplayMember = "Texto";
            cbobusqueda1.ValueMember = "Valor";
            cbobusqueda1.SelectedIndex = 0;


            //mostrar todos los productos 
            List<Producto> listaProductos = new CN_Producto().Listar();

            foreach (Producto item in listaProductos)
            {

                // Verificar si la categoría requiere fecha de vencimiento
                string fechaVencimiento = item.FechaVencimiento.HasValue
                ? item.FechaVencimiento.Value.ToString("yyyy/MM/dd")
                : "N/A";
                dgvdata.Rows.Add(new object[] 
                {
                    "",
                    item.IdProducto,
                    item.Codigo,
                    item.Nombre,
                    item.Descripcion,
                    item.oCategoria.IdCategoria,
                    item.oCategoria.Descripcion,
                    item.stock,
                    item.PrecioCompra,
                    item.PrecioVenta,
                    FechaVencimiento,
                    item.Estado == true ? 1 : 0,
                    item.Estado == true ? "ACTIVO": "NO ACTIVO"


                });
            }
        }

        private void Btnguardar_Click(object sender, EventArgs e)
        {
            String mensaje = string.Empty;
            // Obtener el nombre de la categoría seleccionada
            string Descripcion = ((OpcionCombo)cbocategoria.SelectedItem).Texto;

            DateTime? fechaVencimiento = Descripcion == "Merceria" || Descripcion == "Regaleria" || Descripcion == "Libreria" ? (DateTime?)null : dtfechavencimiento.Value;


            // Validar la conversión de los valores numéricos
            //int idProducto;
            //bool idConversionExitosa = int.TryParse(txtid.Text, out idProducto);

            //int stock;
            //bool stockConversionExitosa = int.TryParse(txtstock.Text, out stock);

            //decimal precioVenta;
            //bool precioVentaConversionExitosa = decimal.TryParse(txtprecioventa.Text, out precioVenta);

            //// Verificar que todas las conversiones sean exitosas
            //if (!idConversionExitosa)
            //{
            //    mensaje += "El ID del producto no tiene un formato correcto.\n";
            //}
            //if (!stockConversionExitosa)
            //{
            //    mensaje += "El stock del producto no tiene un formato correcto.\n";
            //}
            //if (!precioVentaConversionExitosa)
            //{
            //    mensaje += "El precio de venta no tiene un formato correcto.\n";
            //}

            //if (!string.IsNullOrEmpty(mensaje))
            //{
            //    MessageBox.Show(mensaje);
            //    return;
            //}
            Producto obj = new Producto()
            {
                IdProducto = Convert.ToInt32(txtid.Text),
                Codigo = txtcodigo.Text,
                Nombre = txtnombre.Text,
                Descripcion = txtdescripcion.Text,
                oCategoria = new Categoria() { IdCategoria = Convert.ToInt32(((OpcionCombo)cbocategoria.SelectedItem).Valor) },
                stock = Convert.ToInt32(txtstock.Text),
                PrecioVenta = Convert.ToDecimal(txtprecioventa.Text),
                // Condición para asignar la FechaVencimiento
                FechaVencimiento = fechaVencimiento,
               
                Estado = Convert.ToInt32(((OpcionCombo)cboestado.SelectedItem).Valor) == 1 ? true : false

            };


            if (obj.IdProducto == 0)
            {
                int idgenerado = new CN_Producto().Registrar(obj, out mensaje);

                Console.WriteLine($"Resultado del Registro: {idgenerado}, Mensaje: {mensaje}");
                if (idgenerado != 0)
                {
                    dgvdata.Rows.Add(new object[] {
                        "",
                        idgenerado,
                        txtcodigo.Text,
                        txtnombre.Text,
                        txtdescripcion.Text,
                        ((OpcionCombo)cbocategoria.SelectedItem).Valor.ToString(),
                        ((OpcionCombo)cbocategoria.SelectedItem).Texto.ToString(),
                        txtstock.Text,
                        "0,00",
                        txtprecioventa.Text,
                         obj.FechaVencimiento.HasValue ? obj.FechaVencimiento.Value.ToString("dd/MM/yyyy") : "N/A",
                        ((OpcionCombo)cboestado.SelectedItem).Valor.ToString(),
                        ((OpcionCombo)cboestado.SelectedItem).Texto.ToString()
                    });

                    Limpiar();

                }
                else
                {
                    MessageBox.Show(mensaje);
                }
            }
            else
            {
                bool resultado = new CN_Producto().Editar(obj, out mensaje);

                if (resultado)
                {
                    DataGridViewRow row = dgvdata.Rows[Convert.ToInt32(txtindice.Text)];
                    row.Cells["Id"].Value = txtid.Text;
                    row.Cells["Codigo"].Value = txtcodigo.Text;
                    row.Cells["Nombre"].Value = txtnombre.Text;
                    row.Cells["Descripcion"].Value = txtdescripcion.Text;
                    row.Cells["IdCategoria"].Value = ((OpcionCombo)cbocategoria.SelectedItem).Valor.ToString();
                    row.Cells["Categoria"].Value = ((OpcionCombo)cbocategoria.SelectedItem).Texto.ToString();
                    row.Cells["Stock"].Value = txtstock.Text;
                    row.Cells["PrecioVenta"].Value = txtprecioventa.Text;
                    row.Cells["FechaVencimiento"].Value= dtfechavencimiento.Value.ToString("yyyy/MM/dd "); ;
                    row.Cells["EstadoValor"].Value = ((OpcionCombo)cboestado.SelectedItem).Valor.ToString();
                    row.Cells["Estado"].Value = ((OpcionCombo)cboestado.SelectedItem).Texto.ToString();

                    Limpiar();
                }
                else
                {
                    MessageBox.Show(mensaje);
                }

            }
        }


        private void Limpiar()
        {
            txtindice.Text = "-1";
            txtid.Text = "0";
            txtcodigo.Text = "";
            txtnombre.Text = "";
            txtdescripcion.Text = "";
            cbocategoria.SelectedIndex = 0;
            txtstock.Text = "";
            txtprecioventa.Text = "";

            cboestado.SelectedIndex = 0;
            

            txtcodigo.Select();
        }

        private void dgvdata_CellPainting(object sender, DataGridViewCellPaintingEventArgs e)
        {
            if (e.RowIndex < 0)
                return;

            if (e.ColumnIndex == 0)
            {
                e.Paint(e.CellBounds, DataGridViewPaintParts.All);


                var w = Properties.Resources.check.Width;
                var h = Properties.Resources.check.Height;
                var x = e.CellBounds.Left + (e.CellBounds.Width - w) / 2;
                var y = e.CellBounds.Top + (e.CellBounds.Height - h) / 2;


                e.Graphics.DrawImage(Properties.Resources.check, new Rectangle(x, y, w, h));
                e.Handled = true;



            }
        }

        private void dgvdata_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvdata.Columns[e.ColumnIndex].Name == "btnseleccionar")
            {

                int indice = e.RowIndex;


                if (indice >= 0)

                {
                    txtindice.Text = indice.ToString();
                    txtid.Text = dgvdata.Rows[indice].Cells["Id"].Value.ToString();
                    txtcodigo.Text = dgvdata.Rows[indice].Cells["Codigo"].Value.ToString();
                    txtnombre.Text = dgvdata.Rows[indice].Cells["nombre"].Value.ToString();
                    txtdescripcion.Text = dgvdata.Rows[indice].Cells["Descripcion"].Value.ToString();
                    txtstock.Text = dgvdata.Rows[indice].Cells["Stock"].Value.ToString();
                    txtprecioventa.Text = dgvdata.Rows[indice].Cells["PrecioVenta"].Value.ToString();


                    foreach (OpcionCombo oc in cbocategoria.Items)
                    {
                        if (Convert.ToInt32(oc.Valor) == Convert.ToInt32(dgvdata.Rows[indice].Cells["idCategoria"].Value))
                        {
                            int indice_combo = cbocategoria.Items.IndexOf(oc);
                            cbocategoria.SelectedIndex = indice_combo;
                            break;
                        }
                    }
                    foreach (OpcionCombo oc in cboestado.Items)
                    {
                        if (Convert.ToInt32(oc.Valor) == Convert.ToInt32(dgvdata.Rows[indice].Cells["EstadoValor"].Value))
                        {
                            int indice_combo = cboestado.Items.IndexOf(oc);
                            cboestado.SelectedIndex = indice_combo;
                            break;
                        }
                    }


                }
            }
        }

        private void btneliminar_Click(object sender, EventArgs e)
        {
            if (Convert.ToInt32(txtid.Text) != 0)
            {
                if (MessageBox.Show("¿Desea eliminar el Producto", "Mensaje", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {

                    string mensaje = string.Empty;
                    Producto obj = new Producto()
                    {
                        IdProducto = Convert.ToInt32(txtid.Text),



                    };

                    bool respuesta = new CN_Producto().Eliminar(obj, out mensaje);

                    if (respuesta)
                    {
                        dgvdata.Rows.RemoveAt(Convert.ToInt32(txtindice.Text));
                        Limpiar();
                    }
                    else
                    {
                        MessageBox.Show(mensaje, "Mensaje", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    }

                }


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

        private void btnlimpiarbuscador_Click(object sender, EventArgs e)
        {
            txtbusqueda.Text = "";
            foreach (DataGridViewRow row in dgvdata.Rows)
            {
                row.Visible = true;
            }
        }

        private void btnlimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        private void dtfechavencimiento_ValueChanged(object sender, EventArgs e)
        {
            DateTime FechaVencimiento = dtfechavencimiento.Value;

            
        }

        private void btnexcel_Click(object sender, EventArgs e)
        {
            if (dgvdata.Rows.Count < 1)
            {
                MessageBox.Show("No hay datos para exportar", "Mensaje", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            SaveFileDialog savefile = new SaveFileDialog();
            savefile.FileName = string.Format("ReporteProductos_{0}.xlsx", DateTime.Now.ToString("ddMMyyyyHHmmss"));
            savefile.Filter = "Excel Files | *.xlsx";

            if (savefile.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    // Configurar la licencia de EPPlus
                    ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

                    DataTable dt = new DataTable();

                    // Agregar encabezados
                    foreach (DataGridViewColumn columna in dgvdata.Columns)
                    {
                        if (columna is DataGridViewButtonColumn || string.IsNullOrWhiteSpace(columna.HeaderText) || !columna.Visible)
                        {
                            continue;
                        }
                        dt.Columns.Add(columna.HeaderText, typeof(string));
                    }

                    // Agregar filas
                    foreach (DataGridViewRow row in dgvdata.Rows)
                    {
                        if (row.Visible)
                        {
                            DataRow dataRow = dt.NewRow();
                            foreach (DataGridViewColumn columna in dgvdata.Columns)
                            {
                                if (columna is DataGridViewButtonColumn || !columna.Visible)
                                {
                                    continue;
                                }

                                if (!string.IsNullOrWhiteSpace(columna.HeaderText))
                                {
                                    dataRow[columna.HeaderText] = row.Cells[columna.Index].Value != null ? row.Cells[columna.Index].Value.ToString() : string.Empty;
                                }
                            }
                            dt.Rows.Add(dataRow);
                        }
                    }

                    // Crear y guardar el archivo de Excel usando EPPlus
                    using (ExcelPackage pck = new ExcelPackage())
                    {
                        ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Informe");
                        ws.Cells["A1"].LoadFromDataTable(dt, true);
                        ws.Cells.AutoFitColumns();

                        // Guardar el archivo
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

        private void btnnotificaciones_Click(object sender, EventArgs e)
        {
            List<string> notificaciones = new List<string>();
            int diasProximosAVencer = 30; // Puedes ajustar este valor según tus necesidades
            int stockMinimo = 5; // Puedes ajustar este valor según tus necesidades

            // Recorremos cada producto en el DataGridView
            foreach (DataGridViewRow row in dgvdata.Rows)
            {
                if (row.Cells["FechaVencimiento"].Value != null)
                {
                    //DateTime fechaVencimiento = Convert.ToDateTime(row.Cells["FechaVencimiento"].Value);
                    //int stock = Convert.ToInt32(row.Cells["Stock"].Value);

                    //// Verificamos si el producto está próximo a vencer
                    //if ((fechaVencimiento - DateTime.Now).Days <= diasProximosAVencer)
                    //{
                    //    notificaciones.Add($"El producto {row.Cells["Nombre"].Value} con código {row.Cells["Codigo"].Value} está próximo a vencer el {fechaVencimiento.ToShortDateString()}");
                    //}
                    DateTime fechaVencimiento;
                    bool conversionExitosa = DateTime.TryParse(row.Cells["FechaVencimiento"].Value.ToString(), out fechaVencimiento);
                    if (conversionExitosa)
                    {
                        if (row.Cells["Stock"].Value != null && int.TryParse(row.Cells["Stock"].Value.ToString(), out int stock))
                        {
                            // Verificamos si el producto está próximo a vencer
                            if ((fechaVencimiento - DateTime.Now).Days <= diasProximosAVencer)
                            {
                                notificaciones.Add($"El producto {row.Cells["Nombre"].Value} con código {row.Cells["Codigo"].Value} está próximo a vencer el {fechaVencimiento.ToShortDateString()}");
                            }
                            // Verificamos si el producto tiene poco stock
                            if (stock <= stockMinimo)
                            {
                                notificaciones.Add($"El producto {row.Cells["Nombre"].Value} con código {row.Cells["Codigo"].Value} tiene poco stock ({stock} unidades)");
                            }
                        }
                        else
                        {
                            // Manejar el caso en que el stock no es convertible a int o es null
                            Console.WriteLine($"El valor del stock para el producto {row.Cells["Nombre"].Value} no es válido.");
                        }


                    }

                    else
                    {
                        Console.WriteLine($"La conversión de la fecha para el producto {row.Cells["Nombre"].Value} falló.");
                    }

                }
            }

            // Mostramos las notificaciones
            if (notificaciones.Count > 0)
            {
                MessageBox.Show(string.Join(Environment.NewLine, notificaciones), "Notificaciones", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            else
            {
                MessageBox.Show("No hay productos próximos a vencer o con poco stock", "Notificaciones", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void txtprecioventa_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (char.IsDigit(e.KeyChar))
            {
                e.Handled = false;
            }
            else
            {
                if (txtprecioventa.Text.Trim().Length == 0 && e.KeyChar.ToString() == ",")
                {
                    e.Handled = true;
                }
                else
                {
                    if (Char.IsControl(e.KeyChar) || e.KeyChar.ToString() == ",")
                    {
                        e.Handled = false;
                    }
                    else
                    {
                        e.Handled = true;
                    }
                }
            }
        }

        private void cbocategoria_SelectedIndexChanged(object sender, EventArgs e)
        {


            // Obtener el nombre de la categoría seleccionada
            string Descripcion = ((OpcionCombo)cbocategoria.SelectedItem).Texto;

            // Condición para habilitar o deshabilitar el DateTimePicker según la categoría
            if (Descripcion == "Merceria" || Descripcion == "Regaleria" || Descripcion == "Libreria")
            {
                dtfechavencimiento.Enabled = false;
                dtfechavencimiento.Value = DateTime.Now; // Resetea la fecha a hoy si no requiere fecha de vencimiento
            }
            else
            {
                dtfechavencimiento.Enabled = true;
                dtfechavencimiento.Value = DateTime.Now.AddDays(1); // Por defecto una fecha futura si requiere fecha de vencimiento
            }
        }



        
    }
}
