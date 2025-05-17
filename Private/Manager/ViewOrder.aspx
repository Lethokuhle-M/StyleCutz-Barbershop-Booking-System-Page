<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewOrder.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Manager.ViewOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #333;
            text-align: center;
        }
        .grid-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }
        .grid-container > div {
            width: 80%;
            margin-bottom: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .grid-title {
            font-size: 1.5em;
            color: #444;
            margin-bottom: 10px;
        }
        .label {
            font-weight: bold;
            margin-right: 10px;
        }
        .text-box {
            width: 150px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-left: 10px;
        }
        .button {
            background-color: #5cb85c;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
        }
        .button:hover {
            background-color: #4cae4c;
        }
    </style>
    <div>
        <br />
    </div>
    <h2>View Order</h2>
    <div class="grid-container">
        <div>
            <asp:Label ID="Label1" runat="server" Text="View by status:"></asp:Label>   <asp:DropDownList ID="DropDownList1" AutoPostBack="true" runat="server">
                <asp:ListItem>pending</asp:ListItem>
                <asp:ListItem>cancelled</asp:ListItem>
                <asp:ListItem>Successful</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="order_id" DataSourceID="viewByStatusDS"  CssClass="table table-striped" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="order_id" HeaderText="Order ID" InsertVisible="False" ReadOnly="True" SortExpression="order_id" />
                    <asp:BoundField DataField="supplier_id" HeaderText="Supplier ID" SortExpression="supplier_id" />
                    <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
                    <asp:BoundField DataField="total_price" HeaderText="Total Price" SortExpression="total_price" />
                    <asp:BoundField DataField="order_date" HeaderText="Order Date" SortExpression="order_date" />
                    <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                </Columns>
            </asp:GridView>
        </div>

        <div>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="order_id,item_id" DataSourceID="orderDetailsDS" CssClass="table table-striped">
                <Columns>
                    <asp:BoundField DataField="order_id" HeaderText="Order ID" ReadOnly="True" SortExpression="order_id" />
                    <asp:BoundField DataField="item_name" HeaderText="Item Name" SortExpression="item_name" />
                    <asp:BoundField DataField="item_price" HeaderText="Item Price" SortExpression="item_price" />
                    <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
                    <asp:BoundField DataField="item_id" HeaderText="Item ID" ReadOnly="True" SortExpression="item_id" />
                </Columns>
            </asp:GridView>
        </div>

       
    </div>

    <asp:SqlDataSource ID="orderDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT order_id, supplier_id, quantity, total_price, order_date, status FROM Order_tbl WHERE (status = 'pending')"></asp:SqlDataSource>
    <asp:SqlDataSource ID="orderDetailsDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Order_Inventory.order_id, Inventory_tbl.item_name, Inventory_tbl.item_price, Order_Inventory.quantity, Order_Inventory.item_id FROM Inventory_tbl INNER JOIN Order_Inventory ON Inventory_tbl.item_id = Order_Inventory.item_id WHERE (Order_Inventory.order_id = @id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="id" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="orderPaymentDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Order_tbl] WHERE [order_id] = @original_order_id AND [supplier_id] = @original_supplier_id AND [quantity] = @original_quantity AND [total_price] = @original_total_price AND [order_date] = @original_order_date AND [status] = @original_status" InsertCommand="INSERT INTO [Order_tbl] ([supplier_id], [quantity], [total_price], [order_date], [status]) VALUES (@supplier_id, @quantity, @total_price, @order_date, @status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Order_tbl]" UpdateCommand="UPDATE Order_tbl SET status = 'Successful' WHERE (order_id = @id)">
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
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="GridView1" Name="id" PropertyName="SelectedValue" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="updateInventory" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Inventory_tbl] WHERE [item_id] = @original_item_id AND [supplier_id] = @original_supplier_id AND [quantityAvailable] = @original_quantityAvailable AND [item_price] = @original_item_price AND [item_name] = @original_item_name AND (([product_image] = @original_product_image) OR ([product_image] IS NULL AND @original_product_image IS NULL)) AND [item_status] = @original_item_status" InsertCommand="INSERT INTO [Inventory_tbl] ([supplier_id], [quantityAvailable], [item_price], [item_name], [product_image], [item_status]) VALUES (@supplier_id, @quantityAvailable, @item_price, @item_name, @product_image, @item_status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Inventory_tbl]" UpdateCommand="UPDATE Inventory_tbl SET quantityAvailable = quantityAvailable + @quantity WHERE (item_id = @id)">
        <DeleteParameters>
            <asp:Parameter Name="original_item_id" Type="Int32" />
            <asp:Parameter Name="original_supplier_id" Type="Int32" />
            <asp:Parameter Name="original_quantityAvailable" Type="Int32" />
            <asp:Parameter Name="original_item_price" Type="Decimal" />
            <asp:Parameter Name="original_item_name" Type="String" />
            <asp:Parameter Name="original_product_image" Type="Object" />
            <asp:Parameter Name="original_item_status" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="supplier_id" Type="Int32" />
            <asp:Parameter Name="quantityAvailable" Type="Int32" />
            <asp:Parameter Name="item_price" Type="Decimal" />
            <asp:Parameter Name="item_name" Type="String" />
            <asp:Parameter Name="product_image" Type="Object" />
            <asp:Parameter Name="item_status" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="GridView2" Name="id" PropertyName="SelectedValue" />
            <asp:Parameter Name="quantity" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="viewByStatusDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT order_id, supplier_id, quantity, total_price, order_date, status FROM Order_tbl WHERE (status = @status)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="status" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
