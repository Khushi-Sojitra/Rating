<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submitted Ratings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0px 0px 10px #ccc;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #ff7a00;
            color: white;
        }
        h2 {
            text-align: center;
            color: #333;
        }
    </style>
</head>
<body>
    <h2>All Submitted Ratings</h2>
    <table>
        <tr>
            <th>Employee Name</th>
            <th>Code</th>
            <th>Department</th>
            <th>Food Quality</th>
            <th>Taste</th>
            <th>Food Taste</th>
            <th>Liked Dish</th>
            <th>Suggest Menu</th>
            <th>Issues</th>
            <th>Variety</th>
            <th>Cleanliness</th>
            <th>Speed</th>
            <th>Staff</th>
            <th>Seating</th>
            <th>Availability</th>
            <th>Review</th>
            <th>Recommend</th>
            <th>Overall</th>
            <th>Comments</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM employee_feedback");
                //ResultSet rs = stmt.executeQuery("SELECT * FROM guest_feedback");//

                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("EmployeeName") %></td>
            <td><%= rs.getString("EmployeeCode") %></td>
            <td><%= rs.getString("EmployeeDep") %></td>
            <td><%= rs.getInt("foodQuality") %></td>
            <td><%= rs.getInt("taste") %></td>
            <td><%= rs.getString("Foodtaste") %></td>
            <td><%= rs.getString("Fooddish") %></td>
            <td><%= rs.getString("Foodmenu") %></td>
            <td><%= rs.getString("Food") %></td>
            <td><%= rs.getInt("variety") %></td>
            <td><%= rs.getInt("cleanliness") %></td>
            <td><%= rs.getInt("servingSpeed") %></td>
            <td><%= rs.getInt("staffBehaviour") %></td>
            <td><%= rs.getInt("seating") %></td>
            <td><%= rs.getInt("availability") %></td>
            <td><%= rs.getString("Foodreview") %></td>
            <td><%= rs.getString("cafe") %></td>
            <td><%= rs.getInt("value") %></td>
            <td><%= rs.getString("comments") %></td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                con.close();
            } catch(Exception e) {
                out.println("<tr><td colspan='19' style='color:red'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>
