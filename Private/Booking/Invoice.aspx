<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Booking.Invoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* General Invoice Styling */
        .invoice-container {
            width: 80%;                       /* Width adjustment */
            margin: 20px auto;                 /* Center the container */
            padding: 20px;
            border: 1px solid #ddd;            /* Border around the invoice */
            border-radius: 10px;               /* Rounded corners */
            background-color: #fff;            /* White background */
            font-family: Arial, sans-serif;    /* Professional font */
        }

        .invoice-header {
            text-align: center;
            border-bottom: 2px solid #007aff;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .invoice-header h3 {
            font-size: 1.8em;
            color: #333;
        }

        .invoice-details {
            width: 100%;
            margin-bottom: 20px;
        }

        .invoice-details p {
            margin: 5px 0;
            font-size: 1em;
            line-height: 1.5;
        }

        .invoice-section {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
        }

        .invoice-section div {
            width: 48%;
        }

        .invoice-section p {
            font-size: 1.1em;
            color: #333;
        }

        /* Table for amount details */
        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .invoice-table th, .invoice-table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        .invoice-table th {
            background-color: #f4f4f4;
            font-size: 1.1em;
        }

        .total-row td {
            font-weight: bold;
            font-size: 1.2em;
        }

        /* Footer styling */
        .invoice-footer {
            text-align: center;
            font-size: 0.9em;
            color: #666;
            border-top: 1px solid #ddd;
            padding-top: 10px;
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
    </style>

    <!-- Invoice Panel -->
    <asp:Panel ID="pnlReceipt" runat="server" Visible="false" CssClass="invoice-container">
        <div class="invoice-header">
            <h3>Appointment Invoice</h3>
        </div>
        
        <div class="invoice-details">
            <div class="invoice-section">
                <div>
                    <p><strong>Client Name:</strong> <asp:Label ID="lblClientName" runat="server"></asp:Label></p>
                    <p><strong>Appointment Date:</strong> <asp:Label ID="lblAppointmentDate" runat="server"></asp:Label></p>
                    <p><strong></strong> <asp:Label ID="Label12" runat="server"></asp:Label></p>
                </div>
                <div>
                    <p><strong>Barber:</strong> <asp:Label ID="barber" runat="server"></asp:Label></p>
                    <p><strong>Time:</strong> <asp:Label ID="time" runat="server"></asp:Label></p>
                </div>
            </div>
            
            <table class="invoice-table">
                <tr>
                    <th>Service Name</th>
                    <th>Amount Due</th>
                </tr>
                <tr>
                    <td><asp:Label ID="lblServiceName" runat="server"></asp:Label></td>
                    <td><asp:Label ID="Label1" runat="server"></asp:Label></td>
                </tr>
                <tr class="total-row">
                    <td>Total</td>
                    <td><asp:Label ID="Label2" runat="server"></asp:Label></td>
                </tr>
            </table>
        </div>

        <div class="invoice-footer">
            <p>Thank you for choosing Style Cutz Barber Shop.</p>
            <p>If you have any questions about this invoice, please contact us at (123) 456-7890.</p>
        </div>
    </asp:Panel>

    <!-- Student Invoice Panel (for special cases) -->
    <asp:Panel ID="Panel1" runat="server" Visible="false" CssClass="invoice-container">
        <div class="invoice-header">
            <h3>Appointment Invoice</h3>
        </div>
        
        <div class="invoice-details">
            <div class="invoice-section">
                <div>
                    <p><strong>Client Name:</strong> <asp:Label ID="Label3" runat="server"></asp:Label></p>
                    <p><strong>Appointment Date:</strong> <asp:Label ID="Label5" runat="server"></asp:Label></p>
                    <p><strong></strong> <asp:Label ID="Label13" runat="server"></asp:Label></p>
                </div>
                <div>
                    <p><strong>Barber:</strong> <asp:Label ID="Label4" runat="server"></asp:Label></p>
                    <p><strong>Time:</strong> <asp:Label ID="Label6" runat="server"></asp:Label></p>
                </div>
            </div>
            
            <table class="invoice-table">
                <tr>
                    <th>Service Name</th>
                    <th>Student Number</th>
                    <th>Student Rate</th>
                    <th>Amount Due</th>
                </tr>
                <tr>
                    <td><asp:Label ID="Label7" runat="server"></asp:Label></td>
                    <td><asp:Label ID="Label9" runat="server"></asp:Label></td>
                    <td><asp:Label ID="Label10" runat="server"></asp:Label></td>
                    <td><asp:Label ID="Label8" runat="server"></asp:Label></td>
                </tr>
                <tr class="total-row">
                    <td colspan="3">Total</td>
                    <td><asp:Label ID="Label11" runat="server"></asp:Label></td>
                </tr>
            </table>
        </div>

        <div class="invoice-footer">
            <p>Thank you for choosing Style Cutz Barber Shop.</p>
            <p>If you have any questions about this invoice, please contact us at (123) 456-7890.</p>
        </div>
    </asp:Panel>

    <div>
         <asp:Button ID="btn1" runat="server" CssClass="btn" OnClick="btn1_Click" Text="Done" Width="119px" />
    </div>
    <script type="text/javascript">
        function PrintReceipt() {
            // Get the label values
            var s = document.getElementById('<%= Label12.ClientID %>').textContent.trim();
        var a = document.getElementById('<%= Label13.ClientID %>').textContent.trim();
        var panelToPrint;

        console.log("Label12:", s); // Debugging output
        console.log("Label13:", a); // Debugging output

        // Check if Label12 or Label13 values are specific for printing
        if (s === "N/A") {
            panelToPrint = document.getElementById('<%= pnlReceipt.ClientID %>').innerHTML;
        } else {
            panelToPrint = document.getElementById('<%= Panel1.ClientID %>').innerHTML;
            }

            // Open a new window and print the selected panel
            var printWindow = window.open('', '', 'height=600,width=800');
            printWindow.document.write('<html><head><title>Receipt</title>');
            printWindow.document.write('</head><body>');
            printWindow.document.write(panelToPrint);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        }
    </script>



</asp:Content>
