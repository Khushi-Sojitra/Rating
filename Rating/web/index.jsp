<!-- WebContent/index.jsp -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Captain Food Rating System</title>
  <style>
    body, html {
      height: 100%;
      margin: 0;
      font-family: Arial, sans-serif;
    }
    .bg {
      background: url('https://static.vecteezy.com/system/resources/thumbnails/036/804/355/small/ai-generated-assorted-indian-food-on-dark-wooden-background-free-photo.jpg') no-repeat center center/cover;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .overlay {
      display: flex;
      flex-direction: column;
      align-items: center;
      background-color: rgba(0, 0, 0, 0.6);
      padding: 40px;
      border-radius: 15px;
      text-align: center;
      gap: 20px;
    }
    .overlay-logo {
      max-width: 150px;
      height: auto;
    }
    h2 {
      color: white;
      font-size: 36px;
      margin: 0;
    }
    .btn {
      background-color: #ff6b6b;
      color: white;
      padding: 15px 30px;
      font-size: 18px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      margin: 0 10px;
    }
  </style>
</head>
<body>

  <div class="bg">
    <div class="overlay">
      
      <h2>CAPTAIN FOOD RATING SYSTEM</h2>

      <div>
        <!-- Pass role as query parameter -->
        <a href="home.jsp?role=employee"><button class="btn">Start Your Review as Employee</button></a>
        <a href="home.jsp?role=guest"><button class="btn">Start Your Review as Guest</button></a>
      </div>
    </div>
  </div>

</body>
</html>
