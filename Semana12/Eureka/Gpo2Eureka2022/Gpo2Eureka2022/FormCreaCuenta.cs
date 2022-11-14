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
        public FormCreaCuenta()
        {
            InitializeComponent();
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
            string empleado = "0006";
            // Proceso
            CuentaService service = new CuentaService();
            String cuenta = service.CrearCuenta(cliente, moneda, importe, clave,empleado);
            // Fin
            string mensaje = cuenta + " | " + service.Estado + " | " + service.Mensaje;
            MessageBox.Show("Resultado: " + mensaje);
        }
    }
}
