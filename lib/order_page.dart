import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'receipt_page.dart'; // Import ReceiptPage

class OrderPage extends StatefulWidget {
  final String rotiId;
  final String rotiName;
  final double rotiPrice;

  const OrderPage({
    super.key,
    required this.rotiId,
    required this.rotiName,
    required this.rotiPrice,
  });

  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  String? nama, email, noTelepon, alamat;
  int jumlahPesanan = 1; // Default quantity is 1
  double? gpsLat, gpsLng;
  final Logger _logger = Logger();

  Future<void> getGPSLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Layanan lokasi tidak aktif")),
          );
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Izin lokasi ditolak")),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Izin lokasi tidak dapat dipulihkan")),
          );
        }
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          gpsLat = position.latitude;
          gpsLng = position.longitude;
        });
      }
    } catch (e) {
      _logger.e("Error getting GPS location: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error getting GPS location")),
        );
      }
    }
  }

  Future<void> submitForm() async {
    await getGPSLocation();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String totalHarga = (widget.rotiPrice * jumlahPesanan).toStringAsFixed(2);

      try {
        final response = await http.post(
          Uri.parse('http://192.168.193.227/sertifikasi_jmp/beli_roti.php'),
          body: {
            "nama": nama!,
            "email": email!,
            "no_telepon": noTelepon!,
            "alamat": alamat!,
            "gpsLat": gpsLat.toString(),
            "gpsLng": gpsLng.toString(),
            "roti_id": widget.rotiId.toString(),
            "jumlah_pesanan": jumlahPesanan.toString(),
            "total_harga": totalHarga,
          },
        );

        if (response.statusCode == 200) {
          final result = response.body.trim();
          _logger.i("Response from server: $result");
          if (result.contains("Pembelian berhasil")) {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReceiptPage(
                    nama: nama!,
                    email: email!,
                    noTelepon: noTelepon!,
                    alamat: alamat!,
                    rotiName: widget.rotiName,
                    jumlahPesanan: jumlahPesanan,
                    totalHarga: totalHarga, // Changed to String
                  ),
                ),
              );
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Pembelian gagal: $result")),
              );
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Pembelian gagal dengan status code: ${response.statusCode}")),
            );
          }
        }
      } catch (e) {
        _logger.e("Error submitting form: $e");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error submitting form")),
          );
        }
      }
    }
  }

  void incrementQuantity() {
    setState(() {
      jumlahPesanan++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (jumlahPesanan > 1) {
        jumlahPesanan--;
      }
    });
  }

  void showTransactionDetails() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String totalHarga = (widget.rotiPrice * jumlahPesanan).toStringAsFixed(2);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Detail Transaksi Pembelian"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama: $nama"),
                Text("Email: $email"),
                Text("No Telepon: $noTelepon"),
                Text("Alamat: $alamat"),
                Text("Nama Produk: ${widget.rotiName}"),
                Text("Jumlah Pesanan: $jumlahPesanan"),
                Text("Total Harga: Rp$totalHarga"), // Changed to String
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text("Kembali"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  submitForm(); // Submit the form after user confirms
                },
                child: const Text("Konfirmasi"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Proses Pembelian"),
        backgroundColor: const Color.fromARGB(255, 209, 197, 188),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => nama = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan nama Anda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => email = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan email Anda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'No Telepon',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => noTelepon = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan nomor telepon Anda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                  onSaved: (value) => alamat = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan alamat Anda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: decrementQuantity,
                    ),
                    Text(
                      jumlahPesanan.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: incrementQuantity,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: showTransactionDetails, // Show transaction details first
                    child: const Text(
                      'Kirim',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
