import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    /// 🎬 ANIMASI FADE IN
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    /// ⏳ PINDAH KE HOME
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),

      body: Stack(
        children: [

          /// 🍰 BACKGROUND PATTERN
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) => const Icon(
                  Icons.cake_outlined,
                  color: Color(0xFF321B16),
                ),
              ),
            ),
          ),

          /// ✨ CONTENT
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// 🖼️ LOGO
                  Image.asset(
                    'assets/logo_ara.png',
                    width: 180,
                  ),

                  const SizedBox(height: 20),

                  /// BRAND NAME
                  const Text(
                    "Le Sucré d'Ara",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Color(0xFF321B16),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// TAGLINE
                  const Text(
                    "Preparing your sweet order...",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF43281C),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// LOADING
                  const CircularProgressIndicator(
                    color: Color(0xFF321B16),
                    strokeWidth: 3,
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