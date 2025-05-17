using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace StyleCutzBarberShopWebApp.Private.Admin.POS
{
    public class DBConnect
    {
        public string ConnString { get; set; }
        public string Sql { get; set; }
        public SqlConnection SqlConn { get; set; }
        public SqlCommand Cmd { get; set; }
        public SqlDataAdapter DA { get; set; }
        public DBConnect()
        {
            ConnString = "Server=146.230.177.46;Database=G7Pmb2024; user id = G7Pmb2024; password=gcsxga";
            Sql = "Select * from Service_Inventory";
            SqlConn = new SqlConnection(ConnString);
            Cmd = new SqlCommand(Sql, SqlConn);
            DA = new SqlDataAdapter(Cmd);
            SqlCommandBuilder cmdBuild = new SqlCommandBuilder(DA);//enables the data adapter to
                                                                   // perform routine updates
        }
    }

}