import 'package:flutter/material.dart';

void main() => runApp(const TaxiHamraApp());

class TaxiHamraApp extends StatelessWidget {
  const TaxiHamraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'طاكسي حمرا', // [cite: 3]
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1415), // اللون الداكن للتطبيق [cite: 158]
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
  bool isSearching = false; // حالة البحث عن سائق [cite: 110]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طاكسي حمرا - فاس'), [cite: 3]
        actions: [
          IconButton(
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
            onPressed: () => _triggerSOS(), // نداء الاستغاثة [cite: 204]
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSearching) 
              const CircularProgressIndicator(color: Colors.red), [cite: 110]
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD90429), // لون طاكسي حمرا [cite: 52]
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              onPressed: () {
                setState(() => isSearching = !isSearching);
              },
              child: Text(
                isSearching ? 'جاري البحث...' : 'اطلب تاكسي الآن', [cite: 3, 110]
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _triggerSOS() {
    // محاكاة إرسال الاستغاثة كما في الكود الأصلي [cite: 178]
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم إرسال نداء SOS لجميع السائقين'), [cite: 143]
        backgroundColor: Colors.red,
      ),
    );
  }
}
