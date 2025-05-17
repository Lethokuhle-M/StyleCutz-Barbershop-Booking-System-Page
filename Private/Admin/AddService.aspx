<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddService.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Admin.AddService" %>
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
                margin-top:10%;
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
        <h2>Add Service</h2>
        
        <div class="form-group" style="display:flex">
            <asp:Label ID="Label1" runat="server" Text="Service Name:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-input"></asp:TextBox>
            <span style="color: red;">*</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
          ErrorMessage="This field is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        
        <div class="form-group" style="display:flex">
            <asp:Label ID="Label2" runat="server" Text="Price:"  CssClass="form-label"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Service] WHERE [service_id] = @original_service_id AND [service_name] = @original_service_name AND [service_price] = @original_service_price AND (([service_image] = @original_service_image) OR ([service_image] IS NULL AND @original_service_image IS NULL)) AND [service_status] = @original_service_status" InsertCommand="INSERT INTO [Service] ([service_name], [service_price],[service_status]) VALUES (@service_name, @service_price,@service_status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Service]" UpdateCommand="UPDATE [Service] SET [service_name] = @service_name, [service_price] = @service_price, [service_image] = @service_image, [service_status] = @service_status WHERE [service_id] = @original_service_id AND [service_name] = @original_service_name AND [service_price] = @original_service_price AND (([service_image] = @original_service_image) OR ([service_image] IS NULL AND @original_service_image IS NULL)) AND [service_status] = @original_service_status">
                <DeleteParameters>
                    <asp:Parameter Name="original_service_id" Type="Int32" />
                    <asp:Parameter Name="original_service_name" Type="String" />
                    <asp:Parameter Name="original_service_price" Type="Decimal" />
                    <asp:Parameter Name="original_service_image" Type="Object" />
                    <asp:Parameter Name="original_service_status" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox2" Name="service_name" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox1" Name="service_price" PropertyName="Text" Type="Decimal" />
                    <asp:Parameter DefaultValue="available" Name="service_status" Type="String" />
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
                ErrorMessage="Please enter a valid price." />
           
        </div>
        
        <div class="form-group">
            <asp:Label ID="Label3" runat="server" Text="Upload Image (JPG):" CssClass="form-label"></asp:Label>
            <asp:FileUpload ID="FileUpload1" runat="server" Accept=".jpg"  style="width:500px" CssClass="form-input" />
        </div>
        
        <div class="button-container">
            <asp:Button ID="Button1" runat="server" Text="Clear" CssClass="button clear" OnClick="Button1_Click" />
            <asp:Button ID="Button2" runat="server" Text="Confirm" CssClass="button" OnClick="Button2_Click" />
        </div>
    </div>

</asp:Content>
