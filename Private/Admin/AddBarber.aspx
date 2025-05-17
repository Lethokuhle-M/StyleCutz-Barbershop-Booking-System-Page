<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddBarber.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Admin.AddBarber" %>
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
    <h2>Add Employee</h2>

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
        <asp:Label ID="Label5" runat="server" Text="Gender" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-input"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="GenderValidator" 
            runat="server" 
            ControlToValidate="TextBox4" 
            ValidationExpression="^(Male|Female|Other)$" 
            ForeColor="Red" 
            ErrorMessage="Please enter Male or Female or Other." />
        
        
    </div>

    <div class="form-group" style="display:flex">
        <asp:Label ID="Label6" runat="server" Text="Position" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox5" runat="server" CssClass="form-input"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="RoleValidator" 
            runat="server" 
            ControlToValidate="TextBox5" 
            ValidationExpression="^(Barber|Manager|Admin)$" 
            ForeColor="Red" 
            ErrorMessage="Please enter Barber, Manager, or Admin." />
        
        
    </div>

    <div class="button-container">
        <asp:Button ID="Button1" runat="server" Text="Clear" CssClass="button clear" OnClick="Button1_Click" />
        <asp:Button ID="Button2" runat="server" Text="Confirm" CssClass="button" OnClick="Button2_Click" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Employee_tbl] WHERE [employee_id] = @original_employee_id AND [employee_name] = @original_employee_name AND [employee_cellNo] = @original_employee_cellNo AND [employee_email] = @original_employee_email AND [empoyee_gender] = @original_empoyee_gender AND (([employee_image] = @original_employee_image) OR ([employee_image] IS NULL AND @original_employee_image IS NULL)) AND [employee_status] = @original_employee_status AND [employee_position] = @original_employee_position" InsertCommand="INSERT INTO [Employee_tbl] ([employee_name], [employee_cellNo], [employee_email], [empoyee_gender], [employee_status], [employee_position]) VALUES (@employee_name, @employee_cellNo, @employee_email,@empoyee_gender, @employee_status, @employee_position)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Employee_tbl]" UpdateCommand="UPDATE [Employee_tbl] SET [employee_name] = @employee_name, [employee_cellNo] = @employee_cellNo, [employee_email] = @employee_email, [empoyee_gender] = @empoyee_gender, [employee_image] = @employee_image, [employee_status] = @employee_status, [employee_position] = @employee_position WHERE [employee_id] = @original_employee_id AND [employee_name] = @original_employee_name AND [employee_cellNo] = @original_employee_cellNo AND [employee_email] = @original_employee_email AND [empoyee_gender] = @original_empoyee_gender AND (([employee_image] = @original_employee_image) OR ([employee_image] IS NULL AND @original_employee_image IS NULL)) AND [employee_status] = @original_employee_status AND [employee_position] = @original_employee_position">
            <DeleteParameters>
                <asp:Parameter Name="original_employee_id" Type="Int32" />
                <asp:Parameter Name="original_employee_name" Type="String" />
                <asp:Parameter Name="original_employee_cellNo" Type="String" />
                <asp:Parameter Name="original_employee_email" Type="String" />
                <asp:Parameter Name="original_empoyee_gender" Type="String" />
                <asp:Parameter Name="original_employee_image" Type="Object" />
                <asp:Parameter Name="original_employee_status" Type="String" />
                <asp:Parameter Name="original_employee_position" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox2" Name="employee_name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox1" Name="employee_cellNo" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox3" Name="employee_email" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox4" Name="empoyee_gender" PropertyName="Text" Type="String" />
                <asp:Parameter DefaultValue="active" Name="employee_status" Type="String" />
                <asp:ControlParameter ControlID="TextBox5" DefaultValue="" Name="employee_position" PropertyName="Text" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="employee_name" Type="String" />
                <asp:Parameter Name="employee_cellNo" Type="String" />
                <asp:Parameter Name="employee_email" Type="String" />
                <asp:Parameter Name="empoyee_gender" Type="String" />
                <asp:Parameter Name="employee_image" Type="Object" />
                <asp:Parameter Name="employee_status" Type="String" />
                <asp:Parameter Name="employee_position" Type="String" />
                <asp:Parameter Name="original_employee_id" Type="Int32" />
                <asp:Parameter Name="original_employee_name" Type="String" />
                <asp:Parameter Name="original_employee_cellNo" Type="String" />
                <asp:Parameter Name="original_employee_email" Type="String" />
                <asp:Parameter Name="original_empoyee_gender" Type="String" />
                <asp:Parameter Name="original_employee_image" Type="Object" />
                <asp:Parameter Name="original_employee_status" Type="String" />
                <asp:Parameter Name="original_employee_position" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</div>


</asp:Content>
