<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .profile-container {
            width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-header img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin-bottom: 10px;
        }

        .profile-header h2 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-actions {
            text-align: center;
        }

        .form-actions button {
            background-color: #1877f2;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .form-actions button:hover {
            background-color: #165ec9;
        }
        /* Wrapper styling */
        .details-view {
    display: flex;
    flex-direction: column;
    gap: 15px;
    width: 100%;
    max-width: 600px; /* Adjust as needed */
    margin: 0 auto;
}

.form-group {
    display: flex;
    align-items: center;
    gap: 10px; /* Space between label and input */
}

.form-label {
    font-size: 14px;
    font-weight: bold;
    width: 150px; /* Set a fixed width for labels */
}

.form-input {
    width: 100%;
    max-width: 300px; /* Adjust width of textboxes */
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    box-sizing: border-box;
}

.form-input:focus {
    border-color: #007bff; /* Focus border color */
    outline: none;
}



    </style>
    
    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <div>
                    <br />
                    <br />
                    <br />
                </div>
                <h4 style="text-align:center">Change your account settings</h4>
                <!------>
                <div class="profile-container" id="form1">
                    <div class="profile-header">
                        <asp:Image ID="imgProfilePicture" runat="server" ImageUrl="~/Images/profile.png" />
                        <!--<asp:FileUpload ID="fuProfilePicture" runat="server" />-->
                    </div>

                    <div class="details-view">
                        <div class="form-group">
                            <asp:Label ID="lblName" runat="server" CssClass="form-label" Text="Name"></asp:Label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="Enter Name"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblCellNumber" runat="server" CssClass="form-label" Text="Cell Number"></asp:Label>
                            <asp:TextBox ID="txtCellNumber" runat="server" CssClass="form-input" placeholder="Enter Cell Number"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblGender" runat="server" CssClass="form-label" Text="Gender"></asp:Label>
                            <asp:TextBox ID="txtGender" runat="server" CssClass="form-input" placeholder="Enter Gender"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblAddress" runat="server" CssClass="form-label" Text="Address"></asp:Label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-input" placeholder="Enter Address"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblStudentNumber" runat="server" CssClass="form-label" Text="Student Number"></asp:Label>
                            <asp:TextBox ID="txtStudentNumber" runat="server" CssClass="form-input" placeholder="Enter Student Number"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblDateOfBirth" runat="server" CssClass="form-label" Text="Date of Birth"></asp:Label>
                            <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-input" placeholder="Select Date of Birth" AutoPostBack="true" />
                            <asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtDateOfBirth" Format="yyyy-MM-dd" />
                        </div> 
                    </div>


                    <div class="form-actions">
                        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn" OnClick="btnSave_Click" />
                    </div>
                </div>
                <!------>
                <hr />
                <dl class="dl-horizontal">
                    <dt>Password:</dt>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Create]" Visible="false" ID="CreatePassword" runat="server" />
                    </dd>
                    <dt>External Logins:</dt>
                    <dd><%: LoginsCount %>
                        <asp:HyperLink NavigateUrl="/Account/ManageLogins" Text="[Manage]" runat="server" />

                    </dd>
                    <%--
                        Phone Numbers can used as a second factor of verification in a two-factor authentication system.
                        See <a href="https://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
                        for details on setting up this ASP.NET application to support two-factor authentication using SMS.
                        Uncomment the following blocks after you have set up two-factor authentication
                    --%>
                    <%--
                    <dt>Phone Number:</dt>
                    <% if (HasPhoneNumber)
                       { %>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Add]" />
                    </dd>
                    <% }
                       else
                       { %>
                    <dd>
                        <asp:Label Text="" ID="PhoneNumber" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Change]" /> &nbsp;|&nbsp;
                        <asp:LinkButton Text="[Remove]" OnClick="RemovePhone_Click" runat="server" />
                    </dd>
                    <% } %>
                    --%>

                    <dt>Two-Factor Authentication:</dt>
                    <dd>
                        <p>
                            There are no two-factor authentication providers configured. See <a href="https://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
                            for details on setting up this ASP.NET application to support two-factor authentication.
                        </p>
                        <% if (TwoFactorEnabled)
                          { %> 
                        <%--
                        Enabled
                        <asp:LinkButton Text="[Disable]" runat="server" CommandArgument="false" OnClick="TwoFactorDisable_Click" />
                        --%>
                        <% }
                          else
                          { %> 
                        <%--
                        Disabled
                        <asp:LinkButton Text="[Enable]" CommandArgument="true" OnClick="TwoFactorEnable_Click" runat="server" />
                        --%>
                        <% } %>
                    </dd>
                </dl>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT [employee_name], [employee_cellNo], [employee_email], [empoyee_gender] FROM [Employee_tbl] WHERE ([employee_email] = @employee_email)">
        <SelectParameters>
            <asp:Parameter Name="employee_email" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Customer_tbl] WHERE [customer_id] = @original_customer_id AND [employee_id] = @original_employee_id AND [customer_name] = @original_customer_name AND [customer_cellNo] = @original_customer_cellNo AND (([customer_email] = @original_customer_email) OR ([customer_email] IS NULL AND @original_customer_email IS NULL)) AND [customer_address] = @original_customer_address AND (([student_number] = @original_student_number) OR ([student_number] IS NULL AND @original_student_number IS NULL)) AND [date_of_birth] = @original_date_of_birth" InsertCommand="INSERT INTO [Customer_tbl] ([employee_id], [customer_name], [customer_cellNo], [customer_email], [customer_address], [student_number], [date_of_birth]) VALUES (@employee_id, @customer_name, @customer_cellNo, @customer_email, @customer_address, @student_number, @date_of_birth)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Customer_tbl]" UpdateCommand="UPDATE Customer_tbl SET customer_name = @customer_name, customer_cellNo = @customer_cellNo, customer_address = @customer_address, student_number = @student_number  WHERE (customer_email = @email)">
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
            <asp:Parameter Name="employee_id" Type="Int32" />
            <asp:Parameter Name="customer_name" Type="String" />
            <asp:Parameter Name="customer_cellNo" Type="String" />
            <asp:Parameter Name="customer_email" Type="String" />
            <asp:Parameter Name="customer_address" Type="String" />
            <asp:Parameter Name="student_number" Type="String" />
            <asp:Parameter DbType="Date" Name="date_of_birth" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="customer_name" />
            <asp:Parameter Name="customer_cellNo" />
            <asp:Parameter Name="customer_address" />
            <asp:Parameter Name="student_number" />
            <asp:Parameter Name="email" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Employee_tbl] WHERE [employee_id] = @original_employee_id AND [employee_name] = @original_employee_name AND [employee_cellNo] = @original_employee_cellNo AND [employee_email] = @original_employee_email AND [empoyee_gender] = @original_empoyee_gender AND (([employee_image] = @original_employee_image) OR ([employee_image] IS NULL AND @original_employee_image IS NULL)) AND [employee_status] = @original_employee_status AND [employee_position] = @original_employee_position AND (([employee_rating] = @original_employee_rating) OR ([employee_rating] IS NULL AND @original_employee_rating IS NULL))" InsertCommand="INSERT INTO [Employee_tbl] ([employee_name], [employee_cellNo], [employee_email], [empoyee_gender], [employee_image], [employee_status], [employee_position], [employee_rating]) VALUES (@employee_name, @employee_cellNo, @employee_email, @empoyee_gender, @employee_image, @employee_status, @employee_position, @employee_rating)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Employee_tbl]" UpdateCommand="UPDATE Employee_tbl SET employee_name = @name, employee_cellNo = @cellNo, empoyee_gender = @gender WHERE (employee_email = @email)">
        <DeleteParameters>
            <asp:Parameter Name="original_employee_id" Type="Int32" />
            <asp:Parameter Name="original_employee_name" Type="String" />
            <asp:Parameter Name="original_employee_cellNo" Type="String" />
            <asp:Parameter Name="original_employee_email" Type="String" />
            <asp:Parameter Name="original_empoyee_gender" Type="String" />
            <asp:Parameter Name="original_employee_image" Type="Object" />
            <asp:Parameter Name="original_employee_status" Type="String" />
            <asp:Parameter Name="original_employee_position" Type="String" />
            <asp:Parameter Name="original_employee_rating" Type="Decimal" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="employee_name" Type="String" />
            <asp:Parameter Name="employee_cellNo" Type="String" />
            <asp:Parameter Name="employee_email" Type="String" />
            <asp:Parameter Name="empoyee_gender" Type="String" />
            <asp:Parameter Name="employee_image" Type="Object" />
            <asp:Parameter Name="employee_status" Type="String" />
            <asp:Parameter Name="employee_position" Type="String" />
            <asp:Parameter Name="employee_rating" Type="Decimal" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="cellNo" Type="String" />
            <asp:Parameter Name="gender" Type="String" />
            <asp:Parameter Name="email" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
