﻿using System;
using System.Collections.Generic;
using System.Text;

namespace CapaService
{
    public class GeneralService
    {
        public string CadenaConexion { get; set; }

        // Mensaje de error
        public string Mensaje { get; set; }

        // Estado: 1=Ok  -1=Error
        public int Estado { get; set; }

        public GeneralService()
        {
            CadenaConexion = @"Data Source=localhost;Initial Catalog=EUREKABANK;User ID=sa;Password=sql";
        }

    }
}
