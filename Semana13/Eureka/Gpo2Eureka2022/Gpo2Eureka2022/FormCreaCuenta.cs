using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using CapaService;

namespace Gpo2Eureka2022
{
    public partial class FormCreaCuenta : Form
    {

        private static FormCreaCuenta instancia = null;

        public static FormCreaCuenta GetInstance()
        {
            if (((instancia == null) || (instancia.IsDisposed == true)))
            {
                instancia = new FormCreaCuenta();
            }
            instancia.BringToFront();
            return instancia;
        }


        private FormCreaCuenta()
        {
            InitializeComponent();
            string dato = Cache.UserLoginCache.Nombre + ", " + Cache.UserLoginCache.Paterno;
            txtEmpleado.Text = dato;
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }

        private void btnProcesar_Click(object sender, EventArgs e)
        {
            // Datos
            string cliente = txtCliente.Text;
            string moneda = txtMoneda.Text;
            double importe = Double.Parse(txtImporte.Text);
            string clave = txtClave.Text;
            string empleado = Cache.UserLoginCache.Codigo;
            // Proceso
            CuentaService service = new CuentaService();
            String cuenta = service.CrearCuenta(cliente, moneda, importe, clave,empleado);
            // Fin
            string mensaje = cuenta + " | " + service.Estado + " | " + service.Mensaje;
            MessageBox.Show("Resultado: " + mensaje);
        }

        private void FormCreaCuenta_Load(object sender, EventArgs e)
        {

        }
    }
}
