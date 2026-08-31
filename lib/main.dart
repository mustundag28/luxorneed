import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/items/data/models/item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive'ı başlat
  await Hive.initFlutter();

  // Adaptörleri kaydet
  Hive.registerAdapter(ItemTypeAdapter());
  Hive.registerAdapter(ItemStatusAdapter());
  Hive.registerAdapter(ItemModelAdapter());

  // 'items' kutusunu (box) aç
  await Hive.openBox<ItemModel>('items');

  runApp(const LuxorneedApp());
}

class LuxorneedApp extends StatelessWidget {
  const LuxorneedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luxorneed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Luxorneed Altyapısı Hazır!'),
        ),
      ),
    );
  }
}