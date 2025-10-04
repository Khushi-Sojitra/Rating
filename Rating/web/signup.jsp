<%@ page import="java.sql.*" %>
<%
    String msg = "";
    if(request.getParameter("submit") != null){
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String url = "jdbc:mysql://localhost:3306/captain";
        String dbUser = "root";
        String dbPass = ""; // your MySQL password

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPass);

            String checkUser = "SELECT * FROM user_accounts WHERE username=?";
            PreparedStatement ps1 = conn.prepareStatement(checkUser);
            ps1.setString(1, username);
            ResultSet rs = ps1.executeQuery();

            if(rs.next()){
                msg = "Username already exists!";
            } else {
                String sql = "INSERT INTO user_accounts (username, password) VALUES (?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);
                ps.executeUpdate();
                ps.close();
                rs.close();
                ps1.close();
                conn.close();

                response.sendRedirect("login.jsp"); // redirect to login after signup
                return;
            }

            rs.close();
            ps1.close();
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
  <title>Sign Up - Captain Food Rating System</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    body, html {
      height: 100%;
      margin: 0;
      font-family: 'Roboto', Arial, sans-serif;
    }
    .bg {
      background: url('https://img.freepik.com/premium-photo/flat-lay-delicious-food-arrangement_23-2148941569.jpg') no-repeat center center/cover;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
    }
    .bg::before {
      content: '';
      position: absolute;
      width: 100%;
      height: 100%;
      background-color: rgba(0,0,0,0.4); /* dark overlay for contrast */
      top: 0;
      left: 0;
      z-index: 1;
    }
    .overlay {
      position: relative;
      z-index: 2;
      display: flex;
      flex-direction: column;
      align-items: center;
      background-color: rgba(0, 0, 0, 0.75);
      padding: 40px;
      border-radius: 15px;
      text-align: center;
      gap: 15px;
      width: 350px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.4);
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
    .subtitle {
      color: #ddd;
      font-size: 14px;
      margin-bottom: 10px;
    }
    .input-field {
      width: 100%;
      padding: 12px;
      border-radius: 6px;
      border: none;
      font-size: 16px;
      background-color: rgba(255,255,255,0.1);
      color: white;
    }
    .input-field::placeholder {
      color: #eee;
    }
    .input-field:focus {
      outline: none;
      border: 2px solid #ff6b6b;
      background-color: rgba(255,255,255,0.15);
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
      transition: all 0.2s;
    }
    .btn:hover {
      background-color: #ff4b4b;
      transform: scale(1.02);
    }
    .msg {
      color: #ffdddd;
      font-size: 14px;
      margin-bottom: 10px;
    }
    a.back-link {
      color: #ff6b6b;
      text-decoration: none;
      font-weight: bold;
      margin-top: 10px;
      display: inline-block;
      transition: color 0.2s;
    }
    a.back-link:hover {
      color: #ff4b4b;
    }
    @media (max-width: 500px) {
      .overlay { width: 90%; padding: 30px; }
    }
  </style>
</head>
<body>

  <div class="bg">
    <div class="overlay">
    
      <h2>Create Your Account</h2>
      <p class="subtitle">Join now and start rating your meals!</p>

      <% if(!msg.isEmpty()) { %>
        <p class="msg"><%= msg %></p>
      <% } %>

      <form method="post" style="width:100%; display:flex; flex-direction:column; gap:15px;">
        <input type="text" name="username" placeholder="Username" class="input-field" required>
        <input type="password" name="password" placeholder="Password" class="input-field" required>
        <input type="submit" name="submit" value="Sign Up" class="btn">
      </form>

      <a href="login.jsp" class="back-link">Already have an account? Login</a>
    </div>
  </div>

</body>
</html>
