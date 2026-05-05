import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'favorit_page.dart';
import 'about_page.dart'; 
import 'home_page.dart';
import 'data.dart'; 

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  final List<Map<String, String>> allProducts = [
    {"name": "Strawberry Shortcake", "price": "Rp 35.000", "image": "assets/cake1.jpg", "category": "Cakes"},
    {"name": "Chocolate Lava Cake", "price": "Rp 28.000", "image": "assets/cake2.jpg", "category": "Cakes"},
    {"name": "Red Velvet Cupcake", "price": "Rp 22.000", "image": "assets/cake3.jpg", "category": "Cakes"},
    {"name": "Lotus Biscoff Cheesecake", "price": "Rp 40.000", "image": "assets/cake4.jpg", "category": "Cakes"},
    {"name": "Tiramisu Espresso Slice", "price": "Rp 38.000", "image": "assets/cake5.jpg", "category": "Cakes"},
    {"name": "Lemon Zest Sponge Cake", "price": "Rp 35.000", "image": "assets/cake6.jpg", "category": "Cakes"},
    {"name": "Butter Croissant", "price": "Rp 18.000", "image": "assets/pastry1.jpg", "category": "Pastries"},
    {"name": "Almond Danish", "price": "Rp 24.000", "image": "assets/pastry2.jpg", "category": "Pastries"},
    {"name": "Pain au Chocolat", "price": "Rp 22.000", "image": "assets/pastry3.jpg", "category": "Pastries"},
    {"name": "Cinnamon Roll with Glaze", "price": "Rp 20.000", "image": "assets/pastry4.jpg", "category": "Pastries"},
    {"name": "Apple Strudel Slice", "price": "Rp 26.000", "image": "assets/pastry5.jpg", "category": "Pastries"},
    {"name": "Savory Beef Puff", "price": "Rp 28.000", "image": "assets/pastry6.jpg", "category": "Pastries"},
    {"name": "Caramel Macchiato", "price": "Rp 25.000", "image": "assets/drink1.jpg", "category": "Drinks"},
    {"name": "Matcha Strawberry Latte", "price": "Rp 28.000", "image": "assets/drink2.jpg", "category": "Drinks"},
    {"name": "Iced Palm Sugar Latte", "price": "Rp 22.000", "image": "assets/drink3.jpg", "category": "Drinks"},
    {"name": "Blueberry Sparkling Soda", "price": "Rp 24.000", "image": "assets/drink4.jpg", "category": "Drinks"},
    {"name": "Creamy Chocolate Shake", "price": "Rp 30.000", "image": "assets/drink5.jpg", "category": "Drinks"},
    {"name": "Hot Americano", "price": "Rp 15.000", "image": "assets/drink6.jpg", "category": "Drinks"},
    {"name": "Matcha Mille Crepe", "price": "Rp 42.000", "image": "assets/dessert1.jpg", "category": "Desserts"},
    {"name": "Mango Silky Pudding", "price": "Rp 15.000", "image": "assets/dessert2.jpg", "category": "Desserts"},
    {"name": "Macaroon Pastel Box", "price": "Rp 50.000", "image": "assets/dessert3.jpg", "category": "Desserts"},
    {"name": "Classic Creamy Gelato", "price": "Rp 25.000", "image": "assets/dessert4.jpg", "category": "Desserts"},
    {"name": "Mixed Fruit Tartlet", "price": "Rp 20.000", "image": "assets/dessert5.jpg", "category": "Desserts"},
    {"name": "Fudgy Brownie Bites", "price": "Rp 18.000", "image": "assets/dessert6.jpg", "category": "Desserts"},
  ];

  List<Map<String, String>> displayedProducts = [];
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    displayedProducts = allProducts;
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      displayedProducts = (category == "All") 
          ? allProducts 
          : allProducts.where((p) => p['category'] == category).toList();
    });
  }

  void searchProduct(String query) {
    setState(() {
      selectedCategory = "All";
      displayedProducts = allProducts
          .where((p) => p['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void addToFavorite(Map<String, String> item) {
    if (!favoriteItems.any((e) => e['name'] == item['name'])) {
      favoriteItems.add(item);
    }
    _showSnackBar("Ditambahkan ke Favorit ❤️");
  }

  void addToCart(Map<String, String> item) {
    cartItems.add(item);

    applyPromo(); // 🔥 PROMO AKTIF

    _showSnackBar("Berhasil masuk keranjang! 🛒");
    setState(() {}); 
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF321B16),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),

      /// NAVBAR PREMIUM
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
          currentIndex: 1,
          selectedItemColor: const Color(0xFF321B16),
          unselectedItemColor: Colors.brown.shade300,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            if (index == 2) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FavoritPage()));
            if (index == 3) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AboutPage()));
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.cake_rounded), label: "Menu"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "About"),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo4.png', height: 40),
                  _buildCartButton(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildSearchBar(),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryItem("All", Icons.apps_rounded),
                  _buildCategoryItem("Pastries", Icons.bakery_dining_outlined),
                  _buildCategoryItem("Cakes", Icons.cake_outlined),
                  _buildCategoryItem("Drinks", Icons.local_cafe_outlined),
                  _buildCategoryItem("Desserts", Icons.icecream_outlined),
                ],
              ),
            ),

            Expanded(
              child: displayedProducts.isEmpty 
                ? const Center(child: Text("No sweets found... 🍰"))
                : GridView.builder(
                    padding: const EdgeInsets.all(24),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 18,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final p = displayedProducts[index];
                      return _ProductCard(
                        p['name']!, p['price']!, p['image']!,
                        onFav: () => addToFavorite(p),
                        onCart: () => addToCart(p),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartButton() {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage())),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
            ),
            child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF321B16), size: 22),
          ),
          if (cartItems.isNotEmpty)
            Positioned(
              right: -5,
              top: -5,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.redAccent,
                child: Text(cartItems.length.toString(), style: const TextStyle(fontSize: 10, color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15)],
      ),
      child: TextField(
        onChanged: searchProduct,
        decoration: const InputDecoration(
          hintText: "Search your sweet cravings...",
          prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF321B16)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String label, IconData icon) {
    bool isActive = selectedCategory == label;
    return GestureDetector(
      onTap: () => filterByCategory(label),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF321B16) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)],
              ),
              child: Icon(icon, color: isActive ? Colors.white : const Color(0xFF321B16)),
            ),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

/// 🔥 PRODUCT CARD SAMA PERSIS DENGAN HOME (PREMIUM)
class _ProductCard extends StatefulWidget {
  final String name, price, imagePath;
  final VoidCallback onFav, onCart;

  const _ProductCard(this.name, this.price, this.imagePath, {required this.onFav, required this.onCart});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = favoriteItems.any((item) => item['name'] == widget.name);
  }

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
            Image.asset(widget.imagePath, fit: BoxFit.cover, width: double.infinity, height: double.infinity),

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
                onTap: () {
                  setState(() => isFavorite = !isFavorite);
                  widget.onFav();
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 18,
                    color: Colors.red,
                  ),
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
                    Text(widget.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.price, style: const TextStyle(color: Colors.white70)),
                        GestureDetector(
                          onTap: widget.onCart,
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