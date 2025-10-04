<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Thank You!</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

  <!-- Google Fonts & Bootstrap -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>

  <style>
    body {
      margin: 0;
      padding: 0;
      background: linear-gradient(to right, #f2709c, #ff9472);
      font-family: 'Inter', sans-serif;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #fff;
      text-align: center;
      animation: fadeIn 1.5s ease-in;
    }

    .thank-you-box {
      background: rgba(255, 255, 255, 0.1);
      padding: 40px;
      border-radius: 20px;
      backdrop-filter: blur(10px);
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
      max-width: 500px;
      width: 90%;
    }

    .thank-you-box h2 {
      font-size: 2.2rem;
      font-weight: 700;
    }

    .checkmark {
      font-size: 4rem;
      color: #00ffae;
      animation: pop 0.6s ease-out forwards;
      margin-bottom: 20px;
    }

    .btn-return {
      background-color: #fff;
      color: #ff7a00;
      font-weight: 600;
      border: none;
      border-radius: 10px;
      padding: 12px 24px;
      margin-top: 30px;
      transition: 0.3s ease;
    }

    .btn-return:hover {
      background-color: #ff7a00;
      color: #fff;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes pop {
      0% { transform: scale(0.5); opacity: 0; }
      100% { transform: scale(1); opacity: 1; }
    }
  </style>
</head>
<body>

  <div class="thank-you-box">
    <div class="checkmark"></div>
    <h2>Thank You for Your Feedback!</h2>
    <p>Your review has been successfully submitted.</p>

  </div>

</body>
</html>