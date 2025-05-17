<%@ Page Title="Welcome to Style Cutz Barber Shop" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="StyleCutzBarberShopWebApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .photo-gallery-section {
            padding: 50px 20px;
            text-align: center;
            margin-bottom: 2px; 
            background-color: rgba(0, 0, 0, 0.8); 
            color: white; 
            border-radius: 8px; 
        }

        /* Enhanced Group box styling */
        .group-box {
            display: inline-block;
            padding: 30px 40px;
            border-radius: 20px;
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.7), rgba(50, 50, 50, 0.7)); /* Gradient background */
            border: 2px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            margin-bottom: 10px;
            text-align: center;
            color: #f1f1f1;
            max-width: 600px;
        }

        .group-box h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .group-box p {
            font-size: 1.5em;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Star Rating */
        .stars {
            margin: 15px 0;
            font-size: 1.5em; /* Adjust the star size */
            color: #ffd700; /* Gold color for stars */
        }

        .stars span {
            padding: 0 2px;
        }

        .gallery {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }

        .gallery-item {
            width: 300px;
            overflow: hidden;
        }

        .gallery-item img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            transition: transform 0.3s;
        }

        .gallery-item img:hover {
            transform: scale(1.05);
        }

        .section {
            position: relative;
            color: white;
            text-align: center;
            padding: 100px 20px;
            margin-bottom: 2px;
        }

        .section img {
            position: absolute;
            top: 0%;
            left: 50%;
            transform: translateX(-50%);
            width: 116%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
            opacity: 50;
        }

        .section h2, .section p {
            z-index: 1;
            font-family: Arial, sans-serif;
        }

        .section h2 {
            font-size: 3em;
            margin-bottom: 20px;
        }

        .section p {
            font-size: 1.5em;
        }

        .btn {
            background-color: #007aff;
            color: white;
            padding: 15px 30px;
            border-radius: 25px;
            border: none;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            display: block;
            margin: 20px auto;
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

        /* Comment Styles */
        .comment {
            display: block; /* Ensure comments are visible */
            opacity: 1;
            margin: 10px 0; /* Spacing between comments */
            color: white; /* Comment text color */
        }

        .stars {
            color: #ffd700; /* Gold color for stars */
        }

        .filled-star,
        .empty-star,
        .half-star {
            display: inline-block; /* Ensure all stars are inline */
            vertical-align: middle; /* Align stars to the middle */
            width: 20px; /* Fixed width to maintain uniformity */
            height: 20px; /* Ensure height is set */
            color: lightgray; /* Default color for empty stars */
            position: relative; /* Needed for half-star positioning */
        }

        .filled-star {
            color: gold; /* Color for filled stars */
        }

        .half-star:before {
            content: "★"; /* Fill the half star */
            color: gold; /* Color for filled half star */
            position: absolute;
            left: 0; /* Align to the left */
            width: 50%; /* Fill half of the star */
            overflow: hidden;
        }
        .comment {
        opacity: 0;
        position: absolute;
        transition: opacity 0.5s, transform 0.5s;
        transform: translateX(100%);
        }

        .comment.active {
            display: block;
            opacity: 1;
            transform: translateX(0);
        }

    </style>
    <!-- Hero Section -->
    <div class="section" id="Hero" style="height: 100vh;">
        <img src="/Images/temp.jpg" alt="Barbershop Background">
        <div class="group-box">
            <h1>Welcome to Style Cutz</h1>
            <p>Your premier barbershop experience</p>
            <!-- 5-Star Rating -->
            <div class="stars">
                <span>&#9733;</span> <!-- Filled star -->
                <span>&#9733;</span> <!-- Filled star -->
                <span>&#9733;</span> <!-- Filled star -->
                <span>&#9733;</span> <!-- Filled star -->
                <span>&#9734;</span> <!-- Filled star -->
            </div>
            <p style="font-size: 1.5em; color: #ffd700; margin-top: 5px;">4.2/5</p>
        </div>
        <asp:Button ID="btnBookNow" runat="server" Text="Book an Appointment" CssClass="btn" OnClick="BookNow_Click" />
    </div>
    
    <!-- Comments Section -->
    <!--
    <div class="comment-section" style="padding: 20px; text-align: center; background-color: #2e2e2e; border-radius: 8px; height: 50vh; display: flex; align-items: center; justify-content: center;margin-bottom: 2px">
    <asp:PlaceHolder ID="commentsPlaceholder" runat="server">
        <div class="comment" style="display: none; max-width: 80%; margin: 0 auto; text-align: center;">
            <p style="color: #ffffff;"><strong>John Doe</strong>: Great experience! Will definitely come back!</p>
            <div class="stars" style="display: flex; justify-content: center;">
                <span class="filled-star" style="color: gold; font-size: 20px;">&#9733;</span>
                <span class="filled-star" style="color: gold; font-size: 20px;">&#9733;</span>
                <span class="filled-star" style="color: gold; font-size: 20px;">&#9733;</span>
                <span class="filled-star" style="color: gold; font-size: 20px;">&#9733;</span>
                <span class="empty-star" style="color: gold; font-size: 20px;">&#9734;</span>
            </div>
        </div>
        <div class="comment" style="display: none; max-width: 80%; margin: 0 auto; text-align: center;">
            <p style="color: #ffffff;"><strong>Jane Smith</strong>: Love my new haircut! Highly recommend!</p>
            <div class="stars" style="display: flex; justify-content: center;">
                <span class="filled-star" style="color: gold; font-size: 20px;">&#9733;</span>
                <span class="filled-star" style="color: gold; font-size: 20px;">&#9733;</span>
                <span class="filled-star" style="color: gold; font-size: 20px;">&#9733;</span>
                <span class="filled-star" style="color: gold; font-size: 20px;">&#9733;</span>
                <span class="filled-star" style="color: gold; font-size: 20px;">&#9733;</span>
            </div>
        </div>
        <!-- Add more comments here if needed -->
    <!--
    </asp:PlaceHolder>
</div>
    -->

    <!-- Services Section -->
    <div class="section" style="padding: 100px 20px;">
        <img src="/Images/Fade.jpg" alt="Barbershop Services">
        <h2>Our Services</h2>
        <div class="services-grid" style="display: flex; justify-content: center; flex-wrap: wrap; gap: 20px;">
            <div class="service" style="border: 1px solid #ccc; padding: 20px; width: 300px; background-color: rgba(0, 0, 0, 0.5); color: white;">
                <h3>Haircuts</h3>
                <p>Classic and modern styles tailored to you.</p>
            </div>
            <div class="service" style="border: 1px solid #ccc; padding: 20px; width: 300px; background-color: rgba(0, 0, 0, 0.5); color: white;">
                <h3>Beard Trimming</h3>
                <p>Expert grooming for a polished look.</p>
            </div>
            <div class="service" style="border: 1px solid #ccc; padding: 20px; width: 300px; background-color: rgba(0, 0, 0, 0.5); color: white;">
                <h3>Shaving</h3>
                <p>Experience the luxury of a traditional shave.</p>
            </div>
            <div class="service" style="border: 1px solid #ccc; padding: 20px; width: 300px; background-color: rgba(0, 0, 0, 0.5); color: white;">
                <h3>Hair Coloring</h3>
                <p>Bring your style to life with vibrant colors.</p>
            </div>
        </div>
        <asp:Button ID="vServiceBtn" runat="server" CssClass="btn" Text="View All Services" OnClick="vServiceBtn_Click"/>
    </div>

    <!-- About Us Section -->
    <div class="section" style="padding: 100px 20px;">
        <img src="/Images/S-Curl.jpg" alt="About Us">
        <h2>About Us</h2>
        <div>
            <p style="max-width: 600px; margin: auto;">
               At Style Cutz, we pride ourselves on providing top-notch barbering services in a friendly and welcoming environment. Our skilled barbers are dedicated to ensuring you leave our shop looking and feeling your best.
            </p>
       </div>
        <div>
            <br />
            <br />
            <br />
        </div>
        <div>
            <asp:Button ID="btnLearnMore"  CssClass="btn" runat="server" Text="Learn More" OnClick="LearnMore_Click" />
        </div> 
    </div>

    <!-- Gallery Section -->
    <!--
    <div class="photo-gallery-section">
        <h2 style="font-size: 2.5em;">Our Gallery</h2>
        <p>Check out some of our work!</p>
        <div class="gallery">
            <div class="gallery-item">
                <img src="/Images/Brush cut.jpg" alt="Haircut 1" />
            </div>
            <div class="gallery-item">
                <img src="/Images/BuzzCut.jpg" alt="Haircut 2" />
            </div>
        </div>
    </div>
    -->
    <!-- Contact Section -->
    <div class="section" style="padding: 100px 20px;">
        <img src="/Images/Quiff.jpg" alt="Contact Us">
        <h2>Get In Touch</h2>
        <p>Have questions? We're here to help!</p>
        <asp:Button ID="btnContact" runat="server" Text="Contact Us" CssClass="btn" OnClick="Contact_Click" />
    </div>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        let currentIndex = 0;
        const comments = document.querySelectorAll('.comment');

        function showComment(index) {
            comments.forEach((comment, i) => {
                comment.classList.remove('active');
                comment.style.display = 'none';
            });
            comments[index].style.display = 'block';
            comments[index].classList.add('active');
        }

        function nextComment() {
            currentIndex = (currentIndex + 1) % comments.length;
            showComment(currentIndex);
        }

        // Initialize the first comment
        showComment(currentIndex);

        // Change comment every 3 seconds
        setInterval(nextComment, 3000);
    });
</script>
</asp:Content>
