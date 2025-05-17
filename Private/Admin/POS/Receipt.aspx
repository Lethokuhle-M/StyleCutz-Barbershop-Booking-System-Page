<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Receipt.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Private.Admin.POS.Receipt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* General Styling for Invoice */
        .invoice-container {
            width: 70%;
            margin: 30px auto;
            padding: 25px;
            border: 2px solid #007aff;
            border-radius: 12px;
            background-color: #f9f9f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .invoice-header {
            text-align: center;
            padding-bottom: 15px;
            margin-bottom: 25px;
            border-bottom: 2px solid #0056b3;
        }

        .invoice-header h3 {
            font-size: 2em;
            color: #0056b3;
            margin: 0;
        }

        .invoice-details {
            margin-bottom: 25px;
            line-height: 1.6;
        }

        .invoice-section {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .invoice-section div {
            flex: 1;
        }

        .invoice-section p {
            font-size: 1.1em;
            color: #333;
            margin: 5px 0;
        }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            font-size: 1em;
        }

        .invoice-table th {
            background-color: #007aff;
            color: #fff;
            padding: 12px;
            text-align: left;
            border-bottom: 2px solid #0056b3;
        }

        .invoice-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .total-row td {
            font-weight: bold;
            font-size: 1.2em;
            background-color: #e6f2ff;
        }

        .invoice-footer {
            text-align: center;
            font-size: 0.9em;
            color: #666;
            border-top: 1px solid #ddd;
            padding-top: 15px;
            margin-top: 20px;
        }

        .btn {
            display: block;
            margin: 20px auto;
            background-color: #007aff;
            color: white;
            padding: 12px 20px;
            border-radius: 25px;
            border: none;
            font-size: 1.1em;
            cursor: pointer;
            text-align: center;
            text-transform: uppercase;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .btn:hover {
            background-color: #005bb5;
            transform: scale(1.05);
        }
    </style>

    <!-- Appointment Receipt Panel -->
    <asp:Panel ID="pnlReceipt" runat="server" Visible="false" CssClass="invoice-container">
        <div class="invoice-header">
            <h3>Appointment Receipt</h3>
        </div>

        <div class="invoice-details">
            <div class="invoice-section">
                <div>
                    <p><strong>Client Name:</strong> <asp:Label ID="lblClientName" runat="server"></asp:Label></p>
                    <p><strong>Appointment Date:</strong> <asp:Label ID="lblAppointmentDate" runat="server"></asp:Label></p>
                </div>
                <div>
                    <p><strong>Barber:</strong> <asp:Label ID="barber" runat="server"></asp:Label></p>
                    <p><strong>Time:</strong> <asp:Label ID="time" runat="server"></asp:Label></p>
                </div>
            </div>

            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>Service Name</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><asp:Label ID="lblServiceName" runat="server"></asp:Label></td>
                        <td><asp:Label ID="Label1" runat="server"></asp:Label></td>
                    </tr>
                    <tr class="total-row">
                        <td>Total</td>
                        <td><asp:Label ID="Label2" runat="server"></asp:Label></td>
                    </tr>
                </tbody>
            </table>

            <!-- Payment Method Section -->
            <div>
                <p><strong>Payment Method:</strong> <asp:Label ID="lblPaymentMethod" runat="server"></asp:Label></p>
               
            </div>
        </div>

        <div class="invoice-footer">
            <p>Thank you for choosing Style Cutz Barber Shop.</p>
            <p>If you have any questions about this receipt, please contact us at (123) 456-7890.</p>
        </div>
    </asp:Panel>

    <!-- Student Invoice Panel -->
    <asp:Panel ID="Panel1" runat="server" Visible="false" CssClass="invoice-container">
        <div class="invoice-header">
            <h3>Appointment Receipt</h3>
        </div>

        <div class="invoice-details">
            <div class="invoice-section">
                <div>
                    <p><strong>Client Name:</strong> <asp:Label ID="Label3" runat="server"></asp:Label></p>
                    <p><strong>Appointment Date:</strong> <asp:Label ID="Label5" runat="server"></asp:Label></p>
                </div>
                <div>
                    <p><strong>Barber:</strong> <asp:Label ID="Label4" runat="server"></asp:Label></p>
                    <p><strong>Time:</strong> <asp:Label ID="Label6" runat="server"></asp:Label></p>
                </div>
            </div>

            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>Service Name</th>
                        <th>Student Number</th>
                        <th>Student Rate</th>
                        <th>Amount </th>
                    </tr>
                </thead>
                <tbody>
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
                </tbody>
            </table>

            <!-- Payment Method Section -->
            <div>
                <p><strong>Payment Method:</strong> <asp:Label ID="lblStudentPaymentMethod" runat="server"></asp:Label></p>
                <p>&nbsp;</p>
            </div>
        </div>

        <div class="invoice-footer">
            <p>Thank you for choosing Style Cutz Barber Shop.</p>
            <p>If you have any questions about this invoice, please contact us at (123) 456-7890.</p>
        </div>
    </asp:Panel>

    <div>
        <asp:Button ID="btn1" runat="server" CssClass="btn" OnClick="btn1_Click" Text="Done" />
    </div>
</asp:Content>
