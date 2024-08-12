import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/customer.dart';
import 'map_page.dart'; // Import the MapPage

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  AdminPageState createState() => AdminPageState(); // Ubah nama state di sini
}

class AdminPageState extends State<AdminPage> {
  late Future<List<Customer>> futureCustomers;
  final ApiService apiService =
      ApiService('http://192.168.193.227/sertifikasi_jmp');

  @override
  void initState() {
    super.initState();
    futureCustomers = apiService.getCustomer();
  }

  void _navigateToMapPage(BuildContext context, Customer customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(customer: customer),
      ),
    );
  }

  void _showCustomerDetails(BuildContext context, Customer customer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detail Pembelian', style: TextStyle(fontSize: 18.0)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailTile(Icons.person, 'Nama:', customer.nama),
                _buildDetailTile(Icons.email, 'Email:', customer.email),
                _buildDetailTile(Icons.phone, 'Telepon:', customer.noTelepon),
                _buildDetailTile(Icons.cake, 'Roti ID:', '${customer.rotiId}'),
                _buildDetailTile(Icons.shopping_cart, 'Jumlah Pesanan:',
                    '${customer.jumlahPesanan}'),
                _buildDetailTile(Icons.attach_money, 'Total Harga:',
                    'Rp${customer.totalHarga}'),
                GestureDetector(
                  onTap: () => _navigateToMapPage(context, customer),
                  child: _buildDetailTile(
                      Icons.location_on, 'Alamat:', customer.alamat,
                      textColor: Colors.blue, iconColor: Colors.blue),
                ),
                _buildDetailTile(
                    Icons.access_time, 'Waktu:', customer.waktuPembelian,
                    fontSize: 12.0),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup', style: TextStyle(fontSize: 14.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailTile(IconData icon, String label, String value,
      {Color textColor = Colors.black,
      Color iconColor = Colors.blue,
      double fontSize = 12.0}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Row(
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: fontSize, color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pembeli'),
        backgroundColor: const Color.fromARGB(255, 209, 197, 188),
      ),
      body: Container(
        color: Colors.blueGrey[50],
        child: FutureBuilder<List<Customer>>(
          future: futureCustomers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada data'));
            } else {
              List<Customer> customerList = snapshot.data!;
              return ListView.builder(
                itemCount: customerList.length,
                itemBuilder: (context, index) {
                  final customer = customerList[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.white,
                    elevation: 4.0,
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.blue),
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        customer.nama,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Waktu: ${customer.waktuPembelian}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      trailing:
                          const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                      onTap: () => _showCustomerDetails(context, customer),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
