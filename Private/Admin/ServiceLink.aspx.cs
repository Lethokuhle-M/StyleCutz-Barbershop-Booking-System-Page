using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Admin
{
    public partial class ServiceLink : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            int selectedIndex = GridView1.SelectedIndex;
            int selectedIndex2= GridView2.SelectedIndex;
            if (selectedIndex == -1)
            {
                string message = "Select a Service to link First!!!";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

            }
            else if (selectedIndex2==-1)
            {
                string message = "Select a Product to link  the Selected Service with First!!!";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);


            }
            else if(selectedIndex2 == -1 && selectedIndex == -1)
            {
                string message = "Select a Product and Service  to link  !!!";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

            }
            else
            {
                ServiceInventoryInsertDS.Insert();

            }
           
        }

        protected void ServiceInventoryInsertDS_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            string script = @"
                <script type='text/javascript'>
                    // Create a modal dialog
                    var modalHtml = `
                        <div id='customModal' style='position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); display: flex; align-items: center; justify-content: center; z-index: 10000;'>
                            <div style='background: white; padding: 20px; border-radius: 5px; text-align: center;'>
                                <p>Product Selected. Do you want to select another product?</p>
                                <button id='yesButton' style='margin-right: 10px;'>Yes</button>
                                <button id='noButton'>No</button>
                            </div>
                        </div>
                    `;
                    document.body.insertAdjacentHTML('beforeend', modalHtml);

                    // Add event listeners to buttons
                    document.getElementById('yesButton').addEventListener('click', function() {
                        // User chooses 'Yes' - close modal and stay on the page
                        document.getElementById('customModal').remove();
                    });
                    document.getElementById('noButton').addEventListener('click', function() {
                        // User chooses 'No' - redirect to home page
                        window.location.href = '/';
                    });
                </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

            // Clear the TextBox after showing the confirmation
            TextBox1.Text = "";


        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string message = "Service Selected!!";
            string script = $"<script type='text/javascript'>alert('{message}');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string message = "Product Selected!!";
            string script = $"<script type='text/javascript'>alert('{message}');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
        }
    }
}