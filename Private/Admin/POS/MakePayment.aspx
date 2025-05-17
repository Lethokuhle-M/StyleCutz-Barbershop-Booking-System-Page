<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MakePayment.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Admin.POS.MakePayment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }

        #paymentContainer {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 1300px;
            margin: auto;
        }

        .form-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
            width: 30%;
        }

        input[type="text"],
        select {
            width: 65%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            transition: border 0.3s;
        }

        input[type="text"]:focus,
        select:focus {
            border-color: #007bff;
            outline: none;
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: block;
            width: 100%; /* Make button full width */
        }

        button:hover {
            background-color: #0056b3;
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

        .center {
            text-align: center;
        }
    </style>

    <div id="paymentContainer">
        <h2 class="center">Make Payment</h2>

        <div class="form-group" style="display: flex; justify-content: center; align-items: center; margin-bottom: 15px;">
            <asp:Label ID="Label1" style="margin-right: 0; font-weight: bold;" runat="server" Text="Customer Name:" AssociatedControlID="TextBox1"></asp:Label>
            <asp:TextBox ID="TextBox1" style="width: 200px; padding: 5px;margin-right:5px" runat="server"></asp:TextBox>
        </div>
        <div>&nbsp;</div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" 
            SelectCommand="SELECT Appointment_tbl.appointment_id, Customer_tbl.customer_name, Employee_tbl.employee_name, Appointment_tbl.appointment_date, Appointment_tbl.payment_method, Appointment_tbl.payment_amount, Times.TimeSlot, Customer_tbl.student_number FROM Appointment_tbl INNER JOIN Employee_tbl ON Appointment_tbl.employee_id = Employee_tbl.employee_id INNER JOIN Customer_tbl ON Appointment_tbl.customer_id = Customer_tbl.customer_id INNER JOIN Times ON Appointment_tbl.appointment_timeID = Times.SlotID WHERE (Appointment_tbl.appointment_date = @date) AND (Appointment_tbl.appointment_status = 'pending')">
            <SelectParameters>
                <asp:Parameter Name="date" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="updateInventoryDS" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Inventory_tbl] WHERE [item_id] = @original_item_id AND [supplier_id] = @original_supplier_id AND [quantityAvailable] = @original_quantityAvailable AND [item_price] = @original_item_price AND [item_name] = @original_item_name AND (([product_image] = @original_product_image) OR ([product_image] IS NULL AND @original_product_image IS NULL)) AND [item_status] = @original_item_status" InsertCommand="INSERT INTO [Inventory_tbl] ([supplier_id], [quantityAvailable], [item_price], [item_name], [product_image], [item_status]) VALUES (@supplier_id, @quantityAvailable, @item_price, @item_name, @product_image, @item_status)" OldValuesParameterFormatString="original_{0}" OnUpdated="updateInventoryDS_Updated" SelectCommand="SELECT * FROM [Inventory_tbl]" UpdateCommand="UPDATE Inventory_tbl SET quantityAvailable = quantityAvailable - 1 WHERE (item_id = @id)">
            <DeleteParameters>
                <asp:Parameter Name="original_item_id" Type="Int32" />
                <asp:Parameter Name="original_supplier_id" Type="Int32" />
                <asp:Parameter Name="original_quantityAvailable" Type="Int32" />
                <asp:Parameter Name="original_item_price" Type="Decimal" />
                <asp:Parameter Name="original_item_name" Type="String" />
                <asp:Parameter Name="original_product_image" Type="Object" />
                <asp:Parameter Name="original_item_status" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="supplier_id" Type="Int32" />
                <asp:Parameter Name="quantityAvailable" Type="Int32" />
                <asp:Parameter Name="item_price" Type="Decimal" />
                <asp:Parameter Name="item_name" Type="String" />
                <asp:Parameter Name="product_image" Type="Object" />
                <asp:Parameter Name="item_status" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="id" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" 
            SelectCommand="SELECT Service_Appointment.appointment_id, Service.service_name, Service.service_price, Service_Appointment.service_id FROM Service INNER JOIN Service_Appointment ON Service.service_id = Service_Appointment.service_id WHERE (Service_Appointment.appointment_id = @id)">
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="id" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="appointment_id" DataSourceID="SqlDataSource1" CssClass="gridview" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="appointment_id" HeaderText="appointment_id" InsertVisible="False" ReadOnly="True" SortExpression="appointment_id" />
                <asp:BoundField DataField="customer_name" HeaderText="customer_name" SortExpression="customer_name" />
                <asp:BoundField DataField="employee_name" HeaderText="employee_name" SortExpression="employee_name" />
                <asp:BoundField DataField="appointment_date" HeaderText="appointment_date" SortExpression="appointment_date" />
                <asp:BoundField DataField="payment_method" HeaderText="payment_method" SortExpression="payment_method" />
                <asp:BoundField DataField="payment_amount" HeaderText="payment_amount" SortExpression="payment_amount" />
                <asp:BoundField DataField="TimeSlot" HeaderText="TimeSlot" SortExpression="TimeSlot" />
                <asp:BoundField DataField="student_number" HeaderText="student_number" SortExpression="student_number" />
            </Columns>
        </asp:GridView>

        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="appointment_id" DataSourceID="SqlDataSource2" CssClass="gridview">
            <Columns>
                <asp:BoundField DataField="appointment_id" HeaderText="Appointment ID" ReadOnly="True" SortExpression="appointment_id" />
                <asp:BoundField DataField="service_name" HeaderText="Service Name" SortExpression="service_name" />
                <asp:BoundField DataField="service_price" HeaderText="Service Price" SortExpression="service_price" />
                <asp:BoundField DataField="service_id" HeaderText="Service ID" ReadOnly="True" SortExpression="service_id" />
            </Columns>
        </asp:GridView>

        <div class="form-group">
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Appointment_tbl] WHERE [appointment_id] = @original_appointment_id AND [customer_id] = @original_customer_id AND [employee_id] = @original_employee_id AND (([appointment_date] = @original_appointment_date) OR ([appointment_date] IS NULL AND @original_appointment_date IS NULL)) AND (([payment_method] = @original_payment_method) OR ([payment_method] IS NULL AND @original_payment_method IS NULL)) AND [payment_amount] = @original_payment_amount AND (([appointment_timeID] = @original_appointment_timeID) OR ([appointment_timeID] IS NULL AND @original_appointment_timeID IS NULL)) AND [appointment_status] = @original_appointment_status" InsertCommand="INSERT INTO [Appointment_tbl] ([customer_id], [employee_id], [appointment_date], [payment_method], [payment_amount], [appointment_timeID], [appointment_status]) VALUES (@customer_id, @employee_id, @appointment_date, @payment_method, @payment_amount, @appointment_timeID, @appointment_status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Appointment_tbl]" UpdateCommand="UPDATE Appointment_tbl SET appointment_status = 'completed', payment_method = @method WHERE (appointment_id = @id)">
                <DeleteParameters>
                    <asp:Parameter Name="original_appointment_id" Type="Int32" />
                    <asp:Parameter Name="original_customer_id" Type="Int32" />
                    <asp:Parameter Name="original_employee_id" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="original_appointment_date" />
                    <asp:Parameter Name="original_payment_method" Type="String" />
                    <asp:Parameter Name="original_payment_amount" Type="Decimal" />
                    <asp:Parameter Name="original_appointment_timeID" Type="Int32" />
                    <asp:Parameter Name="original_appointment_status" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="customer_id" Type="Int32" />
                    <asp:Parameter Name="employee_id" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="appointment_date" />
                    <asp:Parameter Name="payment_method" Type="String" />
                    <asp:Parameter Name="payment_amount" Type="Decimal" />
                    <asp:Parameter Name="appointment_timeID" Type="Int32" />
                    <asp:Parameter Name="appointment_status" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="GridView2" Name="id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="method" PropertyName="SelectedValue" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Appointment_tbl] WHERE [appointment_id] = @original_appointment_id AND [customer_id] = @original_customer_id AND [employee_id] = @original_employee_id AND (([appointment_date] = @original_appointment_date) OR ([appointment_date] IS NULL AND @original_appointment_date IS NULL)) AND (([payment_method] = @original_payment_method) OR ([payment_method] IS NULL AND @original_payment_method IS NULL)) AND [payment_amount] = @original_payment_amount AND (([appointment_timeID] = @original_appointment_timeID) OR ([appointment_timeID] IS NULL AND @original_appointment_timeID IS NULL)) AND [appointment_status] = @original_appointment_status" InsertCommand="INSERT INTO [Appointment_tbl] ([customer_id], [employee_id], [appointment_date], [payment_method], [payment_amount], [appointment_timeID], [appointment_status]) VALUES (@customer_id, @employee_id, @appointment_date, @payment_method, @payment_amount, @appointment_timeID, @appointment_status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Appointment_tbl]" UpdateCommand="UPDATE Appointment_tbl SET payment_method = @payment, appointment_status = 'completed' WHERE (appointment_id = @id)">
                <DeleteParameters>
                    <asp:Parameter Name="original_appointment_id" Type="Int32" />
                    <asp:Parameter Name="original_customer_id" Type="Int32" />
                    <asp:Parameter Name="original_employee_id" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="original_appointment_date" />
                    <asp:Parameter Name="original_payment_method" Type="String" />
                    <asp:Parameter Name="original_payment_amount" Type="Decimal" />
                    <asp:Parameter Name="original_appointment_timeID" Type="Int32" />
                    <asp:Parameter Name="original_appointment_status" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="customer_id" Type="Int32" />
                    <asp:Parameter Name="employee_id" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="appointment_date" />
                    <asp:Parameter Name="payment_method" Type="String" />
                    <asp:Parameter Name="payment_amount" Type="Decimal" />
                    <asp:Parameter Name="appointment_timeID" Type="Int32" />
                    <asp:Parameter Name="appointment_status" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="payment" />
                    <asp:Parameter Name="id" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="Label5" runat="server" Text="Amount Owing:" AssociatedControlID="TextBox2"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" DeleteCommand="DELETE FROM [Service_Appointment] WHERE [appointment_id] = @original_appointment_id AND [service_id] = @original_service_id" InsertCommand="INSERT INTO [Service_Appointment] ([appointment_id], [service_id]) VALUES (@appointment_id, @service_id)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Service_Appointment]">
                <DeleteParameters>
                    <asp:Parameter Name="original_appointment_id" Type="Int32" />
                    <asp:Parameter Name="original_service_id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="appointment_id" Type="Int32" />
                    <asp:Parameter Name="service_id" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:TextBox ID="TextBox2" runat="server" ReadOnly="True" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Label ID="Label2" runat="server" Text="Payment Method:" AssociatedControlID="DropDownList1"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" OnTextChanged="DropDownList1_TextChanged">
                <asp:ListItem>Card</asp:ListItem>
                <asp:ListItem>Cash</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <asp:Label ID="Label4" runat="server" Text="Payment:" AssociatedControlID="TextBox3"></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
        </div>

        <asp:Button ID="Button1" runat="server" Text="Make Payment" OnClick="Button1_Click" />
    </div>
</asp:Content>
