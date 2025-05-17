<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Make_Rating.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Make_Rating" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .details-view {
            width: 100%; /* Increased width */
            border-collapse: collapse;
            margin: 20px auto; /* Center the DetailsView */
            font-size: 16px;
        }

        .details-view th {
            background-color: #4CAF50; /* Darker green background */
            color: white;
            padding: 10px;
        }

        .details-view td {
            padding: 10px;
            border: 1px solid #ddd; 
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
    <div>
        <asp:DetailsView ID="DetailsView1" CssClass="details-view" runat="server" AutoGenerateRows="False" DataKeyNames="customer_id" DataSourceID="SqlDataSource2" Height="50px" Width="125px" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="customer_id" HeaderText="customer_id" InsertVisible="False" ReadOnly="True" SortExpression="customer_id" />
                <asp:BoundField DataField="customer_name" HeaderText="customer_name" SortExpression="customer_name" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT [customer_id], [customer_name] FROM [Customer_tbl] WHERE ([customer_email] = @customer_email)">
            <SelectParameters>
                <asp:Parameter Name="customer_email" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_date, Appointment_tbl.payment_amount, Customer_tbl.customer_name, Customer_tbl.customer_email, Service_Appointment.appointment_id, Service.service_name, Service.service_price FROM Appointment_tbl INNER JOIN Service_Appointment ON Appointment_tbl.appointment_id = Service_Appointment.appointment_id INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Service ON Service_Appointment.service_id = Service.service_id WHERE (Service_Appointment.appointment_id = @Id)">
            <SelectParameters>
                <asp:Parameter Name="Id" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div>
        <asp:GridView ID="GridView1" CssClass="gridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="appointment_date" HeaderText="Date" SortExpression="appointment_date" />
                <asp:BoundField DataField="payment_amount" HeaderText="Amount" SortExpression="payment_amount" />
                <asp:BoundField DataField="customer_name" HeaderText="Name" SortExpression="customer_name" />
                <asp:BoundField DataField="customer_email" HeaderText="Email" SortExpression="customer_email" />
                <asp:BoundField DataField="appointment_id" HeaderText="Appointment ID" SortExpression="appointment_id" />
                <asp:BoundField DataField="service_name" HeaderText="Service Name" SortExpression="service_name" />
                <asp:BoundField DataField="service_price" HeaderText="Service Price" SortExpression="service_price" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
    </div>
    
    <div>
        <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Rate your experience:"></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" Height="26px" style="margin-left: 5%" Width="200px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            <asp:ListItem Value="10">10</asp:ListItem>
            <asp:ListItem Value="9"></asp:ListItem>
            <asp:ListItem Value="8"></asp:ListItem>
            <asp:ListItem Value="7"></asp:ListItem>
            <asp:ListItem Value="6"></asp:ListItem>
            <asp:ListItem Value="5"></asp:ListItem>
            <asp:ListItem Value="4"></asp:ListItem>
            <asp:ListItem Value="3"></asp:ListItem>
            <asp:ListItem Value="2"></asp:ListItem>
            <asp:ListItem Value="1"></asp:ListItem>
            <asp:ListItem Value="0"></asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
    </div>
    
    <div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Appointment_tbl] WHERE [appointment_id] = @original_appointment_id AND [customer_id] = @original_customer_id AND [employee_id] = @original_employee_id AND (([appointment_date] = @original_appointment_date) OR ([appointment_date] IS NULL AND @original_appointment_date IS NULL)) AND (([payment_method] = @original_payment_method) OR ([payment_method] IS NULL AND @original_payment_method IS NULL)) AND [payment_amount] = @original_payment_amount AND (([appointment_timeID] = @original_appointment_timeID) OR ([appointment_timeID] IS NULL AND @original_appointment_timeID IS NULL)) AND [appointment_status] = @original_appointment_status AND (([appointment_rating] = @original_appointment_rating) OR ([appointment_rating] IS NULL AND @original_appointment_rating IS NULL)) AND (([rating_comment] = @original_rating_comment) OR ([rating_comment] IS NULL AND @original_rating_comment IS NULL)) AND (([appointment_location] = @original_appointment_location) OR ([appointment_location] IS NULL AND @original_appointment_location IS NULL)) AND (([booking_platform] = @original_booking_platform) OR ([booking_platform] IS NULL AND @original_booking_platform IS NULL)) AND (([rating_status] = @original_rating_status) OR ([rating_status] IS NULL AND @original_rating_status IS NULL))" InsertCommand="INSERT INTO [Appointment_tbl] ([customer_id], [employee_id], [appointment_date], [payment_method], [payment_amount], [appointment_timeID], [appointment_status], [appointment_rating], [rating_comment], [appointment_location], [booking_platform], [rating_status]) VALUES (@customer_id, @employee_id, @appointment_date, @payment_method, @payment_amount, @appointment_timeID, @appointment_status, @appointment_rating, @rating_comment, @appointment_location, @booking_platform, @rating_status)" OldValuesParameterFormatString="original_{0}" OnUpdated="SqlDataSource1_Updated" SelectCommand="SELECT * FROM [Appointment_tbl]" UpdateCommand="UPDATE Appointment_tbl SET appointment_rating = @appointment_rating, rating_comment = @rating_comment, rating_status = 'done' WHERE (appointment_id = @appointment_id)">
            <DeleteParameters>
                <asp:Parameter Name="original_appointment_id" Type="Int32" />
                <asp:Parameter Name="original_customer_id" Type="Int32" />
                <asp:Parameter Name="original_employee_id" Type="Int32" />
                <asp:Parameter DbType="Date" Name="original_appointment_date" />
                <asp:Parameter Name="original_payment_method" Type="String" />
                <asp:Parameter Name="original_payment_amount" Type="Decimal" />
                <asp:Parameter Name="original_appointment_timeID" Type="Int32" />
                <asp:Parameter Name="original_appointment_status" Type="String" />
                <asp:Parameter Name="original_appointment_rating" Type="Int32" />
                <asp:Parameter Name="original_rating_comment" Type="String" />
                <asp:Parameter Name="original_appointment_location" Type="String" />
                <asp:Parameter Name="original_booking_platform" Type="String" />
                <asp:Parameter Name="original_rating_status" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="customer_id" Type="Int32" />
                <asp:Parameter Name="employee_id" Type="Int32" />
                <asp:Parameter DbType="Date" Name="appointment_date" />
                <asp:Parameter Name="payment_method" Type="String" />
                <asp:Parameter Name="payment_amount" Type="Decimal" />
                <asp:Parameter Name="appointment_timeID" Type="Int32" />
                <asp:Parameter Name="appointment_status" Type="String" />
                <asp:Parameter Name="appointment_rating" Type="Int32" />
                <asp:Parameter Name="rating_comment" Type="String" />
                <asp:Parameter Name="appointment_location" Type="String" />
                <asp:Parameter Name="booking_platform" Type="String" />
                <asp:Parameter Name="rating_status" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="appointment_rating" Type="Decimal" />
                <asp:ControlParameter ControlID="TextBox1" Name="rating_comment" PropertyName="Text" />
                <asp:Parameter Name="appointment_id" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    <div>
        <asp:Label ID="Label1" runat="server" style="margin-left:45%" Font-Bold="True" Text="Comment on your experience:"></asp:Label>
    </div>
    <div>
        <asp:TextBox ID="TextBox1" runat="server" style="margin-left:35%" Height="67px" Width="436px" TextMode="MultiLine"></asp:TextBox>
    </div>
    <div>
        <asp:Button ID="Button1" runat="server" style="margin-left:45%" Font-Bold="True" Height="30px" OnClick="Button1_Click" Text="Submit Rating" Width="169px" />
    </div>
</asp:Content>
