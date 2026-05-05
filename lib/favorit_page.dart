import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'menu_page.dart';
import 'about_page.dart';
import 'cart_page.dart';
import 'data.dart';

class FavoritPage extends StatefulWidget {
  const FavoritPage({super.key});

  @override
  State<FavoritPage> createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  final Color creamColor = const Color(0xFFFFF9F1);
  final Color brownColor = const Color(0xFF5C3D2E);
  final Color softPinkColor = const Color(0xFFE8A0BF);

  /// 🔔 NOTIFICATION
  void showTopNotification(String message, IconData icon, Color color) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 60,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 400),
            tween: Tween<double>(begin: -80, end: 0),
            builder: (_, value, child) =>
                Transform.translate(offset: Offset(0, value), child: child),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 249, 248, 248),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(color: Color(0x1A000000), blurRadius: 20)
                ],
              ),
              child: Row(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: brownColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), () => entry.remove());
  }

  void removeFromFavorite(Map<String, String> item) {
    setState(() {
      favoriteItems.removeWhere((e) => e['name'] == item['name']);
    });
    showTopNotification("${item['name']} dihapus 💔",
        Icons.favorite_border, Colors.grey);
  }

  void addToCart(Map<String, String> item) {
    setState(() {
      cartItems.add(item);
    });
    showTopNotification(
        "Masuk keranjang 🛒", Icons.shopping_bag, softPinkColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamColor,
      bottomNavigationBar: _buildNavbar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildGlassHeader(),
            Expanded(child: _buildGrid()),
          ],
        ),
      ),
    );
  }

  /// ✨ HEADER (clean & premium)
  Widget _buildGlassHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 239, 180, 180).withValues(alpha: 0.75),
                  const Color.fromARGB(255, 226, 195, 195).withValues(alpha: 0.35),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 25,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Favorit",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: brownColor)),
                    const SizedBox(height: 4),
                    Text("Pilihan manis kamu 💖",
                        style: TextStyle(
                            fontSize: 13,
                            color: brownColor.withValues(alpha: 0.65))),
                  ],
                ),
                const Spacer(),

                /// CART
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CartPage())),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0x12000000),
                                blurRadius: 15)
                          ],
                        ),
                        child: Icon(Icons.shopping_bag_outlined,
                            color: brownColor),
                      ),
                      if (cartItems.isNotEmpty)
                        Positioned(
                          right: -6,
                          top: -6,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: softPinkColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              cartItems.length.toString(),
                              style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔥 GRID (MODEL HOME → ANTI OVERFLOW)
  Widget _buildGrid() {
    if (favoriteItems.isEmpty) {
      return Center(
        child: Text("Belum ada favorit 😢",
            style: TextStyle(
                color: brownColor.withValues(alpha: 0.5))),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        int crossAxisCount = width > 1100
            ? 5
            : width > 800
                ? 4
                : width > 600
                    ? 3
                    : 2;

        double aspectRatio = (width / crossAxisCount) / 260;

        return GridView.builder(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          itemCount: favoriteItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (_, i) => _card(favoriteItems[i]),
        );
      },
    );
  }

  /// 💎 CARD (HOME STYLE)
  Widget _card(Map<String, String> item) {
    return StatefulBuilder(builder: (context, setLocal) {
      double scale = 1;

      return GestureDetector(
        onTapDown: (_) => setLocal(() => scale = 0.95),
        onTapUp: (_) => setLocal(() => scale = 1),
        onTapCancel: () => setLocal(() => scale = 1),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 150),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(color: Color(0x0F000000), blurRadius: 15)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [
                  Image.asset(
                    item['image']!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  /// gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),

                  /// REMOVE FAVORITE
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () => removeFromFavorite(item),
                      child: const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.favorite,
                            size: 16, color: Colors.red),
                      ),
                    ),
                  ),

                  /// TEXT + PRICE + CART
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name']!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
  children: [
    Expanded(
      child: Text(
        item['price']!,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white70),
      ),
    ),
    const SizedBox(width: 4),
    GestureDetector(
      onTap: () => addToCart(item),
      child: const Icon(Icons.add_circle, color: Colors.white),
    )
  ],
)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  /// 🔻 NAVBAR
  Widget _buildNavbar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, 8))
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: brownColor,
        unselectedItemColor: brownColor.withValues(alpha: 0.4),
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const HomePage()));
          } else if (i == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const MenuPage()));
          } else if (i == 3) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const AboutPage()));
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.cake_rounded), label: "Menu"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorit"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "About"),
        ],
      ),
    );
  }
}