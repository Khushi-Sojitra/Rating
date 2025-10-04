<%@ page import="java.sql.*" %>
<%
    String msg = "";
    if (request.getParameter("login") != null) {
        String inputUser = request.getParameter("username");
        String inputPass = request.getParameter("password");

        String url = "jdbc:mysql://localhost:3306/captain";
        String dbUser = "root";
        String dbPass = ""; // your MySQL password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPass);

            String sql = "SELECT * FROM user_accounts WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, inputUser);
            ps.setString(2, inputPass); // ideally hash password if stored hashed
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                session.setAttribute("currentUser", inputUser);
                response.sendRedirect("index.jsp"); // redirect after successful login
                return;
            } else {
                msg = "Invalid username or password!";
            }

            rs.close();
            ps.close();
            conn.close();
        } catch(Exception e){
            msg = "Database Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - Captain Food Rating System</title>
  <style>
    body, html {
      height: 100%;
      margin: 0;
      font-family: Arial, sans-serif;
    }
    .bg {
      background: url('https://i.pinimg.com/736x/4e/50/fb/4e50fb6966f6d6fbc97e3baedd532791.jpg') no-repeat center center/cover;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .overlay {
      display: flex;
      flex-direction: column;
      align-items: center;
      background-color: rgba(0, 0, 0, 0.7);
      padding: 40px;
      border-radius: 15px;
      text-align: center;
      gap: 20px;
      width: 350px;
    }
    .overlay-logo {
      max-width: 120px;
      height: auto;
    }
    h2 {
      color: white;
      font-size: 28px;
      margin: 0;
    }
    .input-field {
      width: 100%;
      padding: 12px;
      border-radius: 6px;
      border: none;
      font-size: 16px;
    }
    .btn {
      background-color: #ff6b6b;
      color: white;
      padding: 12px 25px;
      font-size: 18px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      width: 100%;
    }
    .msg {
      color: #ffdddd;
      font-size: 14px;
    }
    a.back-link {
      color: #ff6b6b;
      text-decoration: none;
      font-weight: bold;
      margin-top: 10px;
      display: inline-block;
    }
  </style>
</head>
<body>

  <div class="bg">
    <div class="overlay">
      <h2>Login to Your Account</h2>

      <% if(!msg.isEmpty()) { %>
        <p class="msg"><%= msg %></p>
      <% } %>

      <form method="post" style="width:100%; display:flex; flex-direction:column; gap:15px;">
        <input type="text" name="username" placeholder="Username" class="input-field" required>
        <input type="password" name="password" placeholder="Password" class="input-field" required>
        <input type="submit" name="login" value="Login" class="btn">
      </form>

      <a href="signup.jsp" class="back-link">Don't have an account? Sign Up</a>
    </div>
  </div>

</body>
</html>
