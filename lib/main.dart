import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const TaxiHamraApp());

class TaxiHamraApp extends StatelessWidget {
  const TaxiHamraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1415),
      ),
      home: const TaxiHamraHome(),
    );
  }
}

class TaxiHamraHome extends StatefulWidget {
  const TaxiHamraHome({super.key});

  @override
  State<TaxiHamraHome> createState() => _TaxiHamraHomeState();
}

class _TaxiHamraHomeState extends State<TaxiHamraHome> {
  bool isSearching = false;
  
  // إحداثيات مركز مدينة فاس
  static const CameraPosition _fesCenter = CameraPosition(
    target: LatLng(34.0333, -5.0000),
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طاكسي حمرا - فاس'),
        leading: const Icon(Icons.account_balance_wallet, color: Colors.amber),
        actions: [
          IconButton(
            icon: const Icon(Icons.warning, color: Colors.red),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال نداء SOS')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // الخريطة الحقيقية التي ستعمل بمفتاحك
          const GoogleMap(
            initialCameraPosition: _fesCenter,
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),

          // واجهة التحكم السفلية
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.85),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isSearching ? 'جاري البحث في فاس...' : 'أين تريد الذهاب؟',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD90429),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () => setState(() => isSearching = !isSearching),
                      child: Text(
                        isSearching ? 'إلغاء الطلب' : 'اطلب تاكسي الآن',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
