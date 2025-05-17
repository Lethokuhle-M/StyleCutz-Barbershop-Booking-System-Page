using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadComments();
            }
        }
        protected void BookNow_Click(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                // If the user is logged in, redirect to the booking page
                CheckUserRole();
            }
            else
            {
                // If the user is not logged in, redirect to the login page
                Response.Redirect("/Account/Login.aspx");
            }
        }
        private void CheckUserRole()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            var adminEmail = "M@gmail.com"; // Replace with the actual admin email

            if (User.IsInRole("Admin")) // Check if the logged-in user is an admin
            {
                Response.Redirect("/Private/Admin/SelectCustomer.aspx");
            }
            else
            {
                // Compare the logged-in user's email with the admin's email
                if (string.Equals(userEmail, adminEmail, StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("/Private/Admin/SelectCustomer.aspx");
                }
                else
                {
                    Response.Redirect("/Private/Booking/SelectServices.aspx");
                }
            }
        }
        protected void LearnMore_Click(object sender, EventArgs e)
        {
            // Redirect to the about page or perform any action when the button is clicked.
            Response.Redirect("~/About.aspx");
        }

        protected void Contact_Click(object sender, EventArgs e)
        {
            // Redirect to the contact page or perform any action when the button is clicked.
            Response.Redirect("~/Contact.aspx"); 
        }

        protected void vServiceBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Services.aspx");
        }
        private void LoadComments()
        {
            string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT TOP 5 c.customer_name, a.appointment_rating, a.rating_comment FROM Customer_tbl c JOIN Appointment_tbl a ON c.customer_id = a.customer_id WHERE a.rating_comment IS NOT NULL ORDER BY NEWID();";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string customerName = reader["customer_name"].ToString();
                    double rating = Convert.ToDouble(reader["appointment_rating"]);
                    string comment = reader["rating_comment"].ToString();
                    string starsHtml = GenerateStarsHtml(rating);

                    // Add the comment and stars to the placeholder
                    commentsPlaceholder.Controls.Add(new LiteralControl($"<div class='comment'><strong>{customerName}</strong>: {comment}<div class='stars'>{starsHtml}</div></div>"));
                }
            }
        }

        private string GenerateStarsHtml(double rating)
        {
            int fullStars = (int)Math.Floor(rating * 5); // Full stars
            bool hasHalfStar = (rating * 5) % 1 >= 0.1; // Check for half star
            int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0); // Empty stars

            // Generate stars HTML
            string starsHtml = string.Empty;
            for (int i = 0; i < fullStars; i++)
            {
                starsHtml += "<span class='star filled-star'>★</span>"; // Full star
            }

            if (hasHalfStar)
            {
                starsHtml += "<span class='star half-star'></span>"; // Half star
            }

            for (int i = 0; i < emptyStars; i++)
            {
                starsHtml += "<span class='star empty-star'>☆</span>"; // Empty star
            }

            return starsHtml;
        }
    }
}