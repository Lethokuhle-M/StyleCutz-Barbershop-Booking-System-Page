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
    public partial class Ratings_and_reviews : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*if (!IsPostBack)
            {
                
            }*/
            LoadComments();
        }
        protected void LoadComments()
        {
            // Get the connection string from the configuration file
            string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // SQL query to fetch the necessary data for comments
                string query = "";
                if (DropDownList1.Text == "Newest")
                {
                       query= @"
                  SELECT c.customer_name, a.appointment_rating, a.rating_comment, a.appointment_date 
                  FROM Customer_tbl c 
                  JOIN Appointment_tbl a ON c.customer_id = a.customer_id 
                  WHERE a.rating_comment IS NOT NULL
                   Order By a.appointment_date DESC";
                }
                else if (DropDownList1.Text=="Oldest")
                {
                    query = @"
                  SELECT c.customer_name, a.appointment_rating, a.rating_comment, a.appointment_date 
                  FROM Customer_tbl c 
                  JOIN Appointment_tbl a ON c.customer_id = a.customer_id 
                  WHERE a.rating_comment IS NOT NULL
                   Order By a.appointment_date ASC";
                }
                else
                {
                    query = @"
                  SELECT c.customer_name, a.appointment_rating, a.rating_comment, a.appointment_date 
                  FROM Customer_tbl c 
                  JOIN Appointment_tbl a ON c.customer_id = a.customer_id 
                  WHERE a.rating_comment IS NOT NULL";
                }
               

                SqlCommand cmd = new SqlCommand(query, conn);

                try
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Read through the data
                        while (reader.Read())
                        {
                            // Retrieve values from the current record
                            string customerName = reader["customer_name"].ToString();
                            double rating = Convert.ToDouble(reader["appointment_rating"]);
                            string comment = reader["rating_comment"].ToString();
                            DateTime appointmentDate = Convert.ToDateTime(reader["appointment_date"]);

                            // Format the appointment date
                            string formattedDate = appointmentDate.ToString("MMMM d, yyyy");

                            // Generate stars HTML based on the rating value
                            string starsHtml = GenerateStarsHtml(rating);

                            // Extract the initial from the customer name
                            string initial = !string.IsNullOrEmpty(customerName)
                                ? customerName.Substring(0, 1).ToUpper()
                                : "?";

                            // Construct and add the comment HTML
                            commentsPlaceholder.Controls.Add(new LiteralControl($@"
                        <div class='comment'>
                            <div class='comment-header'>
                                <div class='icon'>{initial}</div>
                                <strong>{customerName}</strong>
                            </div>
                            <div class='comment-stars'>
                                <div class='stars'>{starsHtml}</div>
                                <div class='date'>{formattedDate}</div>
                            </div>
                            <p>{comment}</p>
                        </div>
                    "));
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log or handle exceptions as needed
                    Console.WriteLine("Error loading comments: " + ex.Message);
                }
            }
        }






        private string GenerateStarsHtml(double rating)
        {
            int totalStars = 5;
            int fullStars = (int)Math.Round(rating * totalStars, MidpointRounding.AwayFromZero); // Round to nearest integer
            int emptyStars = totalStars - fullStars;

            // Generate stars HTML
            string starsHtml = string.Empty;
            for (int i = 0; i < fullStars; i++)
            {
                starsHtml += "<span class='star filled-star'>&#9733;</span>"; // Full star
            }

            for (int i = 0; i < emptyStars; i++)
            {
                starsHtml += "<span class='star empty-star'>&#9734;</span>"; // Empty star
            }

            return starsHtml;
        }

    }
}