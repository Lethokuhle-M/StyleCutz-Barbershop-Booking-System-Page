using StyleCutzBarberShopWebApp.Private.Admin;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    public partial class Service : System.Web.UI.Page
    {
        List<CartItem> cartList;
        int haircut = 1;

        Customer cust;
        protected void Page_Load(object sender, EventArgs e)
        {
            cust = (Customer)Session["Customer"];
            CheckUserRole();

            // Initialize or retrieve the cart from session
            if (Session["Cart"] == null)
            {
                Session["Cart"] = new List<CartItem>();
            }

            cartList = (List<CartItem>)Session["Cart"];

            if (!IsPostBack)
            {
                ListView1.Attributes.Add("class", "listview");
                UpdateCart();  // Only update the cart on the initial page load
            }
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
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position IN ('Admin', 'Manager')";

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
            if (User.IsInRole("Admin") || User.IsInRole("Manager") || adminEmails.Contains(userEmail, StringComparer.OrdinalIgnoreCase))
            {
                if (cust == null)
                {
                    Response.Redirect("/Private/Admin/SelectCustomer.aspx");
                }
                else
                {
                    SqlDataSource3.SelectParameters["customer_email"].DefaultValue = cust.cust_email;
                    DetailsView2.DataBind();
                }
            }
            else
            {
                SqlDataSource3.SelectParameters["customer_email"].DefaultValue = userEmail;
                DetailsView2.DataBind();
            }
        }



        protected void UpdateCart()
        {
            // Bind the cartList to GridView2 to display the items in the cart
            ListView2.DataSource = cartList;
            ListView2.DataBind();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ListViewItem item = (ListViewItem)(sender as Control).NamingContainer;

            int rowindex = item.DataItemIndex;

            if (rowindex >= 0 && rowindex < cartList.Count)
            {
                // Remove the selected item from the cart
                cartList.RemoveAt(rowindex);

                // Update the session and the GridView2 to reflect the changes
                Session["Cart"] = cartList;
                UpdateCart();
            }
        }

        protected void btn1_Click(object sender, EventArgs e)
        {
            if (ListView2.Items.Count > 0)
            {
                Response.Redirect("/Private/Booking/SelectBarber.aspx");
            }
            else
            {
                string message = "Cannot proceed without selecting atleast one service!!";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }

        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "AddService")
            {
                
                ListViewDataItem item = (ListViewDataItem)e.Item;

                var lblServiceName = (Label)item.FindControl("lblServiceName");
                var lblServicePrice = (Label)item.FindControl("lblServicePrice");

                string service_name = lblServiceName?.Text ?? "Unknown Service";
                decimal service_price = Convert.ToDecimal((lblServicePrice?.Text ?? "Unknown Service").Substring(1));
                
                int service_id = Convert.ToInt32(e.CommandArgument);

                if (service_name.Contains("Dye"))
                {
                    cartList.Add(new CartItem(service_id, service_name, service_price));
                }
                else
                {
                    
                    if(Session["NumHairCut"] == null)
                    {
                        cartList.Add(new CartItem(service_id, service_name, service_price));
                        Session["NumHairCut"] = haircut;
                    }
                    else
                    {
                        ShowModal("Warning Message", "Cannot schedule appointment for more than one haircut !!");
                    }
                    
                }

                ShowModal("Service Selected", service_name);
                Session["Cart"] = cartList;
                UpdateCart();
            }
        }
        private void ShowModal(string title, string message)
        {
            string script = $"$('#modalTitle').text('{title}'); $('#modalBody').text('{message}'); $('#messageModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, true);
        }

    }



}
