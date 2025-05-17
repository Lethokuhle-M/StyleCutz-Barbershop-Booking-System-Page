using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using StyleCutzBarberShopWebApp.Private.Booking;

namespace StyleCutzBarberShopWebApp.Private.Admin.POS
{
    public partial class MakePayment : System.Web.UI.Page
    {
        decimal totPrice = 0;
        List<string> services = new List<string>();
        List<int> serviceIDs = new List<int>();
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.SelectParameters["date"].DefaultValue = DateTime.Now.ToString("yyyy-MM-dd");
            GridView1.DataBind();
           // DBConnect connect = new DBConnect();
            

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //SqlDataAdapter DA = new SqlDataAdapter();
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            DBConnect db = new DBConnect();
            db.DA.Fill(ds, "Service_Inventory");
            dt = ds.Tables["Service_Inventory"];

            List<CartItem> items = new List<CartItem>();

           AppointmentReceipt Appointment = new AppointmentReceipt(GridView1.SelectedRow.Cells[2].Text.ToString(), GridView1.SelectedRow.Cells[3].Text.ToString(), GridView1.SelectedRow.Cells[4].Text.ToString(), GridView1.SelectedRow.Cells[7].Text.ToString(), GridView1.SelectedRow.Cells[8].Text.ToString(), GridView1.SelectedRow.Cells[6].Text.ToString(), DropDownList1.Text);
           Session["AppointmentReceipt"] = Appointment;

            for (int j = 0; j < GridView2.Rows.Count; j++)
            {
                items.Add(new CartItem(Convert.ToInt32(GridView2.Rows[j].Cells[3].Text),GridView2.Rows[j].Cells[1].Text.ToString(),Convert.ToDecimal(GridView2.Rows[j].Cells[2].Text)));
                int current_id = Convert.ToInt32(GridView2.Rows[j].Cells[3].Text);
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    
                    if (current_id== Convert.ToInt32(dt.Rows[i]["service_id"]) )
                    {
                        updateInventoryDS.UpdateParameters["id"].DefaultValue = dt.Rows[i]["item_id"].ToString();
                        updateInventoryDS.Update();
                      
                    }
                 

                }
            }
            Session["AppointmentServices"] = items;


            SqlDataSource5.UpdateParameters["id"].DefaultValue = GridView1.SelectedRow.Cells[1].Text;
            SqlDataSource5.UpdateParameters["payment"].DefaultValue = DropDownList1.Text;
            SqlDataSource5.Update();
            GridView1.DataBind();


            DataTable dt1 = new DataTable();
            DataSet ds1 = new DataSet();
            Connect1 db1 = new Connect1();
            db1.DA.Fill(ds1, "Inventory_tbl");
            dt1 = ds1.Tables["Inventory_tbl"];
            int a = 0;
            string message = "Payment Succesful!!, Low Inventory Levels:";
            string script;
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                if (Convert.ToInt32(dt1.Rows[i]["quantityAvailable"]) < 20)
                {
                    a = 5;
                    string item = dt1.Rows[i]["item_name"].ToString();
                    string qty = dt1.Rows[i]["quantityAvailable"].ToString();

                    message += item + " only " + qty + " Left!!, ";

                    //string message = "Low Inventory Levels: "+item+" only "+qty+" Left!! ,Consider Restocking";
                    //string script = $"<script type='text/javascript'>alert('{message}');</script>";
                    //ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

                }
            }
            if (a == 5)
            {
                message += "Consider Restocking";
                string url = "/Private/Admin/POS/Receipt";
                 script = $"<script type='text/javascript'>alert('{message}'); window.location='{url}';</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

            }
            else
            {
                message = "Payment Succesful!!!";
                string url = "/Private/Admin/POS/Receipt";
                script = $"<script type='text/javascript'>alert('{message}'); window.location='{url}';</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
           
          
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.Text == "card")
            {
                TextBox3.Text = TextBox2.Text;
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox2.Text = GridView1.SelectedRow.Cells[6].Text;
            TextBox3.Text = GridView1.SelectedRow.Cells[6].Text;
        }

        protected void DropDownList1_TextChanged(object sender, EventArgs e)
        {
            
           
                TextBox3.Text = GridView1.SelectedRow.Cells[6].Text;
           
        }

        protected void updateInventoryDS_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            //Response.Redirect("~/");
        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {
            //TextBox3.Text = TextBox2.Text;
        }
    }
}