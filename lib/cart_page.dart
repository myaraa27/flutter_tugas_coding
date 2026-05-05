import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'menu_page.dart';
import 'favorit_page.dart';
import 'about_page.dart';
import 'payment_page.dart';
import 'data.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Color creamColor = const Color(0xFFFFF9F1);
  final Color brownColor = const Color(0xFF5C3D2E);
  final Color softPinkColor = const Color(0xFFE8A0BF);

  /// ================= DATA LOGIC (TIDAK DIUBAH) =================

  List<Map<String, dynamic>> get groupedCartItems {
    Map<String, Map<String, dynamic>> map = {};

    for (var item in cartItems) {
      String key = item['name']!;

      if (map.containsKey(key)) {
        map[key]!['qty'] += 1;
      } else {
        map[key] = {
          'name': item['name']!,
          'price': item['price']!,
          'image': item['image']!,
          'qty': 1,
          'promo': item['promo'],
        };
      }
    }
    return map.values.toList();
  }

  int parsePrice(String price) {
    return int.parse(price.replaceAll(RegExp(r'[^0-9]'), ''));
  }

  int get totalPrice {
    int total = 0;

    for (var item in groupedCartItems) {
      if (item['promo'] == "free_coffee") continue;

      int price = parsePrice(item['price']);
      total += price * (item['qty'] as int);
    }

    return total;
  }

  String formatRupiah(int value) {
    return "Rp ${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ".")}";
  }

  void addItem(Map<String, dynamic> item) {
    setState(() {
      cartItems.add({
        'name': item['name'],
        'price': item['price'],
        'image': item['image'],
      });
      applyPromo();
    });
  }

  void removeItem(String name) {
    int index = cartItems.indexWhere((i) => i['name'] == name);
    if (index != -1) {
      setState(() {
        cartItems.removeAt(index);
        applyPromo();
      });
    }
  }

  void deleteProduct(String name) {
    setState(() {
      cartItems.removeWhere((i) => i['name'] == name);
      applyPromo();
    });
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    final items = groupedCartItems;

    return Scaffold(
      backgroundColor: creamColor,

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (items.isNotEmpty) _buildCheckoutSection(),
          _buildNavbar(),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            _buildGlassHeader(), // 🔥 HEADER BARU
            _buildWelcomeText(),
            Expanded(
              child: items.isEmpty
                  ? _buildEmptyCart()
                  : _buildCartList(items),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 HEADER STYLE FAVORIT (FIX)
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
                  const Color.fromARGB(255, 225, 175, 175).withValues(alpha: 0.75),
                  const Color.fromARGB(255, 211, 170, 170).withValues(alpha: 0.35),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.8),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(19, 242, 230, 230),
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
                    Text("Keranjangku",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: brownColor)),
                    const SizedBox(height: 4),
                    Text("Cek pesananmu sebelum checkout ✨",
                        style: TextStyle(
                            fontSize: 13,
                            color: brownColor.withValues(alpha: 0.65))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        "Periksa kembali pesanan manismu sebelum kita proses ya, Ara! ✨",
        style: TextStyle(
            fontSize: 14,
            color: brownColor.withValues(alpha: 0.7)),
      ),
    );
  }

  Widget _buildCartList(List<Map<String, dynamic>> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        bool isPromo = item['promo'] == "free_coffee";

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5))
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      item['image'],
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isPromo)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "FREE ☕",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: brownColor)),

                    const SizedBox(height: 4),

                    Text(
                      isPromo ? "FREE" : item['price'],
                      style: TextStyle(
                        color: isPromo ? Colors.green : softPinkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    if (!isPromo)
                      Row(
                        children: [
                          _qtyBtn(Icons.remove,
                              () => removeItem(item['name'])),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              item['qty'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: brownColor),
                            ),
                          ),
                          _qtyBtn(Icons.add,
                              () => addItem(item)),
                        ],
                      ),
                  ],
                ),
              ),

              if (!isPromo)
                IconButton(
                  onPressed: () =>
                      deleteProduct(item['name']),
                  icon: const Icon(Icons.delete_outline_rounded,
                      color: Colors.redAccent),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: creamColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: brownColor.withValues(alpha: 0.1)),
        ),
        child: Icon(icon, size: 14, color: brownColor),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove_shopping_cart_outlined,
              size: 70,
              color: softPinkColor.withValues(alpha: 0.4)),
          const SizedBox(height: 16),
          Text("Wah, keranjangmu masih kosong!",
              style: TextStyle(
                  color: brownColor.withValues(alpha: 0.6))),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 20,
              offset: Offset(0, -5))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(formatRupiah(totalPrice),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: brownColor)),
            ],
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PaymentPage()),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: brownColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                "Lanjut ke Pembayaran",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 NAVBAR FIX (ABOUT SUDAH BISA)
  Widget _buildNavbar() {
    return Container(
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
        selectedItemColor: brownColor,
        unselectedItemColor: brownColor.withValues(alpha: 0.4),
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HomePage()));
          } else if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const MenuPage()));
          } else if (index == 2) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const FavoritPage()));
          } else if (index == 3) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const AboutPage()));
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