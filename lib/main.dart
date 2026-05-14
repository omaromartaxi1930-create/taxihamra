import 'package:flutter/material.dart';

void main() => runApp(const TaxiHamraApp());

class TaxiHamraApp extends StatelessWidget {
  const TaxiHamraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'طاكسي حمرا',
      // الثيم الداكن المستوحى من ملفاتك الأصلية
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFD90429),
        scaffoldBackgroundColor: const Color(0xFF1A1415),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD90429), brightness: Brightness.dark),
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
  bool isSearching = false; // حالة البحث عن سائق

  // وظيفة نداء الاستغاثة SOS
  void _handleSOS() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1415),
        title: const Text('نداء استغاثة SOS', textAlign: TextAlign.right, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: const Text('هل أنت في حالة خطر؟ سيتم إرسال موقعك فوراً إلى أقرب سائقين ومركز المساعدة.', textAlign: TextAlign.right),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال نداء الاستغاثة بنجاح', textAlign: TextAlign.center), backgroundColor: Colors.red),
              );
            },
            child: const Text('إرسال نداء'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طاكسي حمرا - فاس', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
            onPressed: _handleSOS,
          ),
        ],
      ),
      body: Stack(
        children: [
          // خلفية بسيطة تمثل مكان الخريطة
          const Center(
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.map_rounded, size: 200),
            ),
          ),
          
          // لوحة التحكم السفلية (Action Panel)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSearching) ...[
                    const CircularProgressIndicator(color: Color(0xFFD90429)),
                    const SizedBox(height: 15),
                    const Text('جاري البحث عن أقرب طاكسي حمرا...', style: TextStyle(fontSize: 16)),
                  ] else ...[
                    const Text('مرحباً بك! أين وجهتك اليوم؟', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD90429),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                      ),
                      onPressed: () {
                        setState(() => isSearching = !isSearching);
                      },
                      child: Text(
                        isSearching ? 'إلغاء الطلب' : 'اطلب تاكسي الآن',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
