<?php
// Include config file
require_once "db/config.php";
session_start();

function detectSQLInjection($input) {
    $patterns = [
        "/(\bUNION\b|\bSELECT\b|\bINSERT\b|\bDELETE\b|\bUPDATE\b|\bDROP\b|\bALTER\b)/i",
        "/(\bOR\b|\bAND\b)\s+\d+=\d+/i",
        "/(--|#|;|\*|\/\*)/",
        "/(xp_cmdshell|exec|sp_|dbo\.)/i"
    ];

    foreach ($patterns as $pattern) {
        if (preg_match($pattern, $input)) {
            return true;
        }
    }
    return false;
}

// Log SQL injection attempts
function logHackerAttempt($username, $ip) {
    $file = "hacker_logs.txt";
    $logEntry = date("Y-m-d H:i:s") . " - Suspicious login attempt from IP: $ip - Username: $username\n";
    file_put_contents($file, $logEntry, FILE_APPEND);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $password = $_POST["password"];
    $userIP = $_SERVER["REMOTE_ADDR"]; // Get the hacker's IP address

    // Check for SQL injection
    if (detectSQLInjection($username) || detectSQLInjection($password)) {
        logHackerAttempt($username, $userIP);
        echo "<script>alert('⚠️ WARNING: SQL Injection detected! Admin has been notified.');</script>";
    } else {
        // Secure login query using PDO
        $sql = "SELECT * FROM users WHERE username = :username";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['username' => $username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($password, $user['password'])) {
            $_SESSION["loggedin"] = true;
            $_SESSION["id"] = $user["id"];
            $_SESSION["username"] = $user["username"];
            $_SESSION["user_type"] = $user["user_type"];

            if ($user["user_type"] == "admin") {
                header("Location: admin/dashboard.php");
            } else {
                header("Location: user/home.php");
            }
            exit;
        } else {
            echo "Invalid username or password.";
        }
    }
}
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
                <div id="loginForm" class="mb-5">
                    <h2 class="text-center mb-4">Login</h2>
                    <?php
                    if (!empty($login_err)) {
                        echo '<div class="alert alert-danger">' . $login_err . '</div>';
                    }
                    ?>
                    <form action="" method="post">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" >
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" >
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
