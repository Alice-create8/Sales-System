using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaNegocio;
using CapaEntidad;

namespace CapaPresentacion
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void Btncancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Btningresar_Click(object sender, EventArgs e)
        {
            try
            {
                // 1️ Validar campos vacíos
                if (string.IsNullOrWhiteSpace(txtdocumento.Text) || string.IsNullOrWhiteSpace(txtclave.Text))
                {
                    MessageBox.Show("Por favor, complete ambos campos.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                // 2️ Validar longitud mínima de clave
                if (txtclave.Text.Length < 4)
                {
                    MessageBox.Show("La contraseña debe tener al menos 4 caracteres.", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                // 3️ Obtener lista de usuarios (solo una vez)
                List<Usuario> listaUsuarios = new CN_Usuario().Listar();

                // 4️ Buscar usuario
                Usuario oUsuario = listaUsuarios
                    .FirstOrDefault(u =>
                        u.Documento.Equals(txtdocumento.Text, StringComparison.OrdinalIgnoreCase) &&
                        u.Clave == txtclave.Text
                    );

                // 5️ Validar resultado
                if (oUsuario != null)
                {
                    Inicio form = new Inicio(oUsuario);
                    form.Show();
                    this.Hide();
                    form.FormClosing += Frm_closing;
                }
                else
                {
                    MessageBox.Show("Usuario o contraseña incorrectos.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtclave.Clear();
                    txtclave.Focus();
                }
            }
            catch (Exception ex)
            {
                // 6️ Manejo de errores
                MessageBox.Show($"Ocurrió un error al intentar iniciar sesión:\n{ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void Frm_closing(object sender, FormClosingEventArgs e)
        {
            // Limpiar los campos al cerrar
            txtdocumento.Clear();
            txtclave.Clear();
            txtdocumento.Focus();
            this.Show();
        }

        private void Txtclave_TextChanged(object sender, EventArgs e)
        {
            // Validación en tiempo real: impedir espacios en la clave
            txtclave.Text = txtclave.Text.Replace(" ", "");
            txtclave.SelectionStart = txtclave.Text.Length;
        }
    }
}
