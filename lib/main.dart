import 'package:flutter/material.dart';

void main() => runApp(const TaxiHamraApp());

class TaxiHamraApp extends StatelessWidget {
  const TaxiHamraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFD90429),
        scaffoldBackgroundColor: const Color(0xFF1A1415),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false;
  double balance = 450.50; // رصيد افتراضي بالدرهم

  // وظيفة إظهار المحفظة (Wallet Bottom Sheet)
  void _showWallet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1415),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(25),
        height: 300,
        child: Column(
          children: [
            Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 25),
            const Text('محفظتي', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الرصيد الحالي:', style: TextStyle(fontSize: 18)),
                  Text('$balance MAD', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white10),
              child: const Text('إغلاق'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طاكسي حمرا'),
        leading: IconButton(icon: const Icon(Icons.account_balance_wallet, color: Colors.amber), onPressed: _showWallet), // زر المحفظة
        actions: [
          IconButton(icon: const Icon(Icons.warning_amber_rounded, color: Colors.red), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          const Center(child: Opacity(opacity: 0.1, child: Icon(Icons.map_rounded, size: 200))),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD90429)),
                      onPressed: () => setState(() => isSearching = !isSearching),
                      child: Text(isSearching ? 'إلغاء الطلب' : 'اطلب تاكسي الآن', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
