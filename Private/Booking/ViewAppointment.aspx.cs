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
    public partial class ViewAppointment : System.Web.UI.Page
    {
        Customer cust;
        protected void Page_Load(object sender, EventArgs e)
        {
            cust = (Customer)Session["Customer"];

            if (!IsPostBack)
            {
                CheckUserRole();
            }
        }
        private void CheckUserRole()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            List<string> adminAndManagerEmails = new List<string>(); // List to hold admin and manager emails

            // Fetch admin and manager emails from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position IN ('Admin', 'Manager','Barber')";

                using (var command = new SqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            adminAndManagerEmails.Add(reader["employee_email"].ToString());
                        }
                    }
                }
            }
            if (User.IsInRole("Barber"))
            {
                SqlDataSource10.SelectParameters["employee_email"].DefaultValue = userEmail;
                DetailsView1.DataSourceID = SqlDataSource10.ID;

                DetailsView1.Fields.Add(new BoundField { DataField = "employee_id", HeaderText = "Id" });
                DetailsView1.Fields.Add(new BoundField { DataField = "employee_name", HeaderText = "Name" });

                DetailsView1.DataBind();

                string employeeId = DetailsView1.Rows[0].Cells[1].Text;
                string employeeName = DetailsView1.Rows[1].Cells[1].Text; // Assuming name is in second row, adjust if needed

                SqlDataSource11.SelectParameters["id"].DefaultValue = employeeId;
                GridView1.DataSourceID = SqlDataSource11.ID;
                GridView1.DataBind();

                // Query to count today's upcoming appointments
                
                connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;
                string query = @"
    SELECT COUNT(A.appointment_id)
    FROM Appointment_tbl A
    WHERE A.employee_id = @employeeId
      AND CAST(A.appointment_date AS DATE) = CAST(GETDATE() AS DATE)
      AND A.appointment_status = 'pending';
";


                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@employeeId", employeeId);

                        connection.Open();
                        int appointmentCount = (int)command.ExecuteScalar();
                        connection.Close();

                        // Show pop-up message
                        string message = $"{employeeName}, you have {appointmentCount} appointment(s) left for the day.";
                        ScriptManager.RegisterStartupScript(this, GetType(), "PopupMessage", $"alert('{message}');", true);
                    }
                }
            }


            else if (User.IsInRole("Admin") || User.IsInRole("Manager") || adminAndManagerEmails.Contains(userEmail, StringComparer.OrdinalIgnoreCase))
            {
                GridView1.DataSourceID = SELECTALLDS.ID;
                GridView1.DataBind();
            }
            else
            {
                
                SqlDataSource1.SelectParameters["customer_email"].DefaultValue = userEmail;

                DetailsView1.Fields.Add(new BoundField { DataField = "customer_id", HeaderText = "Id" });
                DetailsView1.Fields.Add(new BoundField { DataField = "customer_name", HeaderText = "Name" });

                DetailsView1.DataBind();

                SelectALLCust.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                GridView1.DataSourceID = SelectALLCust.ID;
                GridView1.DataBind();

            }
        }



        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            CheckUserRole1();
            GridView2.DataSourceID = null;
            GridView2.DataBind();

        }
        private void CheckUserRole1()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            List<string> roleEmails = new List<string>(); // List to hold admin and manager emails

            // Fetch admin and manager emails from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position IN ('Admin', 'Manager','Barber')";

                using (var command = new SqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            roleEmails.Add(reader["employee_email"].ToString());
                        }
                    }
                }
            }


            // Check if the logged-in user's email is in the list of role emails
            if (User.IsInRole("Barber"))
            {

                //viewBarberAppointments.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                //GridView1.DataSourceID = viewBarberAppointments.ID;

                    //GridView1.DataBind();
                if (DropDownList1.Text == "All" && txtDate.Text == "")
                 {
                    SelectByAllBarberDS.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectByAllBarberDS.ID;
                    GridView1.DataBind();
                 }
                else if (txtDate.Text == "")
                {
                    ViewByStatusBarberDS.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = ViewByStatusBarberDS.ID;
                    GridView1.DataBind();

                }
                else if(DropDownList1.Text == "All" && txtDate.Text != "")
                {
                    SelectALLANDDATEBarberDS.SelectParameters["id"].DefaultValue= DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectALLANDDATEBarberDS.ID;
                    GridView1.DataBind();
                }
                else
                {
                    //select by status ,date and barber id
                    SelectByDateAndStatusBarberDS.SelectParameters["ID"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectByDateAndStatusBarberDS.ID;
                    GridView1.DataBind();
                }
                

            }
            else if (User.IsInRole("Admin") || User.IsInRole("Manager"))
            {
               // GridView1.DataSourceID = viewAppointmentsManagerDS.ID;
               // GridView1.DataBind();
                if (txtDate.Text != "" && DropDownList1.Text == "All")
                {
                    SelectALLANDDATEADMINDS.SelectParameters["date"].DefaultValue = txtDate.Text;
                    GridView1.DataSourceID = SelectALLANDDATEADMINDS.ID;
                    GridView1.DataBind();

                }
               
                else if (DropDownList1.Text == "All")
                {
                    GridView1.DataSourceID = SELECTALLDS.ID;
                    GridView1.DataBind();
                }
                else if (txtDate.Text=="")
                {
                    //fill by status datasource
                    GridView1.DataSourceID = FillByStatusAdminDS.ID;
                    GridView1.DataBind();

                }
                else
                {
                    GridView1.DataSourceID = viewAppointmentsManagerDS.ID;
                    GridView1.DataBind();
                }
            }
            else
            {
                if (txtDate.Text != "" && DropDownList1.Text == "All")
                {
                    SelectAllAndDateCustomerDS.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectAllAndDateCustomerDS.ID;
                    GridView1.DataBind();
                }
                else if (DropDownList1.Text == "All")
                {
                    SelectALLCust.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectALLCust.ID;
                    GridView1.DataBind();
                }
                
                else if (txtDate.Text == "")
                {
                    
                    SelectByStatusOnlyCustDS.SelectParameters["id"].DefaultValue= DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectByStatusOnlyCustDS.ID;
                    GridView1.DataBind();

                }
                else
                {
                    ViewAppointmentCust.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = ViewAppointmentCust.ID;
                    GridView1.DataBind();

                }
            }
        }

        private void CheckUserRole2()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            List<string> roleEmails = new List<string>(); // List to hold admin and manager emails

            // Fetch admin and manager emails from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position IN ('Admin', 'Manager','Barber')";

                using (var command = new SqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            roleEmails.Add(reader["employee_email"].ToString());
                        }
                    }
                }
            }
            if (User.IsInRole("Barber"))
            {
                if (DropDownList1.Text == "All" && txtDate.Text == "")
                {
                    SelectByAllBarberDS.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectByAllBarberDS.ID;
                    GridView1.DataBind();
                }
                else if (txtDate.Text == "")
                {
                    ViewByStatusBarberDS.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = ViewByStatusBarberDS.ID;
                    GridView1.DataBind();

                }
                else if (DropDownList1.Text == "All" && txtDate.Text != "")
                {
                    SelectALLANDDATEBarberDS.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectALLANDDATEBarberDS.ID;
                    GridView1.DataBind();
                }
                else
                {
                    //select by status ,date and barber id
                    SelectByDateAndStatusBarberDS.SelectParameters["ID"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectByDateAndStatusBarberDS.ID;
                    GridView1.DataBind();
                }

            }
            else if (User.IsInRole("Admin") || User.IsInRole("Manager"))
            {
                if (txtDate.Text != "" && DropDownList1.Text == "All")
                {
                    SelectALLANDDATEADMINDS.SelectParameters["date"].DefaultValue = txtDate.Text;
                    GridView1.DataSourceID = SelectALLANDDATEADMINDS.ID;
                    GridView1.DataBind();

                }
                else if (DropDownList1.Text == "All")
                {
                    GridView1.DataSourceID = SELECTALLDS.ID;
                    GridView1.DataBind();
                }
                else
                {
                    GridView1.DataSourceID = viewAppointmentsManagerDS.ID;
                    GridView1.DataBind();
                }

                /*if (DropDownList1.Text == "All")
                {
                    GridView1.DataSourceID = SELECTALLDS.ID;
                    GridView1.DataBind();
                }
                else
                {
                    GridView1.DataSourceID = viewAppointmentsManagerDS.ID;
                    GridView1.DataBind();
                }*/
            }
            else
            {
                if (txtDate.Text != "" && DropDownList1.Text == "All")
                {
                    SelectAllAndDateCustomerDS.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectAllAndDateCustomerDS.ID;
                    GridView1.DataBind();
                }
                else if (DropDownList1.Text == "All")
                {
                    SelectALLCust.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectALLCust.ID;
                    GridView1.DataBind();
                }
                else if (txtDate.Text == "")
                {

                    SelectByStatusOnlyCustDS.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = SelectByStatusOnlyCustDS.ID;
                    GridView1.DataBind();

                }

                else 
                {
                    ViewAppointmentCust.SelectParameters["id"].DefaultValue = DetailsView1.Rows[0].Cells[1].Text;
                    GridView1.DataSourceID = ViewAppointmentCust.ID;
                    GridView1.DataBind();

                }
            } 
        }


        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            
            CheckUserRole2();
            GridView2.DataSourceID = null;
            GridView2.DataBind();

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            GridViewRow selectedRow = GridView1.SelectedRow;
            SqlDataSource4.SelectParameters["Id"].DefaultValue = selectedRow.Cells[1].Text;

            GridView2.DataSourceID = SqlDataSource4.ID;
            GridView2.DataBind();
            
        }
    }
}