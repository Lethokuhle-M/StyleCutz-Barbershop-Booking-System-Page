<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewProducts.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Manager.ViewProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        
        /* Header styles */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .gridview th, .gridview td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }

        .gridview th {
            background-color: #007bff;
            color: white;
        }

        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .gridview tr:hover {
            background-color: #f1f1f1;
        }

        /* Button styles */
        .btn {
            background-color: #007aff;
            color: white;
            padding: 15px 20px;
            border-radius: 25px;
            border: none;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px auto;
            width: fit-content;
            min-width: 150px;
        }

        .btn:hover {
            background-color: #005bb5;
            transform: scale(1.05);
        }

        .details-view {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 16px;
            
        }

        .details-view th {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
        }

        .details-view td {
            padding: 10px;
            border: 1px solid #ddd;
        }

        .form-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .form-container .dropdown, .form-container .calendar, .form-container .detailsview {
            flex: 1;
            padding-right: 20px;
        }
        .nc {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }

    .select-services-heading {
        font-weight: bold;
        font-size: 14px;
        margin-right: 10px;
        color: #333;
    }

    .dropdown, .calendar {
        width: 200px;
    }

    .dropdown select,
    .calendar input {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    /* Add styling for hover and focus effects */
    .dropdown select:hover,
    .calendar input:hover,
    .dropdown select:focus,
    .calendar input:focus {
        border-color: #0056b3;
        outline: none;
    }
    </style>

    <h1  style="text-align:center">Products</h1>

    <div class="form-container">
        <div class="detailsview">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Inventory_tbl.item_name, Inventory_tbl.item_price, Supplier_tbl.supplier_name, Inventory_tbl.quantityAvailable FROM Inventory_tbl INNER JOIN Supplier_tbl ON Inventory_tbl.supplier_id = Supplier_tbl.supplier_id"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Inventory_tbl.item_name, Inventory_tbl.item_price, Supplier_tbl.supplier_name FROM Inventory_tbl INNER JOIN Supplier_tbl ON Inventory_tbl.supplier_id = Supplier_tbl.supplier_id WHERE (Inventory_tbl.item_name LIKE + @item + '%')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="item" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server"></asp:SqlDataSource>
        </div>
    </div>
    <div class="nc">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label1" runat="server" Text="Search Product:"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" AutoPostBack="true" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" />
</div>



    <div class="gridview-container">
        <asp:GridView ID="GridView1" runat="server" CssClass="gridview gridview-spacing" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"  style="margin-right: 0" Width="1135px" AllowPaging="True" >
            <Columns>
                <asp:BoundField DataField="item_name" HeaderText="item_name" SortExpression="item_name" />
                <asp:BoundField DataField="item_price" HeaderText="item_price" SortExpression="item_price" />
                <asp:BoundField DataField="supplier_name" HeaderText="supplier_name" SortExpression="supplier_name" />
                <asp:BoundField DataField="quantityAvailable" HeaderText="quantityAvailable" SortExpression="quantityAvailable" />
            </Columns>
        </asp:GridView>
        
    </div>
</asp:Content>
