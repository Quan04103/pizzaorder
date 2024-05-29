import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back action
          },
        ),
        title: Text(
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
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.my_location, color: Colors.red),
              title: Text('Use Current Location'),
              onTap: () {
                // Handle current location
              },
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.red),
                    title: Text('Home'),
                    subtitle: Text(
                        'F-7, Kabir Enclave, Opp. AxisBank, Opp. Hdfc Bank, Bopal-Ghuma road, Ahmedabad'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.red),
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
                    leading: Icon(Icons.location_on, color: Colors.red),
                    title: Text('Thêm vị trí mới'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.red),
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
