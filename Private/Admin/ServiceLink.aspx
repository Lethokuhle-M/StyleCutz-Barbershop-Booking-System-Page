<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ServiceLink.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Admin.ServiceLink" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        nav {
            background-color: #007bff; /* Set your original navigation bar color here */
            color: white; /* Text color */
            padding: 10px; /* Adjust padding as needed */
        }

        nav a {
            color: white; /* Link color */
            text-decoration: none; /* Remove underline */
            padding: 10px; /* Space between links */
        }

        nav a:hover {
            background-color: #0056b3; /* Hover effect color */
        }

        .container {
            width: 90%;
            margin: auto;
            max-width: 1200px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            margin: 0 0 15px;
        }

        .grid-container {
            margin-bottom: 30px;
        }

        .grid-container table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        .grid-container th, .grid-container td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .grid-container th {
            background-color: #007bff;
            color: white;
        }

        .grid-container tr:hover {
            background-color: #f1f1f1;
        }

        .form-container {
            margin-top: 20px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            display: block;
            margin-bottom: 10px;
            color: #333;
        }

        .form-control {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .btn {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
    
    <div class="container">
        <h1>Service Management</h1>

        <div class="grid-container">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="service_id" DataSourceID="ServiceDs" CssClass="table" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" ToolTip="Select Service">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="service_id" HeaderText="Service ID" InsertVisible="False" ReadOnly="True" SortExpression="service_id" />
                    <asp:BoundField DataField="service_name" HeaderText="Service Name" SortExpression="service_name" />
                    <asp:BoundField DataField="service_price" HeaderText="Service Price" SortExpression="service_price" />
                    <asp:BoundField DataField="service_status" HeaderText="Service Status" SortExpression="service_status" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="grid-container">
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="item_id" DataSourceID="inventoryDs" CssClass="table" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" ToolTip="Select Product">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="item_id" HeaderText="Item ID" InsertVisible="False" ReadOnly="True" SortExpression="item_id" />
                    <asp:BoundField DataField="item_name" HeaderText="Item Name" SortExpression="item_name" />
                    <asp:BoundField DataField="item_price" HeaderText="Item Price" SortExpression="item_price" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="form-container">
            <asp:Label ID="Label1" runat="server" Text="Quantity:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Confirm" CssClass="btn" />
        </div>

        <asp:SqlDataSource ID="ServiceDs" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" 
            DeleteCommand="DELETE FROM [Service] WHERE [service_id] = @original_service_id AND [service_name] = @original_service_name AND [service_price] = @original_service_price AND (([service_image] = @original_service_image) OR ([service_image] IS NULL AND @original_service_image IS NULL)) AND [service_status] = @original_service_status" 
            InsertCommand="INSERT INTO [Service] ([service_name], [service_price], [service_image], [service_status]) VALUES (@service_name, @service_price, @service_image, @service_status)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT TOP (1) service_id, service_name, service_price, service_status FROM Service WHERE (service_status = 'available') ORDER BY service_id DESC" 
            UpdateCommand="UPDATE [Service] SET [service_name] = @service_name, [service_price] = @service_price, [service_image] = @service_image, [service_status] = @service_status WHERE [service_id] = @original_service_id AND [service_name] = @original_service_name AND [service_price] = @original_service_price AND (([service_image] = @original_service_image) OR ([service_image] IS NULL AND @original_service_image IS NULL)) AND [service_status] = @original_service_status">
            <DeleteParameters>
                <asp:Parameter Name="original_service_id" Type="Int32" />
                <asp:Parameter Name="original_service_name" Type="String" />
                <asp:Parameter Name="original_service_price" Type="Decimal" />
                <asp:Parameter Name="original_service_image" Type="Object" />
                <asp:Parameter Name="original_service_status" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="service_name" Type="String" />
                <asp:Parameter Name="service_price" Type="Decimal" />
                <asp:Parameter Name="service_image" Type="Object" />
                <asp:Parameter Name="service_status" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="service_name" Type="String" />
                <asp:Parameter Name="service_price" Type="Decimal" />
                <asp:Parameter Name="service_image" Type="Object" />
                <asp:Parameter Name="service_status" Type="String" />
                <asp:Parameter Name="original_service_id" Type="Int32" />
                <asp:Parameter Name="original_service_name" Type="String" />
                <asp:Parameter Name="original_service_price" Type="Decimal" />
                <asp:Parameter Name="original_service_image" Type="Object" />
                <asp:Parameter Name="original_service_status" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="inventoryDs" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT [item_id], [item_name], [item_price] FROM [Inventory_tbl]"></asp:SqlDataSource>

        <asp:SqlDataSource ID="ServiceInventoryInsertDS" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" 
            DeleteCommand="DELETE FROM [Service_Inventory] WHERE [service_id] = @original_service_id AND [item_id] = @original_item_id AND [quantity] = @original_quantity" 
            InsertCommand="INSERT INTO [Service_Inventory] ([service_id], [item_id], [quantity]) VALUES (@service_id, @item_id, @quantity)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT * FROM [Service_Inventory]" 
            UpdateCommand="UPDATE [Service_Inventory] SET [quantity] = @quantity WHERE [service_id] = @original_service_id AND [item_id] = @original_item_id" OnInserted="ServiceInventoryInsertDS_Inserted">
            <DeleteParameters>
                <asp:Parameter Name="original_service_id" Type="Int32" />
                <asp:Parameter Name="original_item_id" Type="Int32" />
                <asp:Parameter Name="original_quantity" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="GridView1" Name="service_id" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="GridView2" Name="item_id" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox1" Name="quantity" PropertyName="Text" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="quantity" Type="Int32" />
                <asp:Parameter Name="original_service_id" Type="Int32" />
                <asp:Parameter Name="original_item_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
