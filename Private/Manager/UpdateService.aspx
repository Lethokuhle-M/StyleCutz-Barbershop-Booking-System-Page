<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateService.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Manager.UpdateService" %>
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

    <h1  style="text-align:center">Update Supplier </h1>

    <div class="form-container">
        <div class="detailsview">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT * FROM [Supplier_tbl]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [Supplier_tbl] WHERE [supplier_id] = @original_supplier_id AND [supplier_name] = @original_supplier_name AND [supplier_cellNo] = @original_supplier_cellNo AND (([supplier_email] = @original_supplier_email) OR ([supplier_email] IS NULL AND @original_supplier_email IS NULL)) AND (([supplier_address] = @original_supplier_address) OR ([supplier_address] IS NULL AND @original_supplier_address IS NULL)) AND [supplier_status] = @original_supplier_status" InsertCommand="INSERT INTO [Supplier_tbl] ([supplier_name], [supplier_cellNo], [supplier_email], [supplier_address], [supplier_status]) VALUES (@supplier_name, @supplier_cellNo, @supplier_email, @supplier_address, @supplier_status)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [Supplier_tbl] SET [supplier_name] = @supplier_name, [supplier_cellNo] = @supplier_cellNo, [supplier_email] = @supplier_email, [supplier_address] = @supplier_address, [supplier_status] = @supplier_status WHERE [supplier_id] = @original_supplier_id AND [supplier_name] = @original_supplier_name AND [supplier_cellNo] = @original_supplier_cellNo AND (([supplier_email] = @original_supplier_email) OR ([supplier_email] IS NULL AND @original_supplier_email IS NULL)) AND (([supplier_address] = @original_supplier_address) OR ([supplier_address] IS NULL AND @original_supplier_address IS NULL)) AND [supplier_status] = @original_supplier_status">
                <DeleteParameters>
                    <asp:Parameter Name="original_supplier_id" Type="Int32" />
                    <asp:Parameter Name="original_supplier_name" Type="String" />
                    <asp:Parameter Name="original_supplier_cellNo" Type="String" />
                    <asp:Parameter Name="original_supplier_email" Type="String" />
                    <asp:Parameter Name="original_supplier_address" Type="String" />
                    <asp:Parameter Name="original_supplier_status" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="supplier_name" Type="String" />
                    <asp:Parameter Name="supplier_cellNo" Type="String" />
                    <asp:Parameter Name="supplier_email" Type="String" />
                    <asp:Parameter Name="supplier_address" Type="String" />
                    <asp:Parameter Name="supplier_status" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="supplier_name" Type="String" />
                    <asp:Parameter Name="supplier_cellNo" Type="String" />
                    <asp:Parameter Name="supplier_email" Type="String" />
                    <asp:Parameter Name="supplier_address" Type="String" />
                    <asp:Parameter Name="supplier_status" Type="String" />
                    <asp:Parameter Name="original_supplier_id" Type="Int32" />
                    <asp:Parameter Name="original_supplier_name" Type="String" />
                    <asp:Parameter Name="original_supplier_cellNo" Type="String" />
                    <asp:Parameter Name="original_supplier_email" Type="String" />
                    <asp:Parameter Name="original_supplier_address" Type="String" />
                    <asp:Parameter Name="original_supplier_status" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT supplier_id, supplier_name, supplier_cellNo, supplier_email, supplier_address, supplier_status FROM Supplier_tbl WHERE (supplier_name LIKE + @item + '%')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="item" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server"></asp:SqlDataSource>
        </div>
    </div>
    <div class="nc">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label1" runat="server" Text="Search Supplier:"></asp:Label>
        <asp:TextBox ID="TextBox1" AutoPostBack="true" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" />
</div>



    <div class="gridview-container">
        <asp:GridView ID="GridView1" ToolTip="First Click Edit,Then Enter Values In The Row" runat="server" CssClass="gridview gridview-spacing" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"  style="margin-right: 0" Width="1135px" AllowPaging="True" DataKeyNames="supplier_id" >
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="supplier_id" HeaderText="supplier_id" InsertVisible="False" ReadOnly="True" SortExpression="supplier_id" />
                <asp:BoundField DataField="supplier_name" HeaderText="supplier_name" SortExpression="supplier_name" />
                <asp:BoundField DataField="supplier_cellNo" HeaderText="supplier_cellNo" SortExpression="supplier_cellNo" />
                <asp:BoundField DataField="supplier_email" HeaderText="supplier_email" SortExpression="supplier_email" />
                <asp:BoundField DataField="supplier_address" HeaderText="supplier_address" SortExpression="supplier_address" />
                <asp:BoundField DataField="supplier_status" HeaderText="supplier_status" SortExpression="supplier_status" />
            </Columns>
        </asp:GridView>
        
    </div>
</asp:Content>
