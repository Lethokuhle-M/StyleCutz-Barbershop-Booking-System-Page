using StyleCutzBarberShopWebApp.Private.Admin;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    public partial class CancelAppointment : System.Web.UI.Page
    {
        Customer cust;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["__EVENTTARGET"] == "ResetSession")
            {
                // Reset the session variables if Cancel was selected
                Session["Customer"] = null;
                Session["cancel"] = false;

                // Redirect to Home page
                Response.Redirect("~/");
            }
            cust = (Customer)Session["Customer"];
            CheckUserRole();
        }
        private void CheckUserRole()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            List<string> adminEmails = new List<string>(); // List to hold admin emails

            // Fetch admin emails from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position = 'Admin,Manager'";

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

            // Check if the logged-in user is an admin or in the admin email list
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
                // Additional check for Manager role
                string managerEmail = "manager@example.com"; // Replace with actual manager email fetching logic

                // Check if the user is a manager (you might want to fetch all manager emails as previously done)
                if (string.Equals(userEmail, managerEmail, StringComparison.OrdinalIgnoreCase) || adminEmails.Contains(userEmail, StringComparer.OrdinalIgnoreCase))
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
                    SqlDataSource1.SelectParameters["customer_email"].DefaultValue = userEmail;
                    DetailsView1.DataBind();

                    SqlDataSource6.SelectParameters["customer_id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SqlDataSource6.ID;
                }
            }

        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
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
        }
        protected void btn1_Click(object sender, EventArgs e)
        {
            int selectedIndex = GridView1.SelectedIndex;
            if (selectedIndex == -1)
            {
                string message = "Select appointment to Cancel!!!";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

            }
            else
            {
                GridViewRow selectedRow = GridView1.SelectedRow;

                SqlDataSource2.UpdateParameters["id"].DefaultValue = selectedRow.Cells[1].Text;
                SqlDataSource2.Update();

            }
            


        }

        protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (txtDate.Text == "")
            {
                SqlDataSource6.SelectParameters["customer_id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                GridView1.DataSourceID = SqlDataSource6.ID;
                GridView1.DataBind();

            }
            else
            {
                SqlDataSource3.SelectParameters["customer_id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                GridView1.DataSourceID = SqlDataSource3.ID;
                GridView1.DataBind();
            }
            
            GridView2.DataSourceID = "";
            GridView2.DataBind();

            //Session["Customer"] = null;
            //Session["cancel"] = false;
            ClientScript.RegisterStartupScript(this.GetType(), "CancelConfirmation", @"
            if (confirm('Do you want to cancel more appointments?')) {
                // User wants to cancel more appointments, do nothing.
            } else {
                // User selected Cancel, reset session variables
                __doPostBack('ResetSession', '');
            }
        ", true);
            

            // Reset session variables if the user chooses "No"

            /*string message = "Appointment Cacelled Successfully";
            string script = $"<script type='text/javascript'>alert('{message}');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script);*/

        }
    }
}