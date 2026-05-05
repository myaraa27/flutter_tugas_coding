import 'package:flutter/material.dart';
import 'home_page.dart';
import 'data.dart';

class SuksesPage extends StatelessWidget {
  final String? buyerName;
  final String? tableNumber;
  final String? note;
  final String? paymentMethod;

  const SuksesPage({
    super.key,
    this.buyerName,
    this.tableNumber,
    this.note,
    this.paymentMethod,
  });

  final Color creamColor = const Color(0xFFFFF9F1);
  final Color brownColor = const Color(0xFF5C3D2E);
  final Color softPinkColor = const Color(0xFFE8A0BF);
  final Color successGreen = const Color(0xFF4CAF50);

  /// 🔥 GROUP ITEM + HANDLE PROMO
  Map<String, Map<String, dynamic>> get groupedItems {
    Map<String, Map<String, dynamic>> grouped = {};

    for (var item in cartItems) {
      String name = item['name'] ?? '';

      if (grouped.containsKey(name)) {
        grouped[name]!['qty'] += 1;
      } else {
        grouped[name] = {
          "qty": 1,
          "price": item['price'] ?? "Rp 0",
          "promo": item['promo'],
        };
      }
    }

    return grouped;
  }

  /// 🔥 SAFE PARSE (ANTI ERROR)
  int parsePrice(String price) {
    String clean = price.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.isEmpty) return 0;
    return int.parse(clean);
  }

  /// 🔥 SUBTOTAL (EXCLUDE FREE ITEM)
  int get subtotal {
    int total = 0;

    for (var item in cartItems) {
      if (item['promo'] == "free_coffee") continue;
      total += parsePrice(item['price'] ?? "0");
    }

    return total;
  }

  String formatIDR(int amount) {
    String result = amount.toString();
    String formatted = '';
    int count = 0;

    for (int i = result.length - 1; i >= 0; i--) {
      count++;
      formatted = result[i] + formatted;
      if (count % 3 == 0 && i != 0) {
        formatted = '.$formatted';
      }
    }
    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    int tax = (subtotal * 0.1).toInt();
    int totalPay = subtotal + tax;

    String displayBuyer = buyerName ?? "Pelanggan";
    String displayTable = tableNumber ?? "-";
    String displayNote = (note == null || note!.isEmpty) ? "-" : note!;
    String displayMethod = paymentMethod ?? "Tunai";

    String realDate =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} "
        "${DateTime.now().hour.toString().padLeft(2, '0')}:"
        "${DateTime.now().minute.toString().padLeft(2, '0')}";

    return Scaffold(
      backgroundColor: creamColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [

              /// 🔥 HEADER
              Image.asset(
                'assets/logo4.png',
                height: 70,
                errorBuilder: (c, e, s) =>
                    Icon(Icons.bakery_dining, color: brownColor, size: 50),
              ),
              const SizedBox(height: 10),

              Text(
                "Le Sucré d'Ara",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  color: brownColor,
                ),
              ),

              const SizedBox(height: 40),

              /// 🔥 SUCCESS ICON
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: successGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_rounded,
                    size: 60, color: successGreen),
              ),

              const SizedBox(height: 15),

              Text(
                "Pembayaran Berhasil!",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: brownColor),
              ),

              const SizedBox(height: 6),

              Text(
                "Pesananmu sedang kami siapkan ✨",
                style: TextStyle(
                    color: brownColor.withValues(alpha: 0.6)),
              ),

              const SizedBox(height: 30),

              /// 🔥 RECEIPT CARD (LUXURY STYLE)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [

                      Text("TRANSACTION RECEIPT",
                          style: TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: brownColor)),

                      const Divider(height: 30),

                      _row("Customer", displayBuyer),
                      _row("Table", displayTable),
                      _row("Payment", displayMethod),
                      _row("Date", realDate),

                      const Divider(height: 30),

                      /// 🔥 ITEMS
                      ...groupedItems.entries.map((e) {
                        bool isPromo = e.value['promo'] == "free_coffee";

                        int price = parsePrice(e.value['price']);
                        int qty = e.value['qty'];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  e.key,
                                  style: TextStyle(
                                      color: brownColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text("x$qty",
                                  style: TextStyle(
                                      color: brownColor.withValues(alpha: 0.5))),
                              const SizedBox(width: 20),

                              Text(
                                isPromo
                                    ? "FREE ☕"
                                    : formatIDR(price * qty),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isPromo
                                      ? Colors.green
                                      : brownColor,
                                ),
                              )
                            ],
                          ),
                        );
                      }),

                      const Divider(height: 30),

                      _priceRow("Subtotal", formatIDR(subtotal), false),
                      _priceRow("Tax (10%)", formatIDR(tax), false),

                      const SizedBox(height: 10),

                      _priceRow("TOTAL", formatIDR(totalPay), true),

                      if (displayNote != "-") ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: creamColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Note: $displayNote",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: brownColor)),
                        )
                      ]
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// 🔥 BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    cartItems.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HomePage()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brownColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  child: const Text(
                    "Kembali ke Beranda",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: brownColor.withValues(alpha: 0.5))),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: brownColor)),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, bool big) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: big ? 16 : 14,
                fontWeight:
                    big ? FontWeight.bold : FontWeight.normal,
                color: brownColor)),
        Text(value,
            style: TextStyle(
                fontSize: big ? 18 : 14,
                fontWeight: FontWeight.bold,
                color: big ? softPinkColor : brownColor)),
      ],
    );
  }
}