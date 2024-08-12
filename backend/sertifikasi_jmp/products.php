<?php
// Set error reporting for debugging purposes
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$servername = "localhost";
$username = "root"; // Change this to your database username
$password = ""; // Change this to your database password
$dbname = "sertifikasi_jmp";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to fetch all products
$sql = "SELECT * FROM products";
$result = $conn->query($sql);

// Initialize an array to hold products
$products = array();

if ($result) {
    // Check if there are any rows in the result
    if ($result->num_rows > 0) {
        // Fetch all rows as associative arrays
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
    } else {
        // No rows found, return an empty array
        $products = [];
    }
} else {
    // Query failed, return an error message
    $products = ['error' => 'SQL query failed: ' . $conn->error];
}

// Set the content type to JSON
header('Content-Type: application/json');

// Output the JSON encoded data
echo json_encode($products);

// Close the connection
$conn->close();
?>
