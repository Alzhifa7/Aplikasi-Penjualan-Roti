import 'dart:convert'; // Untuk memproses data JSON
import 'package:flutter/material.dart'; // Paket Flutter untuk komponen UI
import 'package:http/http.dart' as http; // Paket untuk melakukan HTTP request
import 'package:d_info/d_info.dart'; // Paket untuk menampilkan toast (pesan kecil)

// Halaman pendaftaran pengguna
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState(); // Changed from _RegisterPageState
}

class RegisterPageState extends State<RegisterPage> { // Removed the underscore to make it public
  // Controller untuk field username dan password
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool _obscurePassword = true;

  // Fungsi untuk mengirim data pendaftaran ke server
  Future<void> register() async {
    // Validasi: Pastikan username dan password tidak kosong
    if (controllerUsername.text.isEmpty || controllerPassword.text.isEmpty) {
      // Menampilkan pesan error jika ada input yang kosong
      DInfo.toastError('Username and Password must not be empty');
      return; // Menghentikan fungsi jika input tidak valid
    }

    // URL endpoint server untuk registrasi
    String url = 'http://192.168.193.227/sertifikasi_jmp/user/register.php';
    
    // Melakukan HTTP POST request dengan data username dan password
    var response = await http.post(Uri.parse(url), body: {
      'username': controllerUsername.text,
      'password': controllerPassword.text,
    });

    // Mengurai response dari server
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    // Menangani response dari server
    if (!mounted) return; // Check if the widget is still mounted before using context

    if (responseBody['success']) {
      // Menampilkan pesan sukses jika registrasi berhasil
      DInfo.toastSuccess('Success Register');
      // Kembali ke halaman sebelumnya
      Navigator.pop(context);
    } else {
      // Menampilkan pesan error jika username sudah ada
      if (responseBody['message'] == 'username') {
        DInfo.toastError('Username has already exist');
      } else {
        // Menampilkan pesan error jika registrasi gagal
        DInfo.toastError('Failed Register');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 197, 188), // Warna latar belakang halaman
      body: Padding(
        padding: const EdgeInsets.all(20), // Padding untuk konten halaman
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Menyusun konten di tengah-tengah
          children: [
            // Teks judul
            Text(
              'Register Page',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 30),

            // Input username dengan ikon
            TextField(
              controller: controllerUsername,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Input password dengan ikon dan toggle visibilitas
            TextField(
              controller: controllerPassword,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                hintText: 'Password',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol register
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => register(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F4E37), // Warna tombol register
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white, // Warna teks tombol register
                    fontWeight: FontWeight.bold, // Teks menjadi bold
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol login
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF6F4E37), // Warna teks tombol login
                    fontWeight: FontWeight.bold, // Teks menjadi bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
