<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%! 
    // Safe parser: avoid NumberFormatException if null/empty
    private int parseIntOrZero(String val) {
        if (val == null || val.trim().isEmpty()) return 0;
        return Integer.parseInt(val.trim());
    }
%>

<%
    // Get current logged-in employee name from session
    String EmployeeName = "";
    if (session.getAttribute("currentUser") != null) {
        EmployeeName = session.getAttribute("currentUser").toString();
    }

    // Initialize a message variable for success/error feedback
    String msg = "";

    if ("post".equalsIgnoreCase(request.getMethod())) {
        try {
            // Collect form parameters safely
            String EmployeeCode = request.getParameter("EmployeeCode");
            String EmployeeDep = request.getParameter("EmployeeDep");
            int foodQuality   = parseIntOrZero(request.getParameter("foodQuality"));
            int taste         = parseIntOrZero(request.getParameter("taste"));
            String Foodtaste  = request.getParameter("Foodtaste");
            String Fooddish   = request.getParameter("Fooddish");
            String Foodmenu   = request.getParameter("Foodmenu");
            String Food       = request.getParameter("Food");
            int variety       = parseIntOrZero(request.getParameter("variety"));
            int cleanliness   = parseIntOrZero(request.getParameter("cleanliness"));
            int servingSpeed  = parseIntOrZero(request.getParameter("servingSpeed"));
            int staffBehaviour= parseIntOrZero(request.getParameter("staffBehaviour"));
            int seating       = parseIntOrZero(request.getParameter("seating"));
            int availability  = parseIntOrZero(request.getParameter("availability"));
            String Foodreview = request.getParameter("Foodreview");
            String cafe       = request.getParameter("cafe");
            int value         = parseIntOrZero(request.getParameter("value"));
            String comments   = request.getParameter("comments");

            // Connect to database
            String url = "jdbc:mysql://localhost:3306/captain?zeroDateTimeBehavior=CONVERT_TO_NULL";
            String user = "root";
            String password = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // Insert statement
            String sql = "INSERT INTO employee_feedback (EmployeeName, EmployeeCode, EmployeeDep, foodQuality, taste, Foodtaste, Fooddish, Foodmenu, Food, variety, cleanliness, servingSpeed, staffBehaviour, seating, availability, Foodreview, cafe, value, comments) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, EmployeeName);
            stmt.setString(2, EmployeeCode);
            stmt.setString(3, EmployeeDep);
            stmt.setInt(4, foodQuality);
            stmt.setInt(5, taste);
            stmt.setString(6, Foodtaste);
            stmt.setString(7, Fooddish);
            stmt.setString(8, Foodmenu);
            stmt.setString(9, Food);
            stmt.setInt(10, variety);
            stmt.setInt(11, cleanliness);
            stmt.setInt(12, servingSpeed);
            stmt.setInt(13, staffBehaviour);
            stmt.setInt(14, seating);
            stmt.setInt(15, availability);
            stmt.setString(16, Foodreview);
            stmt.setString(17, cafe);
            stmt.setInt(18, value);
            stmt.setString(19, comments);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                msg = "Feedback submitted successfully!";
            } else {
                msg = "Failed to submit feedback.";
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            msg = "Database Error: " + e.getMessage();
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Rate a Dish</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<style>
/* Your existing CSS from before */
body { 
    margin:0; 
    padding:0; 
    min-height:100vh; 
    background:url('https://thumbs.dreamstime.com/b/colorful-celebration-indian-cuisine-stunning-aerial-view-diverse-delicious-platter-traditional-feast-your-eyes-373441312.jpg') no-repeat center center fixed; 
    background-size:cover; 
    display:flex; 
    justify-content:center; 
    align-items:flex-start; 
    font-family:'Inter',sans-serif; 
    padding-top:40px; }

.rating-card { 
    background: rgba(255,255,255,0.85); 
    border-radius:16px; 
    padding:40px 30px; 
    width:100%; 
    max-width:600px; 
    box-shadow:0 8px 30px rgba(0,0,0,0.2);}

.rating-card h2 { 
    font-weight:700;
    color:#343a40;
    margin-bottom:25px;
    text-align:center; }

.form-section { 
    border-radius:12px; 
    margin-bottom:2rem; 
    padding:2rem; 
    color:white; 
    position:relative; 
    overflow:hidden;}

.employee-section, .food-section, .serving-section, .cafe-section { background:#fbe3e8;}

.section-heading { 
    position:relative; 
    font-size:1.5rem; 
    margin-bottom:1.5rem; 
    color:black; 
    font-weight:bold; 
    text-align:center;}

.form-label { font-weight:600; color:#212529; }
.form-select, .form-control { border-radius:8px; }

.btn-submit { background:#ff7a00; color:white; font-weight:800; font-size:18px; padding:12px; border:none; border-radius:8px; width:100%; margin-top:20px; transition:0.3s ease; }
.btn-submit:hover { background:#e86900; }

.star-rating { display:flex; gap:10px; font-size:2rem; cursor:pointer;}
.star { color:#ccc; transition:color 0.2s ease; }
.star.selected, .star.hovered { color:gold; }

.btn-link-style { display:block; text-align:center; background:#ff7a00; color:white; font-weight:800; font-size:18px; padding:12px; border-radius:8px; margin-top:15px; text-decoration:none; transition:background-color 0.3s ease; }
.btn-link-style:hover { background-color:#e86900; color:white; text-decoration:none; }

.feedback-msg { text-align:center; margin-bottom:20px; font-weight:bold; color:green; }
</style>
</head>
<body>

<form class="rating-card" action="" method="post">
<h2>Describe Your Meal Experience</h2>

<% if (!msg.isEmpty()) { %>
    <div class="feedback-msg"><%= msg %></div>
<% } %>

<!-- EMPLOYEE DETAILS -->
<div class="form-section employee-section">
    <h3 class="section-heading">EMPLOYEE DETAILS</h3>
    <div class="mb-3">
      <label class="form-label">Employee Name</label>
      <input type="text" name="EmployeeName" class="form-control" value="<%= EmployeeName %>" readonly required>
    </div>
    <div class="mb-3">
      <label class="form-label">Employee Code</label>
      <input type="text" name="EmployeeCode" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Employee Department</label>
      <select name="EmployeeDep" class="form-select" required>
        <option value="" disabled selected>Select department</option>
        <option value="It/Edp">It/Edp</option>
        <option value="Sourcing">Sourcing</option>
        <option value="Production">Production</option>
        <option value="Marketing">Marketing</option>
      </select>
    </div>
</div>

     <!-- FOOD RATINGS -->
    <div class="form-section food-section">
      <h3 class="section-heading">FOOD RATINGS</h3>
      <div class="mb-3">
        <label class="form-label d-block">1. Is the food usually served hot and fresh?</label>
        <div id="foodQualityRating" class="star-rating">
          <span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span>
        </div>
        <input type="hidden" name="foodQuality" id="foodQualityInput" required>
      </div>

      <div class="mb-3">
        <label class="form-label d-block">2. How consistent is the taste of food on different days?</label>
        <div id="tasteRating" class="star-rating">
          <span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span>
        </div>
        <input type="hidden" name="taste" id="tasteInput" required>
      </div>

      <div class="mb-3">
        <label class="form-label">3. Describe the food taste (e.g., Dal Bati)</label>
        <input type="text" name="Foodtaste" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label">4. Any dish you liked recently?</label>
        <input type="text" name="Fooddish" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label">5. Any dishes to add to the menu?</label>
        <input type="text" name="Foodmenu" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label">6. Any food taste/quality issues?</label>
        <input type="text" name="Food" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label d-block">7. Variety in the weekly menu?</label>
        <div id="varietyRating" class="star-rating">
          <span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span>
        </div>
        <input type="hidden" name="variety" id="varietyInput" required>
      </div>

      <div class="mb-3">
        <label class="form-label d-block">8. Cleanliness of dining area?</label>
        <div id="cleanlinessRating" class="star-rating">
          <span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span>
        </div>
        <input type="hidden" name="cleanliness" id="cleanlinessInput" required>
      </div>

      <div class="mb-3">
        <label class="form-label d-block">9. Food availability during lunch?</label>
        <div id="servingSpeedRating" class="star-rating">
          <span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span>
        </div>
        <input type="hidden" name="servingSpeed" id="servingSpeedInput" required>
      </div>
    </div>

    <!-- SERVING RATINGS -->
    <div class="form-section serving-section">
      <h3 class="section-heading">SERVING & STAFF</h3>

      <div class="mb-3">
        <label class="form-label d-block">1. Is the seating arrangement maintained?</label>
        <div id="staffBehaviourRating" class="star-rating">
          <span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span>
        </div>
        <input type="hidden" name="staffBehaviour" id="staffBehaviourInput" required>
      </div>

      <div class="mb-3">
        <label class="form-label d-block">2. Staff behavior satisfactory?</label>
        <div id="seatingRating" class="star-rating">
          <span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span>
        </div>
        <input type="hidden" name="seating" id="seatingInput" required>
      </div>

      <div class="mb-3">
        <label class="form-label d-block">3. Overall satisfaction with serving?</label>
        <div id="availabilityRating" class="star-rating">
          <span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span>
        </div>
        <input type="hidden" name="availability" id="availabilityInput" required>
      </div>
    </div>

    <!-- OVERALL CAFETERIA -->
    <div class="form-section cafe-section">
      <h3 class="section-heading">OVERALL CAFETERIA</h3>

      <div class="mb-3">
        <label class="form-label">1. What did you like most about food service?</label>
        <input type="text" name="Foodreview" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label">2. Recommend cafeteria to new employee?</label>
        <select name="cafe" class="form-select" required>
          <option value="" disabled selected>Select option</option>
          <option value="yes">Yes</option>
          <option value="no">No</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label d-block">3. Rate overall taste of food:</label>
        <div id="valueRating" class="star-rating">
          <span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span><span class="star">&#9733;</span>
        </div>
        <input type="hidden" name="value" id="valueInput" required>
      </div>
    </div>

    <!-- SUGGESTIONS -->
    <div class="form-section employee-section">
      <h3 class="section-heading">SUGGESTIONS</h3>
      <div class="mb-3">
        <label class="form-label">Additional Comments</label>
        <textarea name="comments" rows="3" class="form-control" placeholder="What did you love or dislike?" required></textarea>
      </div>
    </div>

    <!-- Final Buttons -->
    <button type="submit" class="btn-submit">Submit Review</button>
    <a href="index.jsp" class="btn-link-style">Back to Home</a>
</form>

<script>
// ⭐ Keep star rating system
function setupStarRating(containerId, inputId) {
  const container = document.getElementById(containerId);
  const stars = container.querySelectorAll(".star");
  const input = document.getElementById(inputId);

  stars.forEach((star, index) => {
    star.addEventListener("click", () => {
      const rating = index + 1;
      input.value = rating;
      updateStars(rating);
    });
    star.addEventListener("mouseover", () => { updateStars(index + 1, true); });
    star.addEventListener("mouseout", () => { updateStars(parseInt(input.value)); });
  });

  function updateStars(rating, isHover=false) {
    stars.forEach((star,i)=>{ 
        star.classList.remove("selected","hovered"); 
        if(i<rating){ star.classList.add(isHover?"hovered":"selected"); } 
    });
  }
}

setupStarRating("foodQualityRating", "foodQualityInput");
setupStarRating("tasteRating", "tasteInput");
setupStarRating("varietyRating", "varietyInput");
setupStarRating("cleanlinessRating", "cleanlinessInput");
setupStarRating("servingSpeedRating", "servingSpeedInput");
setupStarRating("staffBehaviourRating", "staffBehaviourInput");
setupStarRating("seatingRating", "seatingInput");
setupStarRating("availabilityRating", "availabilityInput");
setupStarRating("valueRating", "valueInput");

// ✅ Prevent submit if any rating is empty
document.querySelector("form").addEventListener("submit", function(e) {
  let requiredInputs = document.querySelectorAll("input[type=hidden][required]");
  for (let input of requiredInputs) {
    if (!input.value) {
      alert("⚠️ Please give a rating for all required fields before submitting.");
      e.preventDefault();
      return false;
    }
  }
});
</script>

</body>
</html>
