<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .contact-page {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0 auto;
            padding: 20px;
            max-width: 700px;
        }

        h2, h3 {
            color: #333;
            font-weight: 600;
        }

        .contact-info, .contact-email, .contact-form {
            margin-bottom: 30px;
        }

        .contact-info p, .contact-email p {
            font-size: 16px;
            color: #555;
        }

        .contact-info i, .contact-email i {
            color: #007bff;
            margin-right: 10px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

    </style>
    <div class="contact-page">
        <h2>Contact Us</h2>
        
        <!-- Address Section -->
        <div class="contact-info">
            <h3>Visit Us</h3>
            <p><i class="fas fa-map-marker-alt"></i> Shop 51(next to Supersavers, The Mall @Scottsville)</p>
            <p><i class="fas fa-map-marker-alt"></i> 50 Durban Road /Alon Patton Rd</p>
            <p><i class="fas fa-map-marker-alt"></i> Pietermaritzburg 3201.</p>
            <p><i class="fas fa-phone"></i> <abbr title="Phone">P:</abbr> 0646292914</p>
        </div>

        <!-- Email Section -->
        <div class="contact-email">
            <h3>Email Us</h3>
            <p><i class="fas fa-envelope"></i> <strong>Stylecuts:</strong> 
                <a href="mailto:Stylecutsbarbershop@gmail.com" target="_blank">Stylecutsbarbershop@gmail.com</a>
            </p>
        </div>

    </div>
</asp:Content>

