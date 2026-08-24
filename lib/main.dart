import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/products_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const QuickKartApp(),
    ),
  );
}
//
class QuickKartApp extends StatelessWidget {
  const QuickKartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickKart',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        scaffoldBackgroundColor: const Color(0xFFF7F9F7),
      ),
      home: const ProductsScreen(),
    );
  }
}
