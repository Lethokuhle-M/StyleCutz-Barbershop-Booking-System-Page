<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConfirmUpdate.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Booking.Update.ConfirmUpdate" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .form-container {
            width: 700px; /* Increased width for the form container */
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 20px;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px; /* Increased bottom margin */
        }

        .form-group label {
            font-weight: bold;
            width: 30%; /* Adjust width as needed */
            margin-right: 10px; /* Space between label and input */
            font-size: 16px; /* Increased font size */
        }

        .form-group input[type="text"],
        .form-group select,
        .form-group .calendar-control {
            width: 55%; /* Increased width for textboxes and dropdown */
            padding: 15px; /* Increased padding */
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px; /* Increased font size */
        }

        .form-group select {
            -webkit-appearance: none; /* Remove default styling */
            -moz-appearance: none;
            _appearance: none;
            background: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAA6WlU8AAAACXBIWXMAAB7CAAAewgFu0HU+AAABH0lEQVR42mJgAGuBjzZ1iIgRINzjFBBoYQZYxgC5oiDbwBhWwK8kWgwJIHvASWwANxkAwwNPN5cAAAAAElFTkSuQmCC') no-repeat right 10px center; /* Custom arrow */
            background-size: 10px; /* Size of the arrow */
        }

        .form-group input[type="text"]:focus,
        .form-group select:focus,
        .form-group .calendar-control:focus {
            border-color: #007bff;
        }
        .select-services-heading {
            font-size: 24px; /* Font size for the heading */
            font-weight: bold; /* Make the text bold */
            color: #343a40; /* Color to match your theme */
            margin-bottom: 0px; /* Space between the heading and the GridView */
            text-align: center; /* Center align the heading */
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

        .cn{
            display: flex;
        }
        .details-view {
            width: 100%; /* Fill the width of the parent container */
            border-collapse: collapse;
            margin: 20px 0; /* Keep some margin around the DetailsView */
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
    <h1 class="select-services-heading">Confirm The Update</h1>
    <div class="cn">
        <div>
        <asp:DetailsView ID="DetailsView1" CssClass="details-view" runat="server" Height="50px" Width="125px" AutoGenerateRows="False" DataKeyNames="customer_id" DataSourceID="SqlDataSource1">
            <Fields>
                <asp:BoundField DataField="customer_id" HeaderText="customer_id" InsertVisible="False" ReadOnly="True" SortExpression="customer_id" />
                <asp:BoundField DataField="customer_name" HeaderText="customer_name" SortExpression="customer_name" />
                <asp:BoundField DataField="customer_cellNo" HeaderText="customer_cellNo" SortExpression="customer_cellNo" />
                <asp:BoundField DataField="customer_email" HeaderText="customer_email" SortExpression="customer_email" />
                <asp:BoundField DataField="customer_address" HeaderText="customer_address" SortExpression="customer_address" />
                <asp:BoundField DataField="student_number" HeaderText="student_number" SortExpression="student_number" />
                <asp:BoundField DataField="date_of_birth" HeaderText="date_of_birth" SortExpression="date_of_birth" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT [customer_id], [customer_name], [customer_cellNo], [customer_email], [customer_address], [student_number], [date_of_birth] FROM [Customer_tbl] WHERE ([customer_email] = @customer_email)">
            <SelectParameters>
                <asp:Parameter DefaultValue="@email" Name="customer_email" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div class="form-container">
        <div class="form-group">
            <label for="customerName">Customer Name:</label>
            <asp:TextBox ID="customerName" runat="server" CssClass="form-control" placeholder="Enter customer name"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="barberName">Barber Name:</label>
            <asp:TextBox ID="barberName" runat="server" CssClass="form-control" placeholder="Enter barber name"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="appointmentDate">Appointment Date:</label>
            <asp:TextBox ID="appointmentDate" runat="server" CssClass="calendar-control" placeholder="Select date" OnTextChanged="appointmentDate_TextChanged" onkeydown="checkEnter(event)" AutoPostBack="true" />
            <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="appointmentDate" Format="yyyy-MM-dd" />
        </div>

        <div class="form-group">
            <label for="availableTimes">Available Time:</label>
            <asp:DropDownList ID="availableTimes" runat="server" CssClass="form-control" Style="height:48px;width:280px" DataSourceID="SqlDataSource2" DataTextField="TimeSlot" DataValueField="SlotID" AutoPostBack="True">
               
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label for="amountDue">Amount Due:</label>
            <asp:TextBox ID="amountDue" runat="server" CssClass="form-control" placeholder="Enter amount due"></asp:TextBox>
        </div>
    </div>

    </div>
    <div class="gridview-container">
        <asp:GridView ID="GridView1" runat="server" CssClass="gridview gridview-spacing" AutoGenerateColumns="False" DataKeyNames="appointment_id" DataSourceID="SqlDataSource5" style="margin-right: 0" Width="1135px">
            <Columns>
                <asp:BoundField DataField="appointment_id" HeaderText="appointment_id" InsertVisible="False" ReadOnly="True" SortExpression="appointment_id" />
                <asp:BoundField DataField="customer_id" HeaderText="customer_id" SortExpression="customer_id" />
                <asp:BoundField DataField="employee_id" HeaderText="employee_id" SortExpression="employee_id" />
                <asp:BoundField DataField="appointment_date" HeaderText="appointment_date" SortExpression="appointment_date" />
                <asp:BoundField DataField="payment_method" HeaderText="payment_method" SortExpression="payment_method" />
                <asp:BoundField DataField="payment_amount" HeaderText="payment_amount" SortExpression="payment_amount" />
                <asp:BoundField DataField="appointment_timeID" HeaderText="appointment_timeID" SortExpression="appointment_timeID" />
                <asp:BoundField DataField="appointment_status" HeaderText="appointment_status" SortExpression="appointment_status" />
            </Columns>
        </asp:GridView>
        
    </div>
    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT appointment_id, customer_id, employee_id, appointment_date, payment_method, payment_amount, appointment_timeID, appointment_status FROM Appointment_tbl WHERE (appointment_id = @id)">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="btn1" runat="server" CssClass="btn" OnClientClick="return Confirm();" OnClick="btn1_Click" Text="Update" Width="119px" />
    <script>
        function Confirm() {
            if (confirm("Are you sure you want to Update Appointment?") == true)
                return true;
            else
                return false;
        }
    </script>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT Times.SlotID, Times.TimeSlot FROM Times LEFT OUTER JOIN Appointment_tbl ON Appointment_tbl.appointment_timeID = Times.SlotID AND Appointment_tbl.appointment_date = @date AND Appointment_tbl.employee_id = @barber WHERE (Appointment_tbl.appointment_timeID IS NULL) AND (NOT (Times.SlotID = 23))">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="date" />
            <asp:Parameter DefaultValue="" Name="barber" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM Service_Appointment WHERE (appointment_id = @original_appointment_id)" InsertCommand="INSERT INTO [Service_Appointment] ([appointment_id], [service_id]) VALUES (@appointment_id, @service_id)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [appointment_id], [service_id] FROM [Service_Appointment]" UpdateCommand="UPDATE Service_Appointment SET service_id = @s_id WHERE (appointment_id = @a_id)">
        <DeleteParameters>
            <asp:Parameter Name="original_appointment_id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="appointment_id" Type="Int32" />
            <asp:Parameter Name="service_id" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="s_id" />
            <asp:Parameter Name="a_id" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConflictDetection="OverwriteChanges" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Service_Appointment] WHERE [appointment_id] = @id" InsertCommand="INSERT INTO [Service_Appointment] ([appointment_id], [service_id]) VALUES (@appointment_id, @service_id)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Service_Appointment]">
        <DeleteParameters>
            <asp:Parameter Name="id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="appointment_id" Type="Int32" />
            <asp:Parameter Name="service_id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        function checkEnter(event) {
            
        }
    </script>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT * FROM [Appointment_tbl]" InsertCommand="
INSERT INTO Appointment_tbl(customer_id, employee_id, appointment_date, payment_method, payment_amount, appointment_timeID, appointment_status) VALUES (@custID, @employeeID, @date, @method, @amount, @timeID, @status);
SELECT   @AppointmentID=SCOPE_IDENTITY();" OnInserted="SqlDataSource3_Inserted" OnUpdated="SqlDataSource3_Updated" UpdateCommand="UPDATE Appointment_tbl SET employee_id = @id, appointment_date = @date, payment_amount = @amount, appointment_timeID = @time WHERE (appointment_id = @app_id)">
        <InsertParameters>
            <asp:Parameter Name="employeeID" Type="Int32" />
            <asp:ControlParameter ControlID="appointmentDate" Name="date" PropertyName="Text" Type="String" />
            <asp:Parameter DefaultValue="pending" Name="method" Type="String" />
            <asp:Parameter DefaultValue="" Name="amount" Type="Decimal" />
            <asp:ControlParameter ControlID="availableTimes" Name="timeID" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter DefaultValue="pending" Name="status" Type="String" />
            <asp:ControlParameter ControlID="DetailsView1" DefaultValue="" Name="custID" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Direction="Output" Name="AppointmentID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="id" Type="Int32"/>
            <asp:Parameter Name="date" Type="String" />
            <asp:Parameter Name="amount" Type="Decimal"/>
            <asp:Parameter Name="time" Type="String" />
            <asp:Parameter Name="app_id" Type="Int32"/>
        </UpdateParameters>
    </asp:SqlDataSource>
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
</asp:Content>
