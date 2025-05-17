<%@ Page Title="Select Barber" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SelectBarber.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Booking.BookAppointment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            background-color: #f4f4f4; /* Light gray background */
            font-family: 'Arial', sans-serif; /* Clean sans-serif font */
        }

        h1 {
            text-align: center;
            font-size: 2.5em; 
            margin: 30px 0; 
            color: #333; 
        }

        .listview {
            display: flex; 
            flex-wrap: wrap; 
            justify-content: center; /* Center the items */
            margin: 0 auto; /* Center the list */
            padding: 20px; 
        }

        .list-item {
            text-align: center; 
            margin: 15px; /* Space around each item */
            border-radius: 10px; /* Rounded corners */
            background-color: #fff; /* White background for containers */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            overflow: hidden; /* Ensure no overflow */
            transition: transform 0.2s; /* Smooth scale effect */
            width: 22%; /* Adjust width for four items per row */
        }

        .list-item:hover {
            transform: scale(1.05); /* Scale effect on hover */
        }

        .list-item img {
            width: 100%; /* Full width for image */
            height: auto; /* Maintain aspect ratio */
            object-fit: cover; /* Cover the container */
        }

        .service-name {
            font-size: 1.1em; 
            font-weight: bold; 
            margin-top: 10px; 
        }

        .service-price {
            font-size: 1em; 
            color: #777; 
            margin-top: 5px; /* Space between name and price */
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

        .details-view {
            width: 80%; /* Increased width */
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

        .select-barber-heading {
            font-size: 24px; /* Font size for the heading */
            font-weight: bold; /* Make the text bold */
            color: #343a40; /* Color to match your theme */
            margin-bottom: 20px; /* Space between the heading and the ListView */
            text-align: center; /* Center align the heading */
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
    </style>

    <h1 class="select-barber-heading">Select The Barber</h1>

    <asp:DetailsView ID="DetailsView1" runat="server" CssClass="details-view" AutoGenerateRows="False" DataKeyNames="customer_id" DataSourceID="SqlDataSource3">
        <Fields>
            <asp:BoundField DataField="customer_id" HeaderText="Customer ID" InsertVisible="False" ReadOnly="True" SortExpression="customer_id" />
            <asp:BoundField DataField="customer_name" HeaderText="Name" SortExpression="customer_name" />
            <asp:BoundField DataField="customer_cellNo" HeaderText="Cell No" SortExpression="customer_cellNo" />
            <asp:BoundField DataField="customer_email" HeaderText="Email" SortExpression="customer_email" />
            <asp:BoundField DataField="customer_address" HeaderText="Address" SortExpression="customer_address" />
            <asp:BoundField DataField="student_number" HeaderText="Student Number" SortExpression="student_number" />
            <asp:BoundField DataField="date_of_birth" HeaderText="Date of Birth" SortExpression="date_of_birth" />
        </Fields>
    </asp:DetailsView>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT [customer_id], [customer_name], [customer_cellNo], [customer_email], [customer_address], [student_number], [date_of_birth] FROM [Customer_tbl] WHERE ([customer_email] = @customer_email)">
        <SelectParameters>
            <asp:Parameter DefaultValue="@email" Name="customer_email" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="listview">
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="ListView1_ItemCommand">
            <ItemTemplate>
                <div class="list-item">
                    <img src='<%# "/Images/" + Eval("employee_name") + ".jpg?v=" + DateTime.Now.Ticks %>' alt='<%# Eval("employee_name") %>' />
                    <div class="service-name">
                        <asp:Label ID="lblBarberName" runat="server" Text='<%# Eval("employee_name") %>'></asp:Label>
                    </div>
                    <div class="service-price">
                        <asp:Label ID="lblBarberCell" runat="server" Text='<%# Eval("employee_cellNo") %>'></asp:Label>
                    </div>
                    <div class="service-price">
                        <asp:Label ID="lblBarberEmail" runat="server" Text='<%# Eval("employee_email") %>'></asp:Label>
                    </div>
                    <div class="service-price">
                        <asp:Label ID="lblBarberGender" runat="server" Text='<%# Eval("empoyee_gender") %>'></asp:Label>
                    </div>
                    <asp:LinkButton ID="SelectButton" runat="server" Text="Select" CommandName="Select" CommandArgument='<%# Eval("employee_id") %>' CssClass="btn" />
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>

    <div style="display: flex; justify-content: space-between; width: 100%; padding: 10px;">
        <asp:Button ID="Button1" runat="server" OnClick="btn2_Click" CssClass="btn" Text="Previous" Width="119px" Style="text-align:center" />
        <asp:Button ID="btn1" runat="server" OnClick="btn1_Click" CssClass="btn" Text="Next" Width="119px" Style="text-align:center" />
    </div>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:G7Pmb2024ConnectionString %>" SelectCommand="SELECT [employee_id], [employee_name], [employee_cellNo], [employee_email], [empoyee_gender] FROM [Employee_tbl] WHERE ([employee_position] = @employee_position)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Barber" Name="employee_position" Type="String" />
        </SelectParameters>
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
