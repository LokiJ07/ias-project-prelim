<?php
session_start();
require_once "./db/config.php"; // Database connection

if (!isset($conn)) {
    die("Database connection failed. Check config.php.");
}

$message = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $password = $_POST["password"];

    // 🚨 **Fully Vulnerable SQL Query (Allows SQL Injection)**
    $query = "SELECT * FROM users WHERE username = '$username' AND password = '$password'";
    $result = $conn->query($query);

    if ($result && $result->num_rows > 0) {
        $user = $result->fetch_assoc();
        $_SESSION["username"] = $user["username"];
        $_SESSION["user_type"] = $user["user_type"];

        // Log login time
        $user_id = $user["id"];
        $conn->query("INSERT INTO login_logs (user_id, login_time) VALUES ($user_id, NOW())");

        // 🚨 **Fake SQL Injection Detection**
        if (stripos($username, "'") !== false || stripos($username, "OR") !== false || stripos($password, "'") !== false) {
            echo "<script>
                alert('⚠ WARNING: You have logged in as Hacked Admin!');
                window.location.href = 'admin/dashboard.php';
            </script>";
        } else {
            echo "<script>window.location.href = 'dashboard.php';</script>";
        }
        exit();
    } else {
        $message = "<p class='error'>Login Failed</p>";
    }
}

// Close connection
$conn->close();
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font: 14px sans-serif; }
        .wrapper { width: 360px; padding: 20px; margin: 0 auto; margin-top: 50px; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <!-- Login Form -->
                <div id="loginForm" class="mb-5">
                    <h2 class="text-center mb-4">Login</h2>
                    <?php
                    if (!empty($login_err)) {
                        echo '<div class="alert alert-danger">' . $login_err . '</div>';
                    }
                    ?>
                   <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
    <div class="mb-3">
        <label for="loginUsername" class="form-label">Username</label>
        <input type="text" name="username" class="form-control <?php echo (!empty($username_err)) ? 'is-invalid' : ''; ?>" id="loginUsername" placeholder="Enter username" value="<?php echo isset($username) ? htmlspecialchars($username) : ''; ?>">
        <span class="invalid-feedback"><?php echo $username_err ?? ''; ?></span>
    </div>
    <div class="mb-3">
        <label for="loginPassword" class="form-label">Password</label>
        <input type="password" name="password" class="form-control <?php echo (!empty($password_err)) ? 'is-invalid' : ''; ?>" id="loginPassword" placeholder="Enter password">
        <span class="invalid-feedback"><?php echo $password_err ?? ''; ?></span>
    </div>
    <button type="submit" class="btn btn-primary w-100">Login</button>
    <p class="text-center mt-3">Don't have an account? <a href="register.php">Sign up</a></p>
</form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>