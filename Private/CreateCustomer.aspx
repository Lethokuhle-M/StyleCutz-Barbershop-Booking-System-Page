<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateCustomer.aspx.cs" Inherits="StyleCutzBarberShopWebApp.CreateCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .form-container {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 10px;
        align-items: center;
        max-width: 500px;
        margin: auto;
    }

    .form-container div {
        margin-bottom: 10px;
    }
    
    label {
        font-weight: bold;
    }

    .form-container input, .form-container select {
        width: 100%;
        padding: 5px;
        box-sizing: border-box;
    }
    .input-field {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
        font-size: 16px;
    }
    .form-title {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
    }
    .form-buttons {
        grid-column: span 2;
        text-align: center;
    }

    .form-buttons button, .form-buttons input[type="submit"] {
        padding: 10px 160px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }

    .form-buttons button:hover, .form-buttons input[type="submit"]:hover {
        background-color: #0056b3;
    }
    input[type="date"] {
        width: 280px; 
        /*padding: 8px;
        box-sizing: border-box;
        font-size: 16px; 
        border: 1px solid #ccc; 
        border-radius: 4px;*/ 
    }
    /* Custom modal size */
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
<div class="form-title">
    <b>Enter Personal Details</b>
</div>
<div class="form-container">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
    </div>
    <div>
        <asp:TextBox ID="TextBox1" runat="server" CssClass="input-field"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="rfvTextBox1" runat="server" ControlToValidate="TextBox1"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>

    <div>
        <asp:Label ID="Label2" runat="server" Text="Cellphone Number"></asp:Label>
    </div>
    <div>
        <asp:TextBox ID="TextBox2" runat="server" CssClass="input-field"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="PhoneNumberValidator" 
            runat="server" 
            ControlToValidate="TextBox2" 
            ValidationExpression="^\d{10}$" 
            ForeColor="Red" 
            ErrorMessage="Please enter exactly 10 digits." />
        
    </div>

    <div>
        <asp:Label ID="Label3" runat="server" Text="Email"></asp:Label>
    </div>
    <div>
        <asp:TextBox ID="TextBox3" runat="server" CssClass="input-field" ></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="EmailValidator" 
            runat="server" 
            ControlToValidate="TextBox3" 
            ValidationExpression="^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$" 
            ForeColor="Red" 
            ErrorMessage="Please enter a valid email address." />
    </div>

    <div>
        <asp:Label ID="Label4" runat="server" Text="Address"></asp:Label>
    </div>
    <div>
        <asp:TextBox ID="TextBox4" runat="server" CssClass="input-field"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox4"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="AddressValidator" 
            runat="server" 
            ControlToValidate="TextBox4" 
            ValidationExpression="^\d+\s[A-Za-z0-9\s]+$" 
            ForeColor="Red" 
            ErrorMessage="Please enter a valid street address (e.g., 123 Main St)." />
        
    </div>

    <div>
        <asp:Label ID="Label5" runat="server" Text="Student Number"></asp:Label>
    </div>
    <div>
        <asp:TextBox ID="TextBox5" runat="server" CssClass="input-field"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox4"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>

    <div>
        <asp:Label ID="Label6" runat="server" Text="Date Of Birth"></asp:Label>
    </div>
    <div>
        <asp:TextBox ID="TextBox6" runat="server" TextMode="Date" CssClass="input-field" onblur="formatDate(this)"></asp:TextBox>
        <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox6"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>
</div>
<script type="text/javascript">
    function formatDate(textbox) {
        let dateValue = textbox.value;
        if (dateValue) {
            let date = new Date(dateValue);
            let year = date.getFullYear();
            let month = ('0' + (date.getMonth() + 1)).slice(-2); // Pad month with leading zero if necessary
            let day = ('0' + date.getDate()).slice(-2); // Pad day with leading zero if necessary
            textbox.value = `${year}-${month}-${day}`;
        }
    }
</script>
<div class="form-buttons">
   <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
</div>
<div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Customer_tbl] WHERE [customer_id] = @original_customer_id AND [employee_id] = @original_employee_id AND [customer_name] = @original_customer_name AND [customer_cellNo] = @original_customer_cellNo AND (([customer_email] = @original_customer_email) OR ([customer_email] IS NULL AND @original_customer_email IS NULL)) AND [customer_address] = @original_customer_address AND (([student_number] = @original_student_number) OR ([student_number] IS NULL AND @original_student_number IS NULL)) AND [date_of_birth] = @original_date_of_birth" InsertCommand="INSERT INTO [Customer_tbl] ([employee_id], [customer_name], [customer_cellNo], [customer_email], [customer_address], [student_number], [date_of_birth]) VALUES (@employee_id, @customer_name, @customer_cellNo, @customer_email, @customer_address, @student_number, @date_of_birth)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Customer_tbl]" UpdateCommand="UPDATE [Customer_tbl] SET [employee_id] = @employee_id, [customer_name] = @customer_name, [customer_cellNo] = @customer_cellNo, [customer_email] = @customer_email, [customer_address] = @customer_address, [student_number] = @student_number, [date_of_birth] = @date_of_birth WHERE [customer_id] = @original_customer_id AND [employee_id] = @original_employee_id AND [customer_name] = @original_customer_name AND [customer_cellNo] = @original_customer_cellNo AND (([customer_email] = @original_customer_email) OR ([customer_email] IS NULL AND @original_customer_email IS NULL)) AND [customer_address] = @original_customer_address AND (([student_number] = @original_student_number) OR ([student_number] IS NULL AND @original_student_number IS NULL)) AND [date_of_birth] = @original_date_of_birth">
        <DeleteParameters>
            <asp:Parameter Name="original_customer_id" Type="Int32" />
            <asp:Parameter Name="original_employee_id" Type="Int32" />
            <asp:Parameter Name="original_customer_name" Type="String" />
            <asp:Parameter Name="original_customer_cellNo" Type="String" />
            <asp:Parameter Name="original_customer_email" Type="String" />
            <asp:Parameter Name="original_customer_address" Type="String" />
            <asp:Parameter Name="original_student_number" Type="String" />
            <asp:Parameter DbType="Date" Name="original_date_of_birth" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter DefaultValue="11" Name="employee_id" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="customer_name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox2" Name="customer_cellNo" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox3" Name="customer_email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox4" Name="customer_address" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox5" Name="student_number" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox6" DbType="Date" Name="date_of_birth" PropertyName="Text" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="employee_id" Type="Int32" />
            <asp:Parameter Name="customer_name" Type="String" />
            <asp:Parameter Name="customer_cellNo" Type="String" />
            <asp:Parameter Name="customer_email" Type="String" />
            <asp:Parameter Name="customer_address" Type="String" />
            <asp:Parameter Name="student_number" Type="String" />
            <asp:Parameter DbType="Date" Name="date_of_birth" />
            <asp:Parameter Name="original_customer_id" Type="Int32" />
            <asp:Parameter Name="original_employee_id" Type="Int32" />
            <asp:Parameter Name="original_customer_name" Type="String" />
            <asp:Parameter Name="original_customer_cellNo" Type="String" />
            <asp:Parameter Name="original_customer_email" Type="String" />
            <asp:Parameter Name="original_customer_address" Type="String" />
            <asp:Parameter Name="original_student_number" Type="String" />
            <asp:Parameter DbType="Date" Name="original_date_of_birth" />
        </UpdateParameters>
    </asp:SqlDataSource>
   <asp:SqlDataSource ID="CreateCustomerDS" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Customer_tbl] WHERE [customer_id] = @original_customer_id AND (([employee_id] = @original_employee_id) OR ([employee_id] IS NULL AND @original_employee_id IS NULL)) AND [customer_name] = @original_customer_name AND [customer_cellNo] = @original_customer_cellNo AND (([customer_email] = @original_customer_email) OR ([customer_email] IS NULL AND @original_customer_email IS NULL)) AND [customer_address] = @original_customer_address AND (([student_number] = @original_student_number) OR ([student_number] IS NULL AND @original_student_number IS NULL)) AND [date_of_birth] = @original_date_of_birth" InsertCommand="INSERT INTO Customer_tbl(employee_id, customer_name, customer_cellNo, customer_email, customer_address, student_number, date_of_birth) VALUES (@employee_id, @customer_name, @customer_cellNo, @customer_email, @customer_address, @student_number, @date_of_birth)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Customer_tbl]" UpdateCommand="UPDATE [Customer_tbl] SET [employee_id] = @employee_id, [customer_name] = @customer_name, [customer_cellNo] = @customer_cellNo, [customer_email] = @customer_email, [customer_address] = @customer_address, [student_number] = @student_number, [date_of_birth] = @date_of_birth WHERE [customer_id] = @original_customer_id AND (([employee_id] = @original_employee_id) OR ([employee_id] IS NULL AND @original_employee_id IS NULL)) AND [customer_name] = @original_customer_name AND [customer_cellNo] = @original_customer_cellNo AND (([customer_email] = @original_customer_email) OR ([customer_email] IS NULL AND @original_customer_email IS NULL)) AND [customer_address] = @original_customer_address AND (([student_number] = @original_student_number) OR ([student_number] IS NULL AND @original_student_number IS NULL)) AND [date_of_birth] = @original_date_of_birth">
       <DeleteParameters>
           <asp:Parameter Name="original_customer_id" Type="Int32" />
           <asp:Parameter Name="original_employee_id" Type="Int32" />
           <asp:Parameter Name="original_customer_name" Type="String" />
           <asp:Parameter Name="original_customer_cellNo" Type="String" />
           <asp:Parameter Name="original_customer_email" Type="String" />
           <asp:Parameter Name="original_customer_address" Type="String" />
           <asp:Parameter Name="original_student_number" Type="String" />
           <asp:Parameter DbType="Date" Name="original_date_of_birth" />
       </DeleteParameters>
       <InsertParameters>
           <asp:Parameter DefaultValue="11" Name="employee_id" />
           <asp:ControlParameter ControlID="TextBox1" Name="customer_name" PropertyName="Text" DefaultValue="" />
           <asp:ControlParameter ControlID="TextBox2" Name="customer_cellNo" PropertyName="Text" />
           <asp:Parameter Name="customer_email" />
           <asp:ControlParameter ControlID="TextBox4" Name="customer_address" PropertyName="Text" />
           <asp:ControlParameter ControlID="TextBox5" Name="student_number" PropertyName="Text" />
           <asp:ControlParameter ControlID="TextBox6" Name="date_of_birth" PropertyName="Text" />
       </InsertParameters>
       <UpdateParameters>
           <asp:Parameter Name="employee_id" Type="Int32" />
           <asp:Parameter Name="customer_name" Type="String" />
           <asp:Parameter Name="customer_cellNo" Type="String" />
           <asp:Parameter Name="customer_email" Type="String" />
           <asp:Parameter Name="customer_address" Type="String" />
           <asp:Parameter Name="student_number" Type="String" />
           <asp:Parameter DbType="Date" Name="date_of_birth" />
           <asp:Parameter Name="original_customer_id" Type="Int32" />
           <asp:Parameter Name="original_employee_id" Type="Int32" />
           <asp:Parameter Name="original_customer_name" Type="String" />
           <asp:Parameter Name="original_customer_cellNo" Type="String" />
           <asp:Parameter Name="original_customer_email" Type="String" />
           <asp:Parameter Name="original_customer_address" Type="String" />
           <asp:Parameter Name="original_student_number" Type="String" />
           <asp:Parameter DbType="Date" Name="original_date_of_birth" />
       </UpdateParameters>
    </asp:SqlDataSource>
</div>

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

<script type="text/javascript">
    function redirectHome() {
        window.location.href = '/';
    }
</script>

</asp:Content>
