import 'package:flutter/material.dart';
import 'order_page.dart';

class DetailProduk extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price; // This remains a String as it's passed as a String
  final String description;
  final String rotiId;

  const DetailProduk({super.key, 
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    required this.rotiId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 209, 197, 188),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250.0,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Text(
                        'Gambar tidak tersedia',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Rp$price",
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 40, 197, 12),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Deskripsi :",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 100),
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.greenAccent.withOpacity(0.3),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(
                          rotiId: rotiId,
                          rotiName: name, // Pass the name of the bread
                          rotiPrice: double.parse(
                              price), // Convert price to double and pass
                        ),
                      ),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: const Text(
                      "Beli",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
