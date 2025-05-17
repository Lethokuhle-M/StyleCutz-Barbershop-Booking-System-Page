<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Admin.AddProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <style>
    /* Reset some default styles */
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }

    .form-container {
        max-width: 800px;
        margin: auto;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-top: 10%;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333;
    }

    .form-input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        transition: border-color 0.3s;
    }

    .form-input:focus {
        border-color: #007bff;
        outline: none;
    }

    .button-container {
        display: flex;
        justify-content: space-between;
    }

    .button {
        background-color: #007bff;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .button:hover {
        background-color: #0056b3;
    }

    .button.clear {
        background-color: #6c757d;
    }

    .button.clear:hover {
        background-color: #5a6268;
    }
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
</style>

<div class="form-container">
    <h2>Add Product</h2>

    <div class="form-group" style="display:flex">
        <asp:Label ID="Label1" runat="server" Text=" Name:" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-input"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>

    <div class="form-group" style="display:flex">
        <asp:Label ID="Label2" runat="server" Text="Quantity" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-input"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="NumberValidator" 
            runat="server" 
            ControlToValidate="TextBox1" 
            ValidationExpression="^\d+(\.\d+)?$" 
            ForeColor="Red" 
            ErrorMessage="Please enter a valid number." />
        
        
    </div>

    <div class="form-group" style="display:flex">
        <asp:GridView ID="GridView1" runat="server" CssClass="gridview" AutoGenerateColumns="False" DataKeyNames="supplier_id" DataSourceID="SupplierDS" ToolTip="Select Supplier">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="supplier_id" HeaderText="Supplier ID" InsertVisible="False" ReadOnly="True" SortExpression="supplier_id" />
                <asp:BoundField DataField="supplier_name" HeaderText="Supplier Name" SortExpression="supplier_name" />
                <asp:BoundField DataField="supplier_cellNo" HeaderText="Supplier CellNo" SortExpression="supplier_cellNo" />
                <asp:BoundField DataField="supplier_email" HeaderText="Supplier Email" SortExpression="supplier_email" />
                <asp:BoundField DataField="supplier_address" HeaderText="Supplier Address" SortExpression="supplier_address" />
            </Columns>
        </asp:GridView>
    </div>

    <div class="form-group" enctype="multipart/form-data">
        <asp:Label ID="Label3" runat="server" Text="Upload Image (JPG):" CssClass="form-label"></asp:Label>
        <asp:FileUpload ID="FileUpload1" runat="server" Accept=".jpg" style="width:500px" CssClass="form-input" />
    </div>

    <!-- Additional Fields -->
    <div class="form-group" style="display:flex">
        <asp:Label ID="Label4" runat="server" Text="Price" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-input"></asp:TextBox>
         <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="RegularExpressionValidator1" 
            runat="server" 
            ControlToValidate="TextBox3" 
            ValidationExpression="^\d+(\.\d+)?$" 
            ForeColor="Red" 
            ErrorMessage="Please enter a valid price." />
       
    </div>

    

    

    <div class="button-container">
        <asp:Button ID="Button1" runat="server" Text="Clear" CssClass="button clear" OnClick="Button1_Click" />
        <asp:Button ID="Button2" runat="server" Text="Confirm" CssClass="button" OnClick="Button2_Click" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Inventory_tbl] WHERE [item_id] = @original_item_id AND [supplier_id] = @original_supplier_id AND [quantityAvailable] = @original_quantityAvailable AND [item_price] = @original_item_price AND [item_name] = @original_item_name AND (([product_image] = @original_product_image) OR ([product_image] IS NULL AND @original_product_image IS NULL)) AND [item_status] = @original_item_status" InsertCommand="INSERT INTO [Inventory_tbl] ([supplier_id], [quantityAvailable], [item_price], [item_name], [item_status]) VALUES (@supplier_id, @quantityAvailable, @item_price, @item_name,@item_status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Inventory_tbl]" UpdateCommand="UPDATE [Inventory_tbl] SET [supplier_id] = @supplier_id, [quantityAvailable] = @quantityAvailable, [item_price] = @item_price, [item_name] = @item_name, [product_image] = @product_image, [item_status] = @item_status WHERE [item_id] = @original_item_id AND [supplier_id] = @original_supplier_id AND [quantityAvailable] = @original_quantityAvailable AND [item_price] = @original_item_price AND [item_name] = @original_item_name AND (([product_image] = @original_product_image) OR ([product_image] IS NULL AND @original_product_image IS NULL)) AND [item_status] = @original_item_status">
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
                <asp:ControlParameter ControlID="GridView1" DefaultValue="" Name="supplier_id" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox1" Name="quantityAvailable" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox3" Name="item_price" PropertyName="Text" Type="Decimal" />
                <asp:ControlParameter ControlID="TextBox2" Name="item_name" PropertyName="Text" Type="String" />
                <asp:Parameter DefaultValue="available" Name="item_status" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="supplier_id" Type="Int32" />
                <asp:Parameter Name="quantityAvailable" Type="Int32" />
                <asp:Parameter Name="item_price" Type="Decimal" />
                <asp:Parameter Name="item_name" Type="String" />
                <asp:Parameter Name="product_image" Type="Object" />
                <asp:Parameter Name="item_status" Type="String" />
                <asp:Parameter Name="original_item_id" Type="Int32" />
                <asp:Parameter Name="original_supplier_id" Type="Int32" />
                <asp:Parameter Name="original_quantityAvailable" Type="Int32" />
                <asp:Parameter Name="original_item_price" Type="Decimal" />
                <asp:Parameter Name="original_item_name" Type="String" />
                <asp:Parameter Name="original_product_image" Type="Object" />
                <asp:Parameter Name="original_item_status" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SupplierDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT [supplier_id], [supplier_name], [supplier_cellNo], [supplier_email], [supplier_address] FROM [Supplier_tbl]"></asp:SqlDataSource>
    </div>
</div>
</asp:Content>
