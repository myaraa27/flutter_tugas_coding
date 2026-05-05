import 'package:flutter/material.dart';
import 'data.dart';
import 'home_page.dart';
import 'menu_page.dart';
import 'favorit_page.dart';
import 'sukses_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Color creamColor = const Color(0xFFFFF9F1);
  final Color brownColor = const Color(0xFF5C3D2E);
  final Color softPinkColor = const Color(0xFFE8A0BF);

  bool isEatIn = true;
  int selectedPayment = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tableController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  /// ================= GROUPED ITEMS =================
  Map<String, Map<String, dynamic>> get groupedCartItems {
    Map<String, Map<String, dynamic>> grouped = {};

    for (var item in cartItems) {
      String name = item['name']!;

      if (grouped.containsKey(name)) {
        grouped[name]!['qty'] += 1;
      } else {
        grouped[name] = {
          'name': item['name'],
          'price': item['price'],
          'promo': item['promo'],
          'qty': 1,
        };
      }
    }
    return grouped;
  }

  /// ================= PARSE PRICE =================
  int parsePrice(String price) {
    return int.parse(price.replaceAll(RegExp(r'[^0-9]'), ''));
  }

  /// ================= SUBTOTAL (EXCLUDE PROMO) =================
  int get subtotal {
    int total = 0;

    for (var item in groupedCartItems.values) {
      if (item['promo'] == "free_coffee") continue;

      int price = parsePrice(item['price']);
      total += price * (item['qty'] as int);
    }

    return total;
  }

  /// ================= FORMAT RUPIAH =================
  String formatIDR(int value) {
    return "Rp ${value.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ".",
        )}";
  }

  @override
  Widget build(BuildContext context) {
    int tax = (subtotal * 0.1).toInt();
    int total = subtotal + tax;

    return Scaffold(
      backgroundColor: creamColor,
      bottomNavigationBar: _buildBottomNavbar(),

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// ===== NAME =====
                    _sectionTitle("Nama Pembeli"),
                    _buildInput(_nameController, "Masukkan nama kamu", Icons.person),

                    const SizedBox(height: 20),

                    /// ===== ORDER TYPE =====
                    _sectionTitle("Tipe Pesanan"),
                    _buildOrderType(),

                    if (isEatIn) ...[
                      const SizedBox(height: 20),
                      _sectionTitle("Nomor Meja"),
                      _buildInput(_tableController, "Contoh: 07", Icons.table_restaurant),
                    ],

                    const SizedBox(height: 20),

                    /// ===== NOTE =====
                    _sectionTitle("Catatan"),
                    _buildInput(_noteController, "Opsional...", Icons.notes),

                    const SizedBox(height: 20),

                    /// ===== PAYMENT =====
                    _sectionTitle("Metode Pembayaran"),
                    _paymentOption(0, "QRIS / E-Wallet"),
                    _paymentOption(1, "Transfer Bank"),
                    _paymentOption(2, "Bayar di Kasir"),

                    const SizedBox(height: 20),

                    /// ===== SUMMARY =====
                    _sectionTitle("Ringkasan Pembayaran"),
                    _buildSummary(tax, total),

                    const SizedBox(height: 30),

                    /// ===== PAY BUTTON =====
                    _buildPayButton(total),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= HEADER =================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 16, color: brownColor),
            ),
          ),
          const SizedBox(width: 15),
          Text(
            "Pembayaran",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: brownColor),
          ),
        ],
      ),
    );
  }

  /// ================= SECTION TITLE =================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: brownColor,
        ),
      ),
    );
  }

  /// ================= INPUT =================
  Widget _buildInput(TextEditingController c, String hint, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: softPinkColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  /// ================= ORDER TYPE =================
  Widget _buildOrderType() {
    return Row(
      children: [
        _typeBtn("Dine In", isEatIn, () => setState(() => isEatIn = true)),
        const SizedBox(width: 10),
        _typeBtn("Take Away", !isEatIn, () => setState(() => isEatIn = false)),
      ],
    );
  }

  Widget _typeBtn(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: active ? brownColor : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: active ? Colors.white : brownColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ================= PAYMENT OPTION =================
  Widget _paymentOption(int index, String label) {
    bool selected = selectedPayment == index;

    return GestureDetector(
      onTap: () => setState(() => selectedPayment = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected ? softPinkColor.withValues(alpha: 0.15) : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_off,
              color: softPinkColor,
            )
          ],
        ),
      ),
    );
  }

  /// ================= SUMMARY =================
  Widget _buildSummary(int tax, int total) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ...groupedCartItems.entries.map((entry) {
            bool isPromo = entry.value['promo'] == "free_coffee";

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${entry.key} x${entry.value['qty']}"),
                Text(isPromo ? "FREE" : entry.value['price']),
              ],
            );
          }),

          const Divider(height: 25),

          _row("Subtotal", formatIDR(subtotal)),
          _row("Pajak (10%)", formatIDR(tax)),

          const Divider(height: 25),

          _row("Total", formatIDR(total), bold: true),
        ],
      ),
    );
  }

  Widget _row(String title, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: brownColor,
            )),
        Text(value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: bold ? softPinkColor : brownColor,
            )),
      ],
    );
  }

  /// ================= PAY BUTTON =================
  Widget _buildPayButton(int total) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_nameController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Isi nama dulu ya")),
            );
            return;
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SuksesPage(
                buyerName: _nameController.text,
                tableNumber: isEatIn ? _tableController.text : "Take Away",
                note: _noteController.text.isEmpty ? "-" : _noteController.text,
                paymentMethod: ["QRIS", "Transfer", "Kasir"][selectedPayment],
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: brownColor,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          "Bayar • ${formatIDR(total)}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// ================= NAVBAR =================
  Widget _buildBottomNavbar() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: brownColor,
      unselectedItemColor: brownColor.withValues(alpha: 0.4),
      onTap: (i) {
        if (i == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        if (i == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MenuPage()));
        if (i == 2) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FavoritPage()));
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.cake), label: "Menu"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "About"),
      ],
    );
  }
}