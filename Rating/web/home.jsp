<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String role = request.getParameter("role");
  if (role == null) role = "employee"; // fallback
  String redirectPage = role.equals("guest") ? "guest.jsp" : "rating.jsp";
  String titleText = role.equals("guest") ? "Welcome Guest Reviewer" : "Welcome Employee Reviewer";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Captain Food Rating System</title>
  <style>
    body, html {
      height: 100%;
      font-family: Arial, sans-serif;
      margin: 0;
    }

    .bg {
      background-image: url('https://images.unsplash.com/photo-1546069901-eacef0df6022');
      height: 100%;
      background-position: center;
      background-repeat: no-repeat;
      background-size: cover;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .overlay {
      background-color: rgba(0, 0, 0, 0.5);
      padding: 40px 60px;
      border-radius: 15px;
      text-align: center;
    }

    h2 {
      color: white;
      font-size: 36px;
      margin-bottom: 20px;
    }

    .btn {
      background-color: #ff6b6b;
      color: white;
      border: none;
      padding: 15px 30px;
      font-size: 18px;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .btn:hover {
      background-color: #ff3c3c;
    }
  </style>
</head>
<body>

  <div class="bg">
    <div class="overlay">
      <h2><%= titleText %></h2>
      <a href="<%= redirectPage %>">
        <button class="btn">Start your review</button>
      </a>
    </div>
  </div>

</body>
</html>
