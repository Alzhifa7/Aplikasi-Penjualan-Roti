<?php
$server = "localhost";
$user = "root";
$password = "";
$db = "sertifikasi_jmp";

// Membuat koneksi ke database
$connect = new mysqli($server, $user, $password, $db);

// Mengecek apakah koneksi berhasil
if ($connect->connect_error) {
    die(json_encode(["success" => false, "message" => "Koneksi gagal: " . $connect->connect_error]));
}

// Melakukan query ke tabel 'orders'
$result = $connect->query("SELECT * FROM orders");

// Mengecek apakah query berhasil
if ($result === false) {
    die(json_encode(["success" => false, "message" => "Query gagal: " . $connect->error]));
}

// Mengumpulkan data hasil query ke dalam array
$customers = array();
while ($row = $result->fetch_assoc()) {
    $customers[] = $row;
}

// Mengirimkan data sebagai JSON
header('Content-Type: application/json');
echo json_encode(["success" => true, "data" => $customers]);

// Menutup koneksi ke database
$connect->close();
?>
