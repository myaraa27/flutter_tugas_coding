import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),

      /// 🔻 FLOATING BUTTON (Modern Rounded)
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.explore_outlined, size: 20, color: Colors.white),
          label: const Text(
            "Explore Menu",
            style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF321B16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            elevation: 8,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      /// 🔻 BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF321B16),
        // FIX: Update opacity to withValues
        unselectedItemColor: const Color(0xFF321B16).withValues(alpha: 0.4), 
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.cake_rounded), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "About"),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 1. HEADER DENGAN LOGO
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo_ara.png', height: 45), //
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF321B16)),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// 2. WELCOME TEXT
              const Text(
                "Hey, Ara!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF321B16),
                  fontFamily: 'Serif',
                ),
              ),
              const Text(
                "Craving something sweet today?",
                style: TextStyle(fontSize: 16, color: Color(0xFF43281C), fontFamily: 'Serif'),
              ),

              const SizedBox(height: 20),

              /// 3. INFO DISKON KREATIF
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF43281C), Color(0xFF2D1B17)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Flash Sale! ⚡",
                            style: TextStyle(color: Color(0xFFF8E1E7), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Buy 2 Croissants\nGet 1 Free Coffee",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "*Hanya berlaku sampai jam 2 siang",
                            style: TextStyle(color: Colors.white70, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.confirmation_num_outlined, color: Colors.white, size: 40),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// 4. KATEGORI
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CategoryItem("Pastries", Icons.bakery_dining_outlined, true),
                  _CategoryItem("Cakes", Icons.cake_outlined, false),
                  _CategoryItem("Drinks", Icons.local_cafe_outlined, false),
                  _CategoryItem("Desserts", Icons.icecream_outlined, false),
                ],
              ),

              const SizedBox(height: 30),

              /// 5. RECOMMENDED SECTION
              const Text(
                "Recommended for You",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF321B16),
                  fontFamily: 'Serif',
                ),
              ),
              const SizedBox(height: 15),

              /// GRID PRODUK
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.72,
                children: const [
                  _ProductCard("Strawberry Shortcake", "Rp 35.000", "assets/dessert1.jpg"),
                  _ProductCard("Butter Croissant", "Rp 18.000", "assets/dessert2.jpg"),
                  _ProductCard("Chocolate Lava", "Rp 28.000", "assets/dessert3.jpg"),
                  _ProductCard("Matcha Mille Crepe", "Rp 42.000", "assets/dessert4.jpg"),
                  _ProductCard("Caramel Macchiato", "Rp 25.000", "assets/dessert5.jpg"),
                  _ProductCard("Red Velvet Cupcake", "Rp 22.000", "assets/dessert6.jpg"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// WIDGET KATEGORI
class _CategoryItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  const _CategoryItem(this.label, this.icon, this.isActive);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF321B16) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              // FIX: Update opacity to withValues
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
            ],
          ),
          child: Icon(icon, color: isActive ? Colors.white : const Color(0xFF321B16)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

/// WIDGET KARTU PRODUK
class _ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;

  const _ProductCard(this.name, this.price, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          // FIX: Update opacity to withValues
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05), 
            blurRadius: 15, 
            offset: const Offset(0, 5)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  color: const Color(0xFFEDE7E3),
                  child: Image.asset(imagePath, fit: BoxFit.cover, 
                    errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 15,
                  // FIX: Update opacity to withValues
                  backgroundColor: Colors.white.withValues(alpha: 0.9),
                  child: const Icon(Icons.favorite_border, size: 18, color: Colors.redAccent),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Serif'),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(color: Color(0xFF43281C), fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const Icon(Icons.add_circle, color: Color(0xFF321B16), size: 24),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}