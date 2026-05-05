List<Map<String, String>> cartItems = [];
List<Map<String, String>> favoriteItems = [];

/// 🔥 USER DATA
String currentUserName = "Guest";

/// ================= PROMO FUNCTION =================
void applyPromo() {
  int croissantCount = 0;

  // 🔥 hitung jumlah croissant
  for (var item in cartItems) {
    if (item["name"] == "Butter Croissant") {
      croissantCount++;
    }
  }

  // 🔥 setiap 2 croissant → 1 kopi gratis
  int freeCoffee = croissantCount ~/ 2;

  // 🔥 hapus kopi gratis lama (biar tidak dobel)
  cartItems.removeWhere((item) => item["promo"] == "free_coffee");

  // 🔥 tambahkan kopi gratis baru
  for (int i = 0; i < freeCoffee; i++) {
    cartItems.add({
      "name": "Caramel Macchiato",
      "price": "FREE",
      "image": "assets/drink1.jpg",
      "promo": "free_coffee",
    });
  }
}