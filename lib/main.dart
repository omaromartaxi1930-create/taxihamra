import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

void main() {
  runApp(const TaxiHamraApp());
}

class TaxiHamraApp extends StatelessWidget {
  const TaxiHamraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'طاكسي حمرا - فاس',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE53935), Color(0xFFFFB300)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.local_taxi, size: 80, color: Color(0xFFE53935)),
              ),
            ),
            const SizedBox(height: 20),
            const Text("طاكسي حمرا - فاس", 
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 60),
            _buildMainButton(context, "طلب طاكسي (زبون)", Icons.person_pin_circle, const CustomerMapScreen()),
            const SizedBox(height: 15),
            _buildMainButton(context, "دخول المهنيين (شيفور)", Icons.directions_car, const DriverOrdersScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(BuildContext context, String title, IconData icon, Widget nextScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen)),
        icon: Icon(icon, color: Colors.white),
        label: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A1A1A),
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

class CustomerMapScreen extends StatefulWidget {
  const CustomerMapScreen({super.key});
  @override
  State<CustomerMapScreen> createState() => _CustomerMapScreenState();
}

class _CustomerMapScreenState extends State<CustomerMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _fesInitialPos = CameraPosition(target: LatLng(34.0333, -5.0000), zoom: 14);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("حدد موقعك"), backgroundColor: Colors.red[900], foregroundColor: Colors.white),
      body: GoogleMap(
        initialCameraPosition: _fesInitialPos,
        onMapCreated: (GoogleMapController controller) => _controller.complete(controller),
        myLocationEnabled: true,
      ),
    );
  }
}

class DriverOrdersScreen extends StatefulWidget {
  const DriverOrdersScreen({super.key});
  @override
  State<DriverOrdersScreen> createState() => _DriverOrdersScreenState();
}

class _DriverOrdersScreenState extends State<DriverOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("طلبات مدينة فاس"), backgroundColor: Colors.black, foregroundColor: Colors.white),
      body: const Center(child: Text("في انتظار الطلبات...")),
    );
  }
}
