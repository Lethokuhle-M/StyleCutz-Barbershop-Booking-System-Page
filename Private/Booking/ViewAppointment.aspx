<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewAppointment.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Booking.ViewAppointment" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        
        /* Header styles */
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
            padding: 15px 20px;
            border-radius: 25px;
            border: none;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px auto;
            width: fit-content;
            min-width: 150px;
        }

        .btn:hover {
            background-color: #005bb5;
            transform: scale(1.05);
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

        .form-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .form-container .dropdown, .form-container .calendar, .form-container .detailsview {
            flex: 1;
            padding-right: 20px;
        }
        .nc {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }

    .select-services-heading {
        font-weight: bold;
        font-size: 14px;
        margin-right: 10px;
        color: #333;
    }

    .dropdown, .calendar {
        width: 200px;
    }

    .dropdown select,
    .calendar input {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    /* Add styling for hover and focus effects */
    .dropdown select:hover,
    .calendar input:hover,
    .dropdown select:focus,
    .calendar input:focus {
        border-color: #0056b3;
        outline: none;
    }
    </style>

    <h1  style="text-align:center">View Appointments</h1>

    <div class="form-container">
        <div class="detailsview">
            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="details-view" AutoGenerateRows="False" DataSourceID="SqlDataSource1">
            </asp:DetailsView>
        </div>
    </div>
    <div class="nc">
    <asp:Label ID="Label2" runat="server" class="select-services-heading" Text="Select Status:"></asp:Label>
    <div class="dropdown">
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Width="100%" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            <asp:ListItem>All</asp:ListItem>
            <asp:ListItem>pending</asp:ListItem>
            <asp:ListItem>completed</asp:ListItem>
            <asp:ListItem>cancelled</asp:ListItem>
        </asp:DropDownList>
    </div>
</div>

<div class="nc">
    <asp:Label ID="Label1" runat="server" class="select-services-heading" Text="Select Date:"></asp:Label>
    <div class="calendar">
        <asp:TextBox ID="txtDate" runat="server" Width="100%" placeholder="Select Date" OnTextChanged="txtDate_TextChanged" AutoPostBack="true"></asp:TextBox>
        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDate" Format="yyyy-MM-dd" />
    </div>
</div>

    <div class="gridview-container">
        <asp:SqlDataSource ID="FillByStatusAdminDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE(Appointment_tbl.appointment_status = @status) ">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="status" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" ToolTip="Select Appointment" CssClass="gridview gridview-spacing" AutoGenerateColumns="False" DataKeyNames="appointment_id" DataSourceID="SqlDataSource11" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" style="margin-right: 0" Width="1135px" AllowPaging="True" >
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="appointment_id" HeaderText="Appointment ID" InsertVisible="False" ReadOnly="True" SortExpression="appointment_id" />
                <asp:BoundField DataField="customer_name" HeaderText="Customer Name" SortExpression="customer_name" />
                <asp:BoundField DataField="appointment_date" HeaderText="Appointment Date" SortExpression="appointment_date" />
                <asp:BoundField DataField="payment_method" HeaderText="Payment Method" SortExpression="payment_method" />
                <asp:BoundField DataField="payment_amount" HeaderText="Payment Amount" SortExpression="payment_amount" />
                <asp:BoundField DataField="TimeSlot" HeaderText="TimeSlot" SortExpression="TimeSlot" />
                <asp:BoundField DataField="appointment_status" HeaderText="Appointment Status" SortExpression="appointment_status" />
            </Columns>
        </asp:GridView>
        <asp:GridView ID="GridView2" runat="server" CssClass="gridview gridview-spacing" AutoGenerateColumns="False" DataKeyNames="service_id" DataSourceID="SqlDataSource4">
            <Columns>
                <asp:BoundField DataField="service_id" HeaderText="Service ID" InsertVisible="False" ReadOnly="True" SortExpression="service_id" />
                <asp:BoundField DataField="service_name" HeaderText="Service Name" SortExpression="service_name" />
                <asp:BoundField DataField="service_price" HeaderText="Service Price" SortExpression="service_price" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT [customer_id], [customer_name] FROM [Customer_tbl] WHERE ([customer_email] = @customer_email)">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="customer_email" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Service.service_id, Service.service_name, Service.service_price FROM Service INNER JOIN Service_Appointment ON Service.service_id = Service_Appointment.service_id WHERE (Service_Appointment.appointment_id = @Id)">
        <SelectParameters>
            <asp:Parameter Name="Id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="viewBarberAppointments" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Employee_tbl.employee_id = @id) AND (Appointment_tbl.appointment_status = @status) AND (Appointment_tbl.appointment_date = @date)">
        <SelectParameters>
            <asp:Parameter Name="id" />
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" Name="status" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtDate" Name="date" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SelectByStatusOnlyCustDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE ( Appointment_tbl.customer_id = @id) AND (Appointment_tbl.appointment_status = @status) ">
        <SelectParameters>
            <asp:Parameter Name="id" />
            <asp:ControlParameter ControlID="DropDownList1" Name="status" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource11" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Appointment_tbl.employee_id = @id)">
        <SelectParameters>
            <asp:Parameter Name="id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource10" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Employee_tbl] WHERE [employee_id] = @original_employee_id AND [employee_name] = @original_employee_name" InsertCommand="INSERT INTO [Employee_tbl] ([employee_name]) VALUES (@employee_name)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [employee_id], [employee_name] FROM [Employee_tbl] WHERE ([employee_email] = @employee_email)" UpdateCommand="UPDATE [Employee_tbl] SET [employee_name] = @employee_name WHERE [employee_id] = @original_employee_id AND [employee_name] = @original_employee_name">
        <DeleteParameters>
            <asp:Parameter Name="original_employee_id" Type="Int32" />
            <asp:Parameter Name="original_employee_name" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="employee_name" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="employee_email" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="employee_name" Type="String" />
            <asp:Parameter Name="original_employee_id" Type="Int32" />
            <asp:Parameter Name="original_employee_name" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SelectALLCust" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID  
WHERE  Appointment_tbl.customer_id = @id">
        <SelectParameters>
            <asp:Parameter Name="id" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="SelectAllAndDateCustomerDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE ( Appointment_tbl.customer_id = @id) AND  Appointment_tbl.appointment_date=@date">
         <SelectParameters>
             <asp:Parameter Name="id" />
             <asp:ControlParameter ControlID="txtDate" Name="date" PropertyName="Text" />
         </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="viewAppointmentsManagerDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE(Appointment_tbl.appointment_status = @status) AND (Appointment_tbl.appointment_date = @date)">
        <SelectParameters>
           
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" Name="status" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtDate" Name="date" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SELECTALLDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SelectByAllBarberDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Appointment_tbl.employee_id = @id)">
        <SelectParameters>
            <asp:Parameter Name="id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SelectALLANDDATEBarberDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Appointment_tbl.employee_id = @id) AND  Appointment_tbl.appointment_date=@date">
        <SelectParameters>
            <asp:Parameter Name="id" />
            <asp:ControlParameter ControlID="txtDate" Name="date" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SelectALLANDDATEADMINDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID
WHERE  Appointment_tbl.appointment_date=@date">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtDate" Name="date" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SelectByDateAndStatusBarberDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Appointment_tbl.employee_id = @id) AND  Appointment_tbl.appointment_date=@date AND Appointment_tbl.appointment_status =@status">
        <SelectParameters>
            <asp:Parameter Name="id" />
            <asp:ControlParameter ControlID="txtDate" Name="date" PropertyName="Text" />
            <asp:ControlParameter ControlID="DropDownList1" Name="status" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="ViewAppointmentCust" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Appointment_tbl.customer_id = @id) AND (Appointment_tbl.appointment_status = @status) AND (Appointment_tbl.appointment_date = @date)">
        <SelectParameters>
            <asp:Parameter Name="id" />
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" Name="status" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtDate" Name="date" PropertyName="Text" />
        </SelectParameters>
       </asp:SqlDataSource>


    <asp:SqlDataSource ID="ViewByStatusBarberDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Appointment_tbl.appointment_status = @status) AND (Appointment_tbl.employee_id = @id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="status" PropertyName="SelectedValue" />
            <asp:Parameter Name="id" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
