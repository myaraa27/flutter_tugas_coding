import 'package:flutter/material.dart';
import 'login_page.dart';

void main() => runApp(const PastryApp());

class PastryApp extends StatelessWidget {
  const PastryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Tema Warna: Dark Chocolate untuk Aksen, Cream untuk Background
        primaryColor: const Color(0xFF321B16), 
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF321B16),
          secondary: const Color(0xFFF8E1E7), // Soft Pink
        ),
        // Warna Background Utama: Cream yang manis
        scaffoldBackgroundColor: const Color(0xFFFFF8E7), 
        fontFamily: 'Serif',
      ),
      home: const LoginPage(),
    );
  }
}