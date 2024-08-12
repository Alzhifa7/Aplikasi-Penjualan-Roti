<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "sertifikasi_jmp"; // Ganti dengan nama database Anda

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Cek koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Ambil data dari POST request
$nama = $_POST['nama'];
$email = $_POST['email'];
$no_telepon = $_POST['no_telepon'];
$alamat = $_POST['alamat'];
$gpsLat = $_POST['gpsLat'];
$gpsLng = $_POST['gpsLng'];
$roti_id = $_POST['roti_id'];
$jumlah_pesanan = $_POST['jumlah_pesanan'];
$total_harga = $_POST['total_harga'];

// Validasi input GPS
if (!is_numeric($gpsLat) || !is_numeric($gpsLng)) {
    die("Koordinat GPS tidak valid");
}

// Logging nilai GPS yang diterima
error_log("GPS Coordinates received: Lat = $gpsLat, Lng = $gpsLng");

// SQL untuk insert data
$sql = "INSERT INTO orders (nama, email, no_telepon, alamat, gpsLat, gpsLng, roti_id, jumlah_pesanan, total_harga)
VALUES ('$nama', '$email', '$no_telepon', '$alamat', '$gpsLat', '$gpsLng', '$roti_id', '$jumlah_pesanan', '$total_harga')";

if ($conn->query($sql) === TRUE) {
    echo "Pembelian berhasil";
} else {
    echo "Pembelian gagal: " . $conn->error;
}

// Tutup koneksi
$conn->close();

?>
