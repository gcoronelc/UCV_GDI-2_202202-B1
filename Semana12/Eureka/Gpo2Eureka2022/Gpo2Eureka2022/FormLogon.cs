using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using CapaService;
using CapaModel;

namespace Gpo2Eureka2022
{
    public partial class FormLogon : Form
    {
        public FormLogon()
        {
            InitializeComponent();
        }

        private void btnSalir_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnIngresar_Click(object sender, EventArgs e)
        {

            // Datos
            string usuario = txtUsuario.Text;
            string clave = txtClave.Text;

            // Validando vacios
            if (usuario.Trim().Length==0 && clave.Trim().Length==0)
            {
                txtError.Text = "Error, faltan datos.";
                txtError.Visible = true;
                return;
            }

            // Varificando datos 
            LogonService service = new LogonService();
            EmpleadoModel empleado = service.validarUsuario(usuario, clave);
            if (service.Estado == -1)
            {
                txtError.Text = service.Mensaje;
                txtError.Visible = true;
                return;
            }

            // Cargando el formulario principal
            FormMain principal = new FormMain();
            principal.Show();
            this.Hide();

            /*
            Cache.UserLoginCache.Codigo = empleado.Codigo;
            Cache.UserLoginCache.Paterno = empleado.Paterno;
            Cache.UserLoginCache.Materno = empleado.Materno;
            Cache.UserLoginCache.Nombre = empleado.Nombre;
            Cache.UserLoginCache.Usuario = empleado.Usuario;
            */

        }

        
    }
}

