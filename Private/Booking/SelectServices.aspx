<%@ Page Title="Select Services" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelectServices.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Booking.Service" %>
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

    <h1 class="select-services-heading">Select Services</h1>

    <!-- Centered DetailsView -->
    <asp:DetailsView ID="DetailsView2" CssClass="details-view" runat="server" AutoGenerateRows="False" DataKeyNames="customer_id" DataSourceID="SqlDataSource3">
        <Fields>
            <asp:BoundField DataField="customer_id" HeaderText="Customer ID" InsertVisible="False" ReadOnly="True" SortExpression="customer_id" />
            <asp:BoundField DataField="customer_name" HeaderText="Customer Name" SortExpression="customer_name" />
            <asp:BoundField DataField="customer_cellNo" HeaderText="Cell Number" SortExpression="customer_cellNo" />
            <asp:BoundField DataField="customer_email" HeaderText="Email" SortExpression="customer_email" />
            <asp:BoundField DataField="date_of_birth" HeaderText="Date of Birth" SortExpression="date_of_birth" />
            <asp:BoundField DataField="student_number" HeaderText="Student Number" SortExpression="student_number" />
            <asp:BoundField DataField="customer_address" HeaderText="Address" SortExpression="customer_address" />
        </Fields>
    </asp:DetailsView>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" 
        SelectCommand="SELECT [customer_id], [customer_name], [customer_cellNo], [customer_email], [date_of_birth], [student_number], [customer_address] 
                        FROM [Customer_tbl] WHERE ([customer_email] = @customer_email)">
        <SelectParameters>
            <asp:Parameter DefaultValue="@email" Name="customer_email" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <!-- Adjusted ListView -->
    <div class="listview">
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="ListView1_ItemCommand">
            <ItemTemplate>
                <div class="list-item">
                    <asp:Image ID="imgService" runat="server" ImageUrl='<%# "~/Images/" + Eval("service_name") + ".jpg?v=" + DateTime.Now.Ticks %>' AlternateText='<%# Eval("service_name") %>' />
                    <div class="service-name">
                        <asp:Label ID="lblServiceName" runat="server" Text='<%# Eval("service_name") %>'></asp:Label>
                    </div>
                    <div class="service-price">
                        <asp:Label ID="lblServicePrice" runat="server" Text='<%# Eval("service_price", "{0:C}") %>' />

                    </div>
                    <asp:Button ID="btnAddService" runat="server" CommandName="AddService" CommandArgument='<%# Eval("service_id") %>' CssClass="add-service-button" Text="Select Service" />
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
    <!-- ListView for selected services to mimic Amazon's shopping cart layout -->
    <asp:ListView ID="ListView2" runat="server" EnableViewState="true">
        <ItemTemplate>
            <div class="cart-list">
                <div class="cart-item">
                    <!-- Product Image -->
                    <div class="cart-item-image">
                        <img src='<%# "/Images/" + Eval("service_name") + ".jpg" %>' alt='<%# Eval("service_name") %>' />
                    </div>
                    <!-- Product Details -->
                    <div class="cart-item-details">
                        <h4><%# Eval("service_name") %></h4>
                        <!-- Remove Button -->
                        <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandArgument='<%# Eval("Service_id") %>' CssClass="cart-remove-button" OnClick="btnDelete_Click" />
                    </div>
                    <!-- Item Subtotal -->
                    <div class="cart-item-subtotal">
                        <p>Price: <strong><%# Eval("service_price", "{0:C}") %></strong></p>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:ListView>

    <asp:Button ID="btn1" runat="server" CssClass="btn" OnClick="btn1_Click" Text="Next" Width="119px" style="margin: 20px auto; display: block;" />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" 
        SelectCommand="SELECT [service_id], [service_name], [service_price] FROM [Service]">
    </asp:SqlDataSource>

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
