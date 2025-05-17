<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ratings and reviews.aspx.cs" Inherits="StyleCutzBarberShopWebApp.Ratings_and_reviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Comment Section Styles */
        .comment-section {
            padding: 20px;
            text-align: center;
            background-color: white; /* Updated background color */
            border-radius: 8px;
            margin-bottom: 20px;
            color: black; /* Text color */
        }

        .comment {
            display: flex;
            flex-direction: column; /* Stack rows vertically */
            align-items: flex-start; /* Align rows to the left */
            margin: 10px auto;
            padding: 15px;
            border-bottom: 1px solid #ccc;
            max-width: 600px;
            word-wrap: break-word; /* Ensures long words wrap */
        }

        .comment:last-child {
            border-bottom: none;
        }

        .comment-header {
            display: flex;
            align-items: center; /* Align icon and name vertically */
            margin-bottom: 5px; /* Space below the header row */
        }

        .icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #007aff; /* Icon background color */
            color: white; /* Initial letter color */
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2em;
            flex-shrink: 0;
            margin-right: 10px; /* Spacing between icon and name */
        }

        .comment-content {
            text-align: left;
            word-wrap: break-word; /* Break long words */
            white-space: normal; /* Allow wrapping */
        }

        .comment-stars {
            display: flex;
            justify-content: space-between; /* Align stars and date on the same row */
            align-items: center;
            width: 100%;
            margin-bottom: 5px; /* Adds spacing below stars and date */
        }

        .stars {
            color: #ffd700;
            font-size: 1.5em;
        }

        .date {
            font-size: 0.9em;
            color: #666; /* Slightly muted color for the date */
        }
        /* Style for the dropdown list */
        .styled-dropdown {
            width: 200px; /* Adjust width */
            padding: 10px 15px;
            border-radius: 25px; /* Rounded corners */
            font-size: 14px; /* Adjust font size */
            font-family: Arial, sans-serif; /* Professional font */
            background-color: #f5f5f5; /* Light background color */
            border: 1px solid #ccc; /* Light border */
            color: #333; /* Text color */
            transition: background-color 0.3s, border-color 0.3s;
        }

        /* Hover effect */
        .styled-dropdown:hover {
            background-color: #eaeaea; /* Slightly darker background on hover */
            border-color: #aaa; /* Darker border on hover */
        }

        /* Focus effect */
        .styled-dropdown:focus {
            background-color: #fff; /* White background on focus */
            border-color: #5c9fdb; /* Border color for focus */
            outline: none; /* Remove default focus outline */
        }

        /* Style for selected item */
        .styled-dropdown option:checked {
            color: #333; /* Text color for selected option */
            background-color: #ddd; /* Light background for selected item */
        }

    </style>
    <div style="margin-left:35%;margin-top:3%">
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" CssClass="styled-dropdown">
            <asp:ListItem>Newest</asp:ListItem>
            <asp:ListItem>Oldest</asp:ListItem>
            <asp:ListItem>Default</asp:ListItem>
        </asp:DropDownList>
    </div>

    <div class="comment-section">
        <!-- Placeholder for dynamically generated comments -->
        <asp:PlaceHolder ID="commentsPlaceholder" runat="server"></asp:PlaceHolder>
    </div>
</asp:Content>
