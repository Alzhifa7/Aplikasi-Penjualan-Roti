import 'package:flutter/material.dart';
import 'package:sertifikasi_jmp/home_page.dart'; // Make sure to import HomePage

class ReceiptPage extends StatelessWidget {
  final String nama;
  final String email;
  final String noTelepon;
  final String alamat;
  final String rotiName;
  final int jumlahPesanan;
  final String totalHarga; // Changed to String

  const ReceiptPage({
    super.key,
    required this.nama,
    required this.email,
    required this.noTelepon,
    required this.alamat,
    required this.rotiName,
    required this.jumlahPesanan,
    required this.totalHarga, // Changed to String
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bukti Transaksi"),
        backgroundColor: const Color.fromARGB(255, 209, 197, 188), // Optional: Set AppBar color
      ),
      body: SingleChildScrollView( // Add SingleChildScrollView to handle overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center( // Center the "Transaksi Berhasil, Terimakasih" text
                child: Text(
                  "Transaksi Berhasil",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(Icons.person, "Nama", nama),
                      _buildDetailRow(Icons.email, "Email", email),
                      _buildDetailRow(Icons.phone, "No Telepon", noTelepon),
                      _buildDetailRow(Icons.home, "Alamat", alamat),
                      _buildDetailRow(Icons.cake, "Nama Produk", rotiName),
                      _buildDetailRow(Icons.format_list_numbered, "Jumlah Pesanan", jumlahPesanan.toString()),
                      _buildDetailRow(Icons.attach_money, "Total Harga", totalHarga), // Changed to String
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false, // Remove all pages in the stack
                    );
                  },
                  child: const Text("Kembali ke Halaman Utama"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$title: $value",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
