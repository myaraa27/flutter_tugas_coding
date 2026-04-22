import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const PastryApp());
}

class PastryApp extends StatelessWidget {
  const PastryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Le Sucré d'Ara",

      /// 🎨 THEME GLOBAL
      theme: ThemeData(
        primaryColor: const Color(0xFF321B16),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF321B16),
          secondary: const Color(0xFFF8E1E7), // soft pink
        ),

        scaffoldBackgroundColor: const Color(0xFFFFF8E7),

        fontFamily: 'Serif',

        /// ✨ biar button konsisten cantik
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF321B16),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),

      /// 🚀 START DARI LOGIN
      home: const LoginPage(),
    );
  }
}