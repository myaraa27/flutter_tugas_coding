import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'favorit_page.dart';
import 'menu_page.dart';
import 'about_page.dart'; 
import 'data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Fungsi untuk mendapatkan sapaan berdasarkan waktu
  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) return "Hai.. Selamat Pagi";
    if (hour >= 11 && hour < 15) return "Hai.. Selamat Siang";
    if (hour >= 15 && hour < 18) return "Hai.. Selamat Sore";
    return "Hai.. Selamat Malam";
  }

  void addToFavorite(BuildContext context, Map<String, String> item) {
    favoriteItems.add(item);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ditambahkan ke Favorit ❤️")),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritPage()),
    );
  }

  void addToCart(BuildContext context, Map<String, String> item) {
    cartItems.add(item);

    applyPromo(); // 🔥 WAJIB

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ditambahkan ke Keranjang 🛒")),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),

      /// FLOAT BUTTON
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuPage()));
          },
          icon: const Icon(Icons.explore_outlined, size: 20, color: Colors.white),
          label: const Text(
            "Explore Menu",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF321B16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            elevation: 10,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      /// PREMIUM NAVBAR
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: const Color(0xFF321B16),
          unselectedItemColor: Colors.brown.shade300,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MenuPage()));
            } else if (index == 2) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FavoritPage()));
            } else if (index == 3) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.cake_rounded), label: "Menu"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "About"),
          ],
        ),
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.04,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) => const Icon(
                  Icons.cake_outlined,
                  color: Color(0xFF321B16),
                  size: 24,
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/logo4.png',
                        height: 45,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.bakery_dining, size: 45),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage())),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                          ),
                          child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF321B16)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                 /// SAPAAN & USERNAME (Gaya seragam dengan tagline)
                  Text(
                    "${_getGreeting()}, $currentUserName",
                    style: const TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold, 
                      color: Color(0xFF321B16),
                    ),
                  ),

                  const SizedBox(height: 4), // Jarak tipis agar tetap proporsional

                  const Text(
                    "Indulge in sweetness 🍓",
                    style: TextStyle(
                      fontSize: 17, 
                      fontWeight: FontWeight.bold, 
                      color: Color(0xFF321B16),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "A little happiness in every bite",
                    style: TextStyle(
                      fontSize: 14, 
                      color: Color(0xFF6D4C41), // Warna dibuat sedikit lebih lembut
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// FLASH SALE (PREMIUM VERSION - WITH VALUES)
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage())),
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF43281C), Color(0xFF2D1B17)],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF321B16).withValues(alpha: 0.3), // Menggunakan withValues
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Stack(
                          children: [
                            /// DEKORASI BACKGROUND
                            Positioned(
                              top: -20,
                              right: -20,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white.withValues(alpha: 0.05),
                              ),
                            ),
                            Positioned(
                              bottom: -30,
                              left: 40,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white.withValues(alpha: 0.03),
                              ),
                            ),

                            /// ISI KONTEN
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.orange.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            "Flash Sale ⚡",
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Buy 2 Croissants\nGet 1 Free Coffee",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            height: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  /// ICON DENGAN GLOW
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withValues(alpha: 0.3),
                                          blurRadius: 20,
                                          spreadRadius: 2,
                                        )
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.local_fire_department,
                                      color: Colors.orange,
                                      size: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// CATEGORY
                  Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: const [
                        _CategoryItem("Pastries", Icons.bakery_dining_outlined),
                        _CategoryItem("Cakes", Icons.cake_outlined),
                        _CategoryItem("Drinks", Icons.local_cafe_outlined),
                        _CategoryItem("Desserts", Icons.icecream_outlined),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Recommended for You",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF321B16)),
                  ),

                  const SizedBox(height: 15),

                  /// PRODUCT GRID
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double width = constraints.maxWidth;
                      double childAspectRatio = (width / 2) / 280;

                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: width > 600 ? 3 : 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: childAspectRatio,
                        children: [
                          _ProductCard("Strawberry Shortcake", "Rp 35.000", "assets/cake1.jpg",
                              onFav: () => addToFavorite(context, {"name": "Strawberry Shortcake", "price": "Rp 35.000", "image": "assets/cake1.jpg"}),
                              onCart: () => addToCart(context, {"name": "Strawberry Shortcake", "price": "Rp 35.000", "image": "assets/cake1.jpg"})),

                          _ProductCard("Butter Croissant", "Rp 18.000", "assets/pastry1.jpg",
                              onFav: () => addToFavorite(context, {"name": "Butter Croissant", "price": "Rp 18.000", "image": "assets/pastry1.jpg"}),
                              onCart: () => addToCart(context, {"name": "Butter Croissant", "price": "Rp 18.000", "image": "assets/pastry1.jpg"})),

                          _ProductCard("Chocolate Lava", "Rp 28.000", "assets/cake2.jpg",
                              onFav: () => addToFavorite(context, {"name": "Chocolate Lava", "price": "Rp 28.000", "image": "assets/cake2.jpg"}),
                              onCart: () => addToCart(context, {"name": "Chocolate Lava", "price": "Rp 28.000", "image": "assets/cake2.jpg"})),

                          _ProductCard("Matcha Mille Crepe", "Rp 42.000", "assets/dessert1.jpg",
                              onFav: () => addToFavorite(context, {"name": "Matcha Mille Crepe", "price": "Rp 42.000", "image": "assets/dessert1.jpg"}),
                              onCart: () => addToCart(context, {"name": "Matcha Mille Crepe", "price": "Rp 42.000", "image": "assets/dessert1.jpg"})),

                          _ProductCard("Caramel Macchiato", "Rp 25.000", "assets/drink1.jpg",
                              onFav: () => addToFavorite(context, {"name": "Caramel Macchiato", "price": "Rp 25.000", "image": "assets/drink1.jpg"}),
                              onCart: () => addToCart(context, {"name": "Caramel Macchiato", "price": "Rp 25.000", "image": "assets/drink1.jpg"})),

                          _ProductCard("Red Velvet Cake", "Rp 22.000", "assets/cake3.jpg",
                              onFav: () => addToFavorite(context, {"name": "Red Velvet Cake", "price": "Rp 22.000", "image": "assets/cake3.jpg"}),
                              onCart: () => addToCart(context, {"name": "Red Velvet Cake", "price": "Rp 22.000", "image": "assets/cake3.jpg"})),
                        ],
                      );
                    },
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

/// CATEGORY ITEM
class _CategoryItem extends StatefulWidget {
  final String label;
  final IconData icon;
  const _CategoryItem(this.label, this.icon);

  @override
  State<_CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<_CategoryItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    double scale = isHover ? 1.05 : 1.0; // Tentukan nilai scale

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuPage())),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          // Perbaikan: Pakai diagonal3Values (Baris 335)
          transform: Matrix4.diagonal3Values(scale, scale, 1.0), 
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isHover ? 0.1 : 0.05),
                      blurRadius: isHover ? 10 : 5,
                    )
                  ],
                ),
                child: Icon(widget.icon, color: const Color(0xFF321B16)),
              ),
              const SizedBox(height: 8),
              Text(widget.label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

/// PRODUCT CARD
class _ProductCard extends StatelessWidget {
  final String name, price, imagePath;
  final VoidCallback onFav, onCart;

  const _ProductCard(this.name, this.price, this.imagePath, {required this.onFav, required this.onCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: double.infinity),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: onFav,
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite_border, size: 18, color: Colors.red),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(price, style: const TextStyle(color: Colors.white70)),
                        GestureDetector(
                          onTap: onCart,
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
    );
  }
}