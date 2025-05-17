using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Manager
{
    public partial class SelectItems : System.Web.UI.Page
    {
        List<Items> cartList;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource3.SelectParameters["employee_email"].DefaultValue = User.Identity.Name;
            DetailsView2.DataBind();

            

            if (Session["CartItem"] == null)
            {
                Session["CartItem"] = new List<Items>();
            }

            cartList = (List<Items>)Session["CartItem"];

            if (!IsPostBack)
            {
                SqlDataSourceInventory.SelectParameters["supplier_id"].DefaultValue = Convert.ToInt32(Session["SupplierId"]).ToString();
                ListView1.DataBind();

                ListView1.Attributes.Add("class", "listview");
                UpdateCart();  // Only update the cart on the initial page load
            }

        }
        protected void UpdateCart()
        {
            // Bind the cartList to GridView2 to display the items in the cart
            ListView2.DataSource = cartList;
            ListView2.DataBind();
        }

        protected void txtQuantity_TextChanged(object sender, EventArgs e)
        {
            // Cast the sender to a TextBox
            TextBox txtQuantity = (TextBox)sender;

            // Get the ListViewItem containing this TextBox
            ListViewItem item = (ListViewItem)txtQuantity.NamingContainer;

            // Retrieve the data item associated with this ListViewItem
            var dataItem = item.DataItem as DataRowView; // Adjust based on your data structure

            if (dataItem != null)
            {
                // Get the item price from the data item
                decimal itemPrice = Convert.ToDecimal(dataItem["item_price"]);

                // Find the Label for the subtotal in the same ListViewItem
                Label lblSubtotal = (Label)item.FindControl("lblSubtotal");

                // Retrieve the quantity entered by the user
                int quantity;
                if (int.TryParse(txtQuantity.Text, out quantity) && quantity > 0) // Validate quantity
                {
                    // Calculate the subtotal
                    decimal subtotal = itemPrice * quantity;

                    // Update the subtotal Label with the calculated value
                    lblSubtotal.Text = subtotal.ToString("C"); // Format as currency
                }
                else
                {
                    // Reset to 1 if the input is invalid
                    txtQuantity.Text = "1";
                    lblSubtotal.Text = itemPrice.ToString("C"); // Reset subtotal to item price
                }
            }
        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "AddItem")
            {

                ListViewDataItem item = (ListViewDataItem)e.Item;

                var lblItemName = (Label)item.FindControl("lblItemName");
                var lblItemPrice = (Label)item.FindControl("lblItemPrice");

                string ItemName = lblItemName?.Text ?? "Unknown Service";
                decimal ItemPrice = Convert.ToDecimal((lblItemPrice?.Text ?? "Unknown Service").Substring(1));

                int itme_id = Convert.ToInt32(e.CommandArgument);
                cartList.Add(new Items(itme_id, ItemName, ItemPrice));

                

                Session["CartItem"] = cartList;
                UpdateCart();
            }
        }

        protected void ReadCartItems()
        {
            List<CartProduct> cartLists = new List<CartProduct>();

            foreach (ListViewDataItem item in ListView2.Items)
            {
                // Retrieve item_id from CommandArgument or from a control if available
                //int itemId = Convert.ToInt32(DataBinder.Eval(item.DataItem, "item_id"));

                int itemId = 0;
                HiddenField hiddenItemId = (HiddenField)item.FindControl("hiddenItemId");
                if (hiddenItemId != null)
                {
                    int.TryParse(hiddenItemId.Value, out itemId);
                }

                // Retrieve item name
                string itemName = (item.FindControl("lblItemName") as Label)?.Text ?? "Unknown";

                // Retrieve item price
                decimal price = 0;
                Label lblPrice = (Label)item.FindControl("lblSubtotal");
                if (lblPrice != null)
                {
                    decimal.TryParse(lblPrice.Text, System.Globalization.NumberStyles.Currency, null, out price);
                }

                // Retrieve quantity
                int quantity = 1;
                TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");
                if (txtQuantity != null)
                {
                    int.TryParse(txtQuantity.Text, out quantity);
                }

                // Create a new CartProduct and add it to the cart list
                CartProduct product = new CartProduct(itemId, itemName, price, quantity);
                cartLists.Add(product);
            }

            // Store the list in a session or use it for further processing
            Session["CartItems"] = cartLists;
            //string message = cartLists[1].ItemId.ToString();
            //string script = $"<script type='text/javascript'>alert('{message}');</script>";
            //ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
        }

        protected void btn1_Click(object sender, EventArgs e)
        {
            ReadCartItems();
            string message;
            string script;
            List<CartProduct> cartItems = (List<CartProduct>)Session["CartItems"];
            if (cartItems.Count == 0)
            {
                message = "Select an Item you wish to order";
                script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
            else
            {
                decimal totPrice = 0;
                int qty = 0;
                for (int i = 0; i < cartItems.Count; i++)
                {
                    qty += cartItems[i].Quantity;
                    totPrice += cartItems[i].Quantity * cartItems[i].Price;
                }
                insertOrderDS.InsertParameters["supplier_id"].DefaultValue = Convert.ToInt32(Session["SupplierId"]).ToString();
                insertOrderDS.InsertParameters["quantity"].DefaultValue = qty.ToString();
                insertOrderDS.InsertParameters["total_price"].DefaultValue = totPrice.ToString();
                insertOrderDS.InsertParameters["order_date"].DefaultValue = DateTime.Now.ToString("yyyy-MM-dd");
                insertOrderDS.InsertParameters["status"].DefaultValue = "pending";
                insertOrderDS.Insert();

                Session["CartItem"] = null;
                Session["CartItems"] = null;

                 message = "Order Successful!!";
                string url = "/"; // Replace with your target page URL
                 script = $"<script type='text/javascript'>alert('{message}'); window.location='{url}';</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
            




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
                Session["CartItem"] = cartList;
                UpdateCart();
            }
        }

        protected void insertOrderDS_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int id = Convert.ToInt32(e.Command.Parameters["@order_id"].Value.ToString());
            List<CartProduct> cartItems = (List<CartProduct>)Session["CartItems"];
            
            for (int i = 0; i < cartItems.Count; i++)
            {
                insertOrderInventoryDS.InsertParameters["order_id"].DefaultValue = id.ToString();
                insertOrderInventoryDS.InsertParameters["item_id"].DefaultValue = cartItems[i].ItemId.ToString();
                insertOrderInventoryDS.InsertParameters["quantity"].DefaultValue = cartItems[i].Quantity.ToString();
               // string message = cartItems[i].ItemId.ToString();
                //string script = $"<script type='text/javascript'>alert('{message}');</script>";
                //ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
                insertOrderInventoryDS.Insert();
            }
        }

       
    }
}