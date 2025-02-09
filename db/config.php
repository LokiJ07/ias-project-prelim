<?php
$host = "localhost";
$user = "root"; // Change if necessary
$pass = ""; // Change if necessary
$dbname = "enterprise_system";

// Create connection
$conn = new mysqli($host, $user, $pass, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
