<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddSupplier.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Admin.AddSupplier" %>
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
        max-width: 600px;
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
</style>

<div class="form-container">
    <h2>Add Supplier</h2>

    <div class="form-group" style="display:flex">
        <asp:Label ID="Label1" runat="server" Text=" Name:" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-input"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>

    <div class="form-group" style="display:flex">
        <asp:Label ID="Label2" runat="server" Text="CellPhone Number" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-input"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="PhoneNumberValidator" 
            runat="server" 
            ControlToValidate="TextBox1" 
            ValidationExpression="^\d{10}$" 
            ForeColor="Red" 
            ErrorMessage="Please enter exactly 10 digits." />
        
    </div>

    <div class="form-group">
        <asp:Label ID="Label3" runat="server" Text="Upload Image (JPG):" CssClass="form-label"></asp:Label>
        <asp:FileUpload ID="FileUpload1" runat="server" Accept=".jpg" style="width:500px" CssClass="form-input" />
    </div>

    <!-- Additional Fields -->
    <div class="form-group" style="display:flex">
        <asp:Label ID="Label4" runat="server" Text="Email Address" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-input"></asp:TextBox>
         <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="EmailValidator" 
            runat="server" 
            ControlToValidate="TextBox3" 
            ValidationExpression="^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$" 
            ForeColor="Red" 
            ErrorMessage="Please enter a valid email address." />
       
    </div>

    <div class="form-group" style="display:flex">
        <asp:Label ID="Label5" runat="server" Text="Physical Address" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-input"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="AddressValidator" 
            runat="server" 
            ControlToValidate="TextBox4" 
            ValidationExpression="^\d+\s[A-Za-z0-9\s]+$" 
            ForeColor="Red" 
            ErrorMessage="Please enter a valid street address (e.g., 123 Main St)." />
        
    </div>

    

    <div class="button-container">
        <asp:Button ID="Button1" runat="server" Text="Clear" CssClass="button clear" OnClick="Button1_Click" />
        <asp:Button ID="Button2" runat="server" Text="Confirm" CssClass="button" OnClick="Button2_Click" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Supplier_tbl] WHERE [supplier_id] = @original_supplier_id AND [supplier_name] = @original_supplier_name AND [supplier_cellNo] = @original_supplier_cellNo AND (([supplier_email] = @original_supplier_email) OR ([supplier_email] IS NULL AND @original_supplier_email IS NULL)) AND (([supplier_address] = @original_supplier_address) OR ([supplier_address] IS NULL AND @original_supplier_address IS NULL)) AND [supplier_status] = @original_supplier_status" InsertCommand="INSERT INTO [Supplier_tbl] ([supplier_name], [supplier_cellNo], [supplier_email], [supplier_address], [supplier_status]) VALUES (@supplier_name, @supplier_cellNo, @supplier_email, @supplier_address, @supplier_status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Supplier_tbl]" UpdateCommand="UPDATE [Supplier_tbl] SET [supplier_name] = @supplier_name, [supplier_cellNo] = @supplier_cellNo, [supplier_email] = @supplier_email, [supplier_address] = @supplier_address, [supplier_status] = @supplier_status WHERE [supplier_id] = @original_supplier_id AND [supplier_name] = @original_supplier_name AND [supplier_cellNo] = @original_supplier_cellNo AND (([supplier_email] = @original_supplier_email) OR ([supplier_email] IS NULL AND @original_supplier_email IS NULL)) AND (([supplier_address] = @original_supplier_address) OR ([supplier_address] IS NULL AND @original_supplier_address IS NULL)) AND [supplier_status] = @original_supplier_status">
            <DeleteParameters>
                <asp:Parameter Name="original_supplier_id" Type="Int32" />
                <asp:Parameter Name="original_supplier_name" Type="String" />
                <asp:Parameter Name="original_supplier_cellNo" Type="String" />
                <asp:Parameter Name="original_supplier_email" Type="String" />
                <asp:Parameter Name="original_supplier_address" Type="String" />
                <asp:Parameter Name="original_supplier_status" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox2" Name="supplier_name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="supplier_cellNo" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox3" Name="supplier_email" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox4" Name="supplier_address" PropertyName="Text" Type="String" />
                <asp:Parameter DefaultValue="active" Name="supplier_status" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="supplier_name" Type="String" />
                <asp:Parameter Name="supplier_cellNo" Type="String" />
                <asp:Parameter Name="supplier_email" Type="String" />
                <asp:Parameter Name="supplier_address" Type="String" />
                <asp:Parameter Name="supplier_status" Type="String" />
                <asp:Parameter Name="original_supplier_id" Type="Int32" />
                <asp:Parameter Name="original_supplier_name" Type="String" />
                <asp:Parameter Name="original_supplier_cellNo" Type="String" />
                <asp:Parameter Name="original_supplier_email" Type="String" />
                <asp:Parameter Name="original_supplier_address" Type="String" />
                <asp:Parameter Name="original_supplier_status" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</div>
</asp:Content>
