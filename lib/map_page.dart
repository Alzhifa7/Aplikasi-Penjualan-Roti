import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'models/customer.dart'; // Import the Customer model

class MapPage extends StatelessWidget {
  final Customer customer; // Use Customer instead of Pelanggan

  const MapPage({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final LatLng location =
        LatLng(customer.gpsLat, customer.gpsLng); // Update to use customer

    final Marker marker = Marker(
      markerId: MarkerId('marker_${customer.id}'), // Update to use customer
      position: location,
      infoWindow: InfoWindow(
        title: customer.nama, // Update to use customer
        snippet: customer.alamat, // Update to use customer
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Pembeli'), // Title can be changed to suit context
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 15,
        ),
        markers: {marker},
        onMapCreated: (GoogleMapController controller) {
          // Optionally, you can store the controller for future use
        },
      ),
    );
  }
}
