import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back action
          },
        ),
        title: const Text(
          'Vị trí',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.my_location, color: Colors.red),
              title: const Text('Use Current Location'),
              onTap: () {
                // Handle current location
              },
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.red),
                    title: const Text('Home'),
                    subtitle: const Text(
                        'F-7, Kabir Enclave, Opp. AxisBank, Opp. Hdfc Bank, Bopal-Ghuma road, Ahmedabad'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.red),
                      onPressed: () {
                        // Handle edit location
                      },
                    ),
                  ),
                  // Container(
                  //   height: 200,
                  //   margin: EdgeInsets.symmetric(vertical: 10.0),
                  //   child: GoogleMap(
                  //     initialCameraPosition: CameraPosition(
                  //       target: LatLng(23.033863, 72.585022),
                  //       zoom: 15,
                  //     ),
                  //     markers: {
                  //       Marker(
                  //         markerId: MarkerId('home'),
                  //         position: LatLng(23.033863, 72.585022),
                  //         infoWindow: InfoWindow(title: 'Kabir Enclave Office'),
                  //       ),
                  //     },
                  //   ),
                  // ),
                  ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.red),
                    title: const Text('Thêm vị trí mới'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.red),
                      onPressed: () {
                        // Handle add new location
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
