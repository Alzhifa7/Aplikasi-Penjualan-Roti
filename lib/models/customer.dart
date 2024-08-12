class Customer {
  final int id;
  final String nama;
  final String email;
  final String noTelepon;
  final String alamat;
  final int rotiId;
  final String waktuPembelian;
  final double gpsLat;
  final double gpsLng;
  final int jumlahPesanan;
  final String totalHarga;

  Customer({
    required this.id,
    required this.nama,
    required this.email,
    required this.noTelepon,
    required this.alamat,
    required this.rotiId,
    required this.waktuPembelian,
    required this.gpsLat,
    required this.gpsLng,
    required this.jumlahPesanan,
    required this.totalHarga,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      nama: json['nama'] ?? 'Unknown',
      email: json['email'] ?? 'Unknown',
      noTelepon: json['no_telepon'] ?? 'Unknown',
      alamat: json['alamat'] ?? 'Unknown',
      rotiId: json['roti_id'] is int
          ? json['roti_id']
          : int.tryParse(json['roti_id'].toString()) ?? 0,
      waktuPembelian: json['waktu_pembelian'] ?? 'N/A',
      gpsLat: json['gpsLat'] is double
          ? json['gpsLat']
          : double.tryParse(json['gpsLat'].toString()) ?? 0.0,
      gpsLng: json['gpsLng'] is double
          ? json['gpsLng']
          : double.tryParse(json['gpsLng'].toString()) ?? 0.0,
      jumlahPesanan: json['jumlah_pesanan'] is int
          ? json['jumlah_pesanan']
          : int.tryParse(json['jumlah_pesanan'].toString()) ?? 0,
      totalHarga: json['total_harga'].toString(), // Diubah menjadi String
    );
  }
}
