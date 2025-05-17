<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelectItems.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Manager.SelectItems"%>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            background-color: #f4f4f4; /* Light gray background */
            font-family: 'Arial', sans-serif; /* Clean sans-serif font */
        }

        h1 {
            text-align: center;
            font-size: 2.5em; 
            margin: 30px 0; 
            color: #333; 
        }

        .listview {
            display: flex; 
            flex-wrap: wrap; 
            justify-content: center; /* Center the items */
            margin: 0 auto; /* Center the list */
            padding: 20px; 
        }

        .list-item {
            text-align: center; 
            margin: 15px; /* Space around each item */
            border-radius: 10px; /* Rounded corners */
            background-color: #fff; /* White background for containers */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            overflow: hidden; /* Ensure no overflow */
            transition: transform 0.2s; /* Smooth scale effect */
            width: 22%; /* Adjust width for four items per row */
        }

        .list-item:hover {
            transform: scale(1.05); /* Scale effect on hover */
        }

        .list-item img {
            width: 100%; /* Full width for image */
            height: auto; /* Maintain aspect ratio */
            object-fit: cover; /* Cover the container */
        }

        .service-name {
            font-size: 1.1em; 
            font-weight: bold; 
            margin-top: 10px; 
        }

        .service-price {
            font-size: 1em; 
            color: #777; 
            margin-top: 5px; /* Space between name and price */
        }

        .add-service-button {
            background-color: #007aff; /* Bright blue */
            color: white;
            padding: 10px 20px; /* Button padding */
            border-radius: 25px; 
            border: none;
            font-size: 1em;
            cursor: pointer;
            margin: 10px 0; /* Space above and below button */
            transition: background-color 0.3s;
        }

        .add-service-button:hover {
            background-color: #005bb5; /* Darker blue on hover */
        }

        .details-view {
            width: 80%; /* Increased width */
            border-collapse: collapse;
            margin: 20px auto; /* Center the DetailsView */
            font-size: 16px;
        }

        .details-view th {
            background-color: #4CAF50; /* Darker green background */
            color: white;
            padding: 10px;
        }

        .details-view td {
            padding: 10px;
            border: 1px solid #ddd; 
        }

        .select-services-heading {
            font-size: 24px; /* Font size for the heading */
            font-weight: bold; /* Make the text bold */
            color: #343a40; /* Color to match your theme */
            margin-bottom: 20px; /* Space between the heading and the ListView */
            text-align: center; /* Center align the heading */
        }

        /* Styling for the GridView resembling an Amazon shopping cart */
        .cart-grid {
            width: 100%; /* Full width of the container */
            border-collapse: collapse; /* Collapse borders */
            margin: 20px auto; /* Center the GridView */
            font-size: 16px;
            background-color: #fff; /* White background for the cart */
        }

        .cart-grid th {
            background-color: #f2f2f2; /* Light grey background for header */
            color: #333; /* Darker text color */
            padding: 15px; /* Padding for header cells */
            text-align: left; /* Align text to the left */
            border-bottom: 2px solid #ddd; /* Bottom border for separation */
        }

        .cart-grid td {
            padding: 15px; /* Padding for data cells */
            border-bottom: 1px solid #ddd; /* Bottom border for separation */
        }

        .cart-grid .remove-button {
            background-color: #f44336; /* Red background for remove button */
            color: white; /* White text color */
            padding: 8px 12px; /* Button padding */
            border: none; /* No border */
            border-radius: 5px; /* Slightly rounded corners */
            cursor: pointer; /* Pointer cursor on hover */
            transition: background-color 0.3s; /* Smooth background transition */
        }

        .cart-grid .remove-button:hover {
            background-color: #c62828; /* Darker red on hover */
        }

        .cart-grid .remove-button:focus {
            outline: none; /* Remove outline on focus */
        }

        .cart-grid tr:hover {
            background-color: #f9f9f9; /* Light grey background on row hover */
        }
        .btn {
            background-color: #007aff;
            color: white;
            padding: 15px 20px;           /* Adjust horizontal padding */
            border-radius: 25px;
            border: none;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            display: flex;
            justify-content: center;       /* Horizontally centers the text */
            align-items: center;           /* Vertically centers the text */
            margin: 20px auto;             /* Center button within parent container */
            width: fit-content;            /* Adjust width to content */
            min-width: 150px;              /* Set a minimum width to balance the design */
            line-height: 1;                /* Avoid vertical misalignment */
            text-align: center;            /* Center text */
        }

        .btn:hover {
            background-color: #005bb5;
            transform: scale(1.05);
        }

        .btn-secondary {
            background-color: #5a5a5a;
        }

        .btn-secondary:hover {
            background-color: #3a3a3a;
        }

        .cart-list {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
        }

        .cart-item {
            display: flex;
            align-items: center;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .cart-item-image img {
            width: 100px;
            height: auto;
            margin-right: 20px;
        }

        .cart-item-details {
            flex: 1;
        }

        .cart-item-details h4 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }

        .cart-item-details p {
            margin: 5px 0;
            color: #555;
        }

        .cart-quantity-box {
            width: 50px;
            text-align: center;
            margin-right: 10px;
        }

        .cart-remove-button {
            background-color: transparent;
            color: #d9534f;
            border: none;
            cursor: pointer;
            padding: 5px 10px;
        }

        .cart-item-subtotal {
            text-align: right;
            font-size: 16px;
            color: #333;
        }
        .custom-modal {
            max-width: 200px; /* Adjust width for even smaller size */
        }

         /* Center the modal */
        .modal-dialog-centered {
           display: flex;
           align-items: center;
           justify-content: center;
           min-height: 100vh; /* Vertically center */
        }

    </style>

     <h1 class="select-services-heading">Select Items</h1>

    <!-- Centered DetailsView -->
    <asp:DetailsView ID="DetailsView2" CssClass="details-view" runat="server" AutoGenerateRows="False" DataKeyNames="employee_id" DataSourceID="SqlDataSource3">
        <Fields>
            <asp:BoundField DataField="employee_id" HeaderText="employee_id" InsertVisible="False" ReadOnly="True" SortExpression="employee_id" />
            <asp:BoundField DataField="employee_name" HeaderText="employee_name" SortExpression="employee_name" />
            <asp:BoundField DataField="employee_position" HeaderText="employee_position" SortExpression="employee_position" />
        </Fields>
    </asp:DetailsView>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" 
        SelectCommand="SELECT [employee_id], [employee_name], [employee_position] FROM [Employee_tbl] WHERE ([employee_email] = @employee_email)">
        <SelectParameters>
            <asp:Parameter Name="employee_email" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <!-- Updated ListView for Inventory Items -->
    <div class="listview">
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSourceInventory" OnItemCommand="ListView1_ItemCommand">
            <ItemTemplate>
                <div class="list-item">
                    <asp:Image ID="imgItem" runat="server" ImageUrl='<%# "~/ImageProducts/" + Eval("item_name") + ".jpg?v=" + DateTime.Now.Ticks %>' AlternateText='<%# Eval("item_name") %>' />
                    <div class="service-name">
                        <asp:Label ID="lblItemName" runat="server" Text='<%# Eval("item_name") %>'></asp:Label>
                    </div>
                    <div class="service-price">
                        <asp:Label ID="lblItemPrice" runat="server" Text='<%# Eval("item_price", "{0:C}") %>' />
                    </div>
                    <asp:Button ID="btnAddItem" runat="server" CommandName="AddItem" CommandArgument='<%# Eval("item_id") %>' CssClass="add-service-button" Text="Add Item" />
                </div>
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="insertOrderDS" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Order_tbl] WHERE [order_id] = @original_order_id AND [supplier_id] = @original_supplier_id AND [quantity] = @original_quantity AND [total_price] = @original_total_price AND [order_date] = @original_order_date AND [status] = @original_status" InsertCommand="INSERT INTO [Order_tbl] ([supplier_id], [quantity], [total_price], [order_date], [status]) VALUES (@supplier_id, @quantity, @total_price, @order_date, @status);
SELECT   @order_id=SCOPE_IDENTITY();" OldValuesParameterFormatString="original_{0}" OnInserted="insertOrderDS_Inserted" SelectCommand="SELECT * FROM [Order_tbl]" UpdateCommand="UPDATE [Order_tbl] SET [supplier_id] = @supplier_id, [quantity] = @quantity, [total_price] = @total_price, [order_date] = @order_date, [status] = @status WHERE [order_id] = @original_order_id AND [supplier_id] = @original_supplier_id AND [quantity] = @original_quantity AND [total_price] = @original_total_price AND [order_date] = @original_order_date AND [status] = @original_status">
            <DeleteParameters>
                <asp:Parameter Name="original_order_id" Type="Int32" />
                <asp:Parameter Name="original_supplier_id" Type="Int32" />
                <asp:Parameter Name="original_quantity" Type="Int32" />
                <asp:Parameter Name="original_total_price" Type="Decimal" />
                <asp:Parameter DbType="Date" Name="original_order_date" />
                <asp:Parameter Name="original_status" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="supplier_id" Type="Int32" />
                <asp:Parameter Name="quantity" Type="Int32" />
                <asp:Parameter Name="total_price" Type="Decimal" />
                <asp:Parameter DbType="Date" Name="order_date" />
                <asp:Parameter Name="status" Type="String" />
                <asp:Parameter Name="order_id" Direction="Output" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="supplier_id" Type="Int32" />
                <asp:Parameter Name="quantity" Type="Int32" />
                <asp:Parameter Name="total_price" Type="Decimal" />
                <asp:Parameter DbType="Date" Name="order_date" />
                <asp:Parameter Name="status" Type="String" />
                <asp:Parameter Name="original_order_id" Type="Int32" />
                <asp:Parameter Name="original_supplier_id" Type="Int32" />
                <asp:Parameter Name="original_quantity" Type="Int32" />
                <asp:Parameter Name="original_total_price" Type="Decimal" />
                <asp:Parameter DbType="Date" Name="original_order_date" />
                <asp:Parameter Name="original_status" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    <!-- New SqlDataSource for Inventory -->
    <asp:SqlDataSource ID="SqlDataSourceInventory" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" 
        SelectCommand="SELECT [item_id], [item_name], [item_price] FROM [Inventory_tbl] WHERE ([supplier_id] = @supplier_id)">
        <SelectParameters>
            <asp:Parameter Name="supplier_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="insertOrderInventoryDS" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Order_Inventory] WHERE [order_id] = @original_order_id AND [item_id] = @original_item_id AND [quantity] = @original_quantity" InsertCommand="INSERT INTO Order_Inventory(order_id, item_id, quantity) VALUES (@order_id, @item_id, @quantity)" OldValuesParameterFormatString="original_{0}"  SelectCommand="SELECT * FROM [Order_Inventory]" UpdateCommand="UPDATE [Order_Inventory] SET [quantity] = @quantity WHERE [order_id] = @original_order_id AND [item_id] = @original_item_id AND [quantity] = @original_quantity">
        <DeleteParameters>
            <asp:Parameter Name="original_order_id" Type="Int32" />
            <asp:Parameter Name="original_item_id" Type="Int32" />
            <asp:Parameter Name="original_quantity" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="order_id" Type="Int32" />
            <asp:Parameter Name="item_id" Type="Int32" />
            <asp:Parameter Name="quantity" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="quantity" Type="Int32" />
            <asp:Parameter Name="original_order_id" Type="Int32" />
            <asp:Parameter Name="original_item_id" Type="Int32" />
            <asp:Parameter Name="original_quantity" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

   <!-- ListView for selected items -->
<asp:ListView ID="ListView2" runat="server" EnableViewState="true">
    <ItemTemplate>
        <div class="cart-list">
            <div class="cart-item">
                <!-- Product Image -->
                <div class="cart-item-image">
                    <img src='<%# "/ImageProducts/" + Eval("item_name") + ".jpg" %>' alt='<%# Eval("item_name") %>' />
                </div>
                <!-- Product Details -->
                <div class="cart-item-details">
                    <asp:Label ID="lblItemName" runat="server" Text='<%# Eval("item_name") %>' />
                    <asp:HiddenField ID="hiddenItemId" runat="server" Value='<%# Eval("item_id") %>' />
                    <!-- Item Price -->
                    <div class="cart-item-price">
                        <p>Price: <strong><%# Eval("item_price", "{0:C}") %></strong></p>
                    </div>
                    <!-- Quantity Input -->
                    <div class="cart-quantity-box">
                        <asp:TextBox ID="txtQuantity" runat="server" Text="1" CssClass="form-control" Width="50px" AutoPostBack="false" OnTextChanged="txtQuantity_TextChanged" />
                        <asp:HiddenField ID="hiddenQuantity" runat="server" />
                    </div>
                    <!-- Remove Button -->
                    <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandArgument='<%# Eval("item_id") %>' CssClass="cart-remove-button" OnClick="btnDelete_Click" />
                </div>
                
                <!-- Item Subtotal -->
                <div class="cart-item-subtotal">
                    <p>Subtotal: <strong><asp:Label ID="lblSubtotal" runat="server" Text='<%# Eval("item_price", "{0:C}") %>'></asp:Label></strong></p>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:ListView>

    <asp:Button ID="btn1" runat="server" CssClass="btn" OnClientClick="return Confirm();" OnClick="btn1_Click" Text="Make Order" Width="119px" style="margin: 20px auto; display: block;" />
    <script>
            function Confirm() {
                if (confirm("Are you sure you want to Make the Order?") == true)
                    return true;
                else
                    return false;
            }
    </script>
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered custom-modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Message</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="modalBody">
                    Your message goes here.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="redirectHome()">OK</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
