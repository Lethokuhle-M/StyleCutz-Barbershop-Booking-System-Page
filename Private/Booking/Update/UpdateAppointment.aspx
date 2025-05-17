<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateAppointment.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Booking.UpdateAppointment" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
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
            margin-left: -250px;
            align-items:center;
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
        .btn {
            background-color: #007aff;
            color: white;
            padding: 15px 20px;           /* Adjust horizontal padding */
            border-radius: 25px;
            border: none;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            display: flex;
            justify-content: center;       /* Horizontally centers the text */
            align-items: center;           /* Vertically centers the text */
            margin: 20px auto;             /* Center button within parent container */
            width: fit-content;            /* Adjust width to content */
            min-width: 150px;              /* Set a minimum width to balance the design */
            line-height: 1;                /* Avoid vertical misalignment */
            text-align: center;            /* Center text */
        }

        .btn:hover {
            background-color: #005bb5;
            transform: scale(1.05);
        }

        .btn-secondary {
            background-color: #5a5a5a;
        }

        .btn-secondary:hover {
            background-color: #3a3a3a;
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

    <h1 style="text-align:center">Select Appointments</h1>
    <div class="form-container">
        <div class="dropdown">
        </div>

        <div class="detailsview">
            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="details-view" AutoGenerateRows="False" DataKeyNames="customer_id" DataSourceID="SqlDataSource1">
                <Fields>
                    <asp:BoundField DataField="customer_id" HeaderText="customer_id" InsertVisible="False" ReadOnly="True" SortExpression="customer_id" />
                    <asp:BoundField DataField="customer_name" HeaderText="customer_name" SortExpression="customer_name" />
                </Fields>
            </asp:DetailsView>
        </div>

        
    </div>
    <div class="nc">
        <asp:Label ID="Label1" runat="server" class="select-services-heading" Text="Select Date:"></asp:Label>
        <div class="calendar">
            <asp:TextBox ID="txtDate" runat="server" Width="200px" placeholder="Select Date" OnTextChanged="txtDate_TextChanged" AutoPostBack ="true"></asp:TextBox>
            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDate" Format="yyyy-MM-dd" />
        </div>
    </div>
    
    <div class="gridview-container">
        <asp:GridView ID="GridView1" runat="server" CssClass="gridview gridview-spacing" AutoGenerateColumns="False" DataKeyNames="appointment_id" DataSourceID="SqlDataSource3" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" style="margin-right: 0" Width="1135px" ToolTip="Select Appointment">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="appointment_id" HeaderText="Appointment ID" InsertVisible="False" ReadOnly="True" SortExpression="appointment_id" />
                <asp:BoundField DataField="customer_name" HeaderText="Customer Name" SortExpression="customer_name" />
                <asp:BoundField DataField="appointment_date" HeaderText="Appointment Date" SortExpression="appointment_date" />
                <asp:BoundField DataField="payment_method" HeaderText="Payment Method" SortExpression="payment_method" />
                <asp:BoundField DataField="payment_amount" HeaderText="Payment Amount" SortExpression="payment_amount" />
                <asp:BoundField DataField="TimeSlot" HeaderText="Time Slot" SortExpression="TimeSlot" />
                <asp:BoundField DataField="appointment_status" HeaderText="Appointment Status" SortExpression="appointment_status" />
                <asp:BoundField DataField="employee_id" HeaderText="Employee ID" SortExpression="employee_id" />
                <asp:BoundField DataField="appointment_timeID" HeaderText="Time ID" SortExpression="appointment_timeID" />
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
    <asp:Button ID="btn1" runat="server" CssClass="btn" OnClick="btn1_Click" Text="Next" Width="119px" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT [customer_id], [customer_name] FROM [Customer_tbl] WHERE ([customer_email] = @customer_email)">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="customer_email" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT * FROM [Appointment_tbl] WHERE (([customer_id] = @customer_id) AND ([appointment_date] = @appointment_date))" UpdateCommand="UPDATE Appointment_tbl SET appointment_status = 'cancelled' WHERE (appointment_id = @id)">
        <SelectParameters>
            <asp:Parameter Name="customer_id" Type="Int32" />
            <asp:Parameter DbType="Date" Name="appointment_date" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="id" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Service.service_id, Service.service_name, Service.service_price FROM Service INNER JOIN Service_Appointment ON Service.service_id = Service_Appointment.service_id WHERE (Service_Appointment.appointment_id = @Id)">
        <SelectParameters>
            <asp:Parameter Name="Id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource5" runat="server"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status, Appointment_tbl.employee_id, Appointment_tbl.appointment_timeID FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Appointment_tbl.customer_id = @customer_id) AND (Appointment_tbl.appointment_status = 'pending') AND (Appointment_tbl.appointment_date = @appointment_date)">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="customer_id" Type="Int32" />
            <asp:ControlParameter ControlID="txtDate" DbType="Date" Name="appointment_date" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Appointment_tbl.appointment_status, Appointment_tbl.employee_id, Appointment_tbl.appointment_timeID FROM Appointment_tbl INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Employee_tbl ON Customer_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Appointment_tbl.customer_id = @customer_id) AND (Appointment_tbl.appointment_status = 'pending')">
        <SelectParameters>
            <asp:Parameter Name="customer_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
