using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Admin
{
    public partial class AddSupplier : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            // Clear the input fields
            TextBox2.Text = string.Empty;
            TextBox1.Text = string.Empty;
            TextBox3.Text = string.Empty;
            TextBox4.Text = string.Empty;
           // TextBox5.Text = string.Empty;
            //TextBox6.Text = string.Empty;

            FileUpload1.Attributes.Clear(); // Reset the file upload control
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            // Get the service name from the TextBox
            string SupplierName = TextBox2.Text;
            //string price = TextBox1.Text;

            // Define the image path
            string imagePath = Server.MapPath("~/Images"); // Ensure the path is correct
            System.Diagnostics.Debug.WriteLine("Image Path: " + imagePath);

            // Check if service name is not empty
            if (string.IsNullOrWhiteSpace(SupplierName))
            {
                string message = "Cannot proceed without selecting at least one service!!";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
                return; // Exit the method early
            }

            // Check if a file has been uploaded
            if (FileUpload1.HasFile)
            {
                try
                {
                    // Create the full file name with a timestamp to ensure uniqueness
                    string fileName = SupplierName + ".jpg"; // Add timestamp
                    string fullPath = Path.Combine(imagePath, fileName);
                    System.Diagnostics.Debug.WriteLine("Full Path: " + fullPath); // Debug output

                    // Save the uploaded file to the specified path
                    FileUpload1.SaveAs(fullPath);

                    // Optionally, show a success message
                    SqlDataSource1.Insert();
                    //Response.Redirect("~/Private/Admin/ServiceLink");
                    TextBox2.Text = string.Empty;
                    TextBox1.Text = string.Empty;
                    TextBox3.Text = string.Empty;
                    TextBox4.Text = string.Empty;
                    //TextBox5.Text = string.Empty;
                    FileUpload1.Attributes.Clear();
                }
                catch (Exception ex)
                {
                    // Handle any exceptions that may occur
                    string errorMessage = "Error uploading the file: " + ex.Message;
                    string errorScript = $"<script type='text/javascript'>alert('{errorMessage}');</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", errorScript);
                }
            }
            else
            {
                // Handle the case where no file is selected
                string message = "Please select an image file to upload.";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
        }
    }
}
