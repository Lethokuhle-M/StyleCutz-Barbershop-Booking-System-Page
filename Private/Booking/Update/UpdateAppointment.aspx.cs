using StyleCutzBarberShopWebApp.Private.Admin;
using StyleCutzBarberShopWebApp.Private.Booking.Update;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    public partial class UpdateAppointment : System.Web.UI.Page
    {
        Customer cust;
        List<CartItem> items = new List<CartItem>();
        protected void Page_Load(object sender, EventArgs e)
        {
            cust = (Customer)Session["Customer"];
            CheckUserRole();
            

        }
        private void CheckUserRole()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            List<string> adminEmails = new List<string>(); // List to hold admin and manager emails

            // Fetch admin and manager emails from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position IN ('Admin', 'Manager')"; // Fetch both Admin and Manager emails

                using (var command = new SqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            adminEmails.Add(reader["employee_email"].ToString());
                        }
                    }
                }
            }

            // Check if the logged-in user is an admin or manager
            if (User.IsInRole("Admin") || User.IsInRole("Manager"))
            {
                if (cust == null)
                {
                    Response.Redirect("/Private/Admin/SelectCustomer.aspx");
                }
                else
                {
                    SqlDataSource1.SelectParameters["customer_email"].DefaultValue = cust.cust_email;
                    DetailsView1.DataBind();

                    SqlDataSource6.SelectParameters["customer_id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SqlDataSource6.ID;
                }
            }
            else
            {
                // If user is not an admin or a manager, handle as a regular user
                SqlDataSource1.SelectParameters["customer_email"].DefaultValue = userEmail;
                DetailsView1.DataBind();

                SqlDataSource6.SelectParameters["customer_id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                GridView1.DataSourceID = SqlDataSource6.ID;
            }
        }


        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            /*SqlDataSource3.SelectParameters["customer_id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text.ToString();
            SqlDataSource3.SelectParameters["appointment_date"].DefaultValue = txtDate.Text;
            GridView1.DataBind();*/

            SqlDataSource3.SelectParameters["customer_id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
            GridView1.DataSourceID = SqlDataSource3.ID;
            GridView1.DataBind();

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow selectedRow = GridView1.SelectedRow;
            SqlDataSource4.SelectParameters["Id"].DefaultValue = selectedRow.Cells[1].Text;

            GridView2.DataSourceID = SqlDataSource4.ID;
            GridView2.DataBind();

            CurrentAppointment ca = new CurrentAppointment(Convert.ToInt32(selectedRow.Cells[1].Text),
                Convert.ToInt32(selectedRow.Cells[8].Text), selectedRow.Cells[3].Text,
                Convert.ToDecimal(selectedRow.Cells[5].Text), Convert.ToInt32(selectedRow.Cells[9].Text));

            Session["CurrentAppointment"] = ca;
            
            for(int i = 0; i < GridView2.Rows.Count; i++)
            {
                items.Add(new CartItem(Convert.ToInt32(GridView2.Rows[i].Cells[0].Text),
                    GridView2.Rows[i].Cells[1].Text, Convert.ToDecimal(GridView2.Rows[i].Cells[2].Text)));
            }

            Session["Cart"] = items;
        }
        protected void btn1_Click(object sender, EventArgs e)
        {
            int selectedIndex = GridView1.SelectedIndex;
            if (selectedIndex == -1)
            {
                string message = "Select appointment to Update!!!";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

            }
            else
            {
                if (Session["Cart"] != null)
                {
                    Response.Redirect("/Private/Booking/SelectServices.aspx");
                }
                else
                {
                    string message = "Cannot proceed without selecting an appointment!!";
                    string script = $"<script type='text/javascript'>alert('{message}');</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
                }

            }
            
            
        }
    }
}