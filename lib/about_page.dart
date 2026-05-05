import 'package:flutter/material.dart';
import 'home_page.dart';
import 'menu_page.dart';
import 'favorit_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  final Color creamColor = const Color(0xFFFFF9F1);
  final Color brownColor = const Color(0xFF5C3D2E);
  final Color softPinkColor = const Color(0xFFE8A0BF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamColor,
      bottomNavigationBar: _buildNavbar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔥 HEADER (FIX SESUAI REQUEST)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 10), // 🔥 turun dari atas
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo4.png',
                      height: 42,
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.bakery_dining, color: brownColor, size: 36),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Le Sucré d'Ara",
                      style: TextStyle(
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: brownColor,
                      ),
                    ),
                  ],
                ),
              ),

              /// 🔥 HERO IMAGE
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(color: Color(0x14000000), blurRadius: 20)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/toko1.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.4),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 18,
                        left: 18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Sweet & Cozy Place",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Feel the warmth inside ✨",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 🔥 STORY
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Our Story",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: brownColor)),

                    const SizedBox(height: 10),

                    Text(
                      "Berawal dari kecintaan Ara pada aroma panggangan kue di pagi hari, Le Sucré d'Ara hadir sebagai rumah bagi setiap potong kebahagiaan. Kami percaya bahwa setiap dessert memiliki cerita, dan kami ingin menjadi bagian dari cerita manismu.",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: brownColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// 🔥 INFO CARDS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    _infoCard(Icons.star, "4.9", "Rating"),
                    const SizedBox(width: 12),
                    _infoCard(Icons.access_time, "09-21", "Open"),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// 🔥 LOCATION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Find Us",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: brownColor)),

                    const SizedBox(height: 10),

                    _contactTile(Icons.location_on,
                        "Jl. Manis No. 24, Surakarta"),
                    _contactTile(Icons.map, "Open in Maps",
                        isLink: true),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 SOCIAL
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    _socialBtn(Icons.camera_alt),
                    _socialBtn(Icons.facebook),
                    _socialBtn(Icons.language),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Center(
                child: Text("Made with love by Ara 🤍",
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: brownColor.withValues(alpha: 0.4))),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String sub) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x0A000000), blurRadius: 12)
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: softPinkColor, size: 20),
            const SizedBox(height: 6),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: brownColor)),
            Text(sub,
                style: TextStyle(
                    fontSize: 11,
                    color: brownColor.withValues(alpha: 0.5))),
          ],
        ),
      ),
    );
  }

  Widget _contactTile(IconData icon, String text,
      {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: brownColor, size: 18),
          const SizedBox(width: 10),
          Text(text,
              style: TextStyle(
                fontSize: 13,
                color: isLink ? softPinkColor : brownColor,
                fontWeight:
                    isLink ? FontWeight.bold : FontWeight.normal,
              )),
        ],
      ),
    );
  }

  Widget _socialBtn(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: brownColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  /// 🔥 NAVBAR CONSISTENT
  Widget _buildNavbar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 20)
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: brownColor,
        unselectedItemColor: const Color(0xFFA08B81),
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
          if (index == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MenuPage()));
          if (index == 2) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FavoritPage()));
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.cake_rounded), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "About"),
        ],
      ),
    );
  }
}