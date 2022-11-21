using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace CapaService
{
    public class ConsultaService : GeneralService
    {

        public DataTable traerMovimientos(string cuenta)
        {
            // Variables
            DataTable data = new DataTable();
            string sql = "select movinumero NROMOVIMIENTO, convert(varchar,movifecha,103) FECHA,"
               + "tiponombre TIPO, moviimporte IMPORTE "
               + "from dbo.v_movimiento where cuencodigo = @cuenta";
            // Mensaje por defecto
            this.Estado = 1;
            this.Mensaje = "Proceso ejecutado correctamente";
            // Proceso general
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    // Preparar el comando
                    con.Open();
                    SqlCommand cmd = new SqlCommand(sql, con);
                    // Agregar el parámetro
                    cmd.Parameters.Add("@cuenta", SqlDbType.VarChar, 10).Value = cuenta;
                    // Ejecutar el comando
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        data.Load(reader);
                    }
                    else
                    {
                        this.Estado = -1;
                        this.Mensaje = "Cuenta no existe.";
                    }
                }
                catch (Exception e)
                {
                    this.Estado = -1;
                    this.Mensaje = e.Message;
                }
            }
            // Reporte
            return data;
        }



    }
}
