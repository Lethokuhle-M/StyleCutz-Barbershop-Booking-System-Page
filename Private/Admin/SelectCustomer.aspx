<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelectCustomer.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Admin.SelectCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
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
            padding: 10px 15px;
            border-radius: 25px;
            border: none;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            min-width: 100px;
        }

        .btn:hover {
            background-color: #005bb5;
            transform: scale(1.05);
        }

        /* Updated Form Layout for One-Line Display */
        .form-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            max-width: 600px;
            margin: 20px auto;
        }

        .form-container .nc {
            display: flex;
            align-items: center;
        }

        .form-container .btn {
            margin: 0;
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
    </style>

    <h1 style="text-align:center">Select Customer</h1>
    <div class="form-container">
        <asp:Label ID="Label1" runat="server" Text="Customer Name" Font-Bold="True" ForeColor="#333" />
        <div class="nc">
            <asp:TextBox ID="TextBox1" runat="server" style="width: 200px; margin-right: 10px;" OnTextChanged="TextBox1_TextChanged" AutoPostBack="true" />
            <asp:Button ID="Button1" runat="server" Text="Search" CssClass="btn" OnClick="Button1_Click" />
        </div>
    </div>

    <div class="gridview-container">
        <asp:GridView ID="GridView1" style="margin-left:2%" runat="server" CssClass="gridview gridview-spacing" AutoGenerateColumns="False" DataKeyNames="customer_id" DataSourceID="SqlDataSource2" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="1135px" AllowPaging="True">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="customer_id" HeaderText="Customer ID" InsertVisible="False" ReadOnly="True" SortExpression="customer_id" />
                <asp:BoundField DataField="employee_id" HeaderText="Employee ID" SortExpression="employee_id" />
                <asp:BoundField DataField="customer_name" HeaderText="Customer Name" SortExpression="customer_name" />
                <asp:BoundField DataField="customer_cellNo" HeaderText="Cell Number" SortExpression="customer_cellNo" />
                <asp:BoundField DataField="customer_email" HeaderText="Email" SortExpression="customer_email" />
                <asp:BoundField DataField="customer_address" HeaderText="Address" SortExpression="customer_address" />
                <asp:BoundField DataField="student_number" HeaderText="Student Number" SortExpression="student_number" />
                <asp:BoundField DataField="date_of_birth" HeaderText="Date of Birth" SortExpression="date_of_birth" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT * FROM [Customer_tbl]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [Customer_tbl] WHERE [customer_id] = @original_customer_id" InsertCommand="INSERT INTO [Customer_tbl] ([employee_id], [customer_name], [customer_cellNo], [customer_email], [customer_address], [student_number], [date_of_birth]) VALUES (@employee_id, @customer_name, @customer_cellNo, @customer_email, @customer_address, @student_number, @date_of_birth)" UpdateCommand="UPDATE [Customer_tbl] SET [employee_id] = @employee_id, [customer_name] = @customer_name, [customer_cellNo] = @customer_cellNo, [customer_email] = @customer_email, [customer_address] = @customer_address, [student_number] = @student_number, [date_of_birth] = @date_of_birth WHERE [customer_id] = @original_customer_id">
        <DeleteParameters>
            <asp:Parameter Name="original_customer_id" Type="Int32" />
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
            <asp:Parameter Name="employee_id" Type="Int32" />
            <asp:Parameter Name="customer_name" Type="String" />
            <asp:Parameter Name="customer_cellNo" Type="String" />
            <asp:Parameter Name="customer_email" Type="String" />
            <asp:Parameter Name="customer_address" Type="String" />
            <asp:Parameter Name="student_number" Type="String" />
            <asp:Parameter DbType="Date" Name="date_of_birth" />
            <asp:Parameter Name="original_customer_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT customer_id, employee_id, customer_name, customer_cellNo, customer_email, customer_address, student_number, date_of_birth FROM Customer_tbl WHERE (customer_name LIKE + @Cust + '%')">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox1" Name="Cust" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Button ID="btn1" runat="server" style="margin-left:45%;width:fit-content" CssClass="btn" OnClick="btn1_Click" Text="Create New Customer" Width="150px" />
</asp:Content>
