<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="StyleCutzBarberShopWebApp.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .about-page {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0 auto;
            padding: 20px;
            max-width: 800px;
        }

        h2, h3 {
            color: #333;
            font-weight: 600;
        }

        ul {
            list-style-type: none;
            padding-left: 0;
        }

        .team-section {
            display: flex;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .team-member {
            flex: 1 1 30%; /* Adjusts size to fit */
            margin: 10px;
            text-align: center;
        }

        .team-member img {
            width: 100%;
            height: auto;
            border-radius: 50%; /* Circular images */
        }

        .team-member h4 {
            margin-top: 10px;
            color: #007bff; /* Adjust for brand color */
        }

        .team-member p {
            color: #555;
        }

    </style>
    <div class="about-page">
        <h2>About Us</h2>
        <p>Welcome to Style Cutz Barber Shop, where style meets precision. Our mission is to provide our clients with an unparalleled grooming experience that enhances their confidence and expresses their individuality.</p>
        
        <h3>Our Story</h3>
        <p>Founded in 2005, Style Cutz has quickly become a trusted name in grooming. Our team of experienced barbers is dedicated to staying current with the latest trends and techniques to deliver the perfect haircut for every client.</p>

        <h3>What We Offer</h3>
        <ul>
            <li>Men’s Haircuts & Grooming</li>
            <li>Beard Trimming & Styling</li>
            <li>Facial Treatments</li>
            <li>Customized Hair Products</li>
        </ul>

        <h3>Our Values</h3>
        <p>At Style Cutz, we believe in:</p>
        <ul>
            <li><strong>Quality:</strong> We use only the best products and techniques.</li>
            <li><strong>Customer Satisfaction:</strong> Your happiness is our top priority.</li>
            <li><strong>Community:</strong> We support our local community and give back where we can.</li>
        </ul>
    </div>
</asp:Content>
