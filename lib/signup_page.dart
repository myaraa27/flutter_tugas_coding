import 'package:flutter/material.dart';

// --- WAVY CLIPPER CLASS (Digabung dalam satu file) ---
class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 20);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// --- SIGN UP PAGE CLASS ---
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7), // Warna krim sesuai splash screen
      body: Stack(
        children: [
          /// 🍰 BACKGROUND PATTERN
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) => const Icon(
                  Icons.cake_outlined,
                  color: Color(0xFF321B16), // Warna cokelat tua
                  size: 24,
                ),
              ),
            ),
          ),

          /// 🚀 MAIN CONTENT
          Column(
            children: [
              /// HEADER IMAGE DENGAN CLIPPER
              ClipPath(
                clipper: WavyClipper(),
                child: Image.asset(
                  'assets/g_sign.jpg', // Sesuai pubspec.yaml kamu
                  height: isMobile ? size.height * 0.25 : size.height * 0.35,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 25 : 50),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: isMobile ? _buildMobileLayout() : _buildWebLayout(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// LAYOUT UNTUK HP
  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTextContent(isMobile: true),
        const SizedBox(height: 30),
        _buildFormContainer(),
        const SizedBox(height: 20),
      ],
    );
  }

  /// LAYOUT UNTUK WEB / LAPTOP
  Widget _buildWebLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFormContainer(),
        const SizedBox(width: 80),
        _buildTextContent(isMobile: false),
      ],
    );
  }

  /// BAGIAN JUDUL & TEKS
  Widget _buildTextContent({required bool isMobile}) {
    return SizedBox(
      width: 380,
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            "Le Sucré d'Ara", //
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 4,
              color: const Color(0xFF43281C).withValues(alpha: 0.7), // FIX: withValues
              fontFamily: 'Serif',
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Color(0xFF321B16),
              fontFamily: 'Serif',
              height: 1,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Buat akun baru untuk menikmati kemudahan akses ke menu pastry spesial kami.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF43281C),
              fontFamily: 'Serif',
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  /// KOTAK FORM COKELAT
  Widget _buildFormContainer() {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF43281C), Color(0xFF2D1B17)],
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3), // FIX: withValues
            blurRadius: 25,
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildField("Email", Icons.email_outlined),
          const SizedBox(height: 15),
          _buildField("User Name", Icons.person_outline),
          const SizedBox(height: 15),
          _buildField("Password", Icons.lock_outline, isObscure: true),
          const SizedBox(height: 35),
          _buildSignUpButton(),
        ],
      ),
    );
  }

  /// WIDGET INPUT FIELD
  Widget _buildField(String label, IconData icon, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Color(0xFFBCA59C), fontSize: 13, fontFamily: 'Serif')),
        const SizedBox(height: 8),
        TextField(
          obscureText: isObscure,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFFF8E1E7), size: 20),
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.2), // FIX: withValues
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ],
    );
  }

  /// TOMBOL DAFTAR
  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF321B16),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 5,
        ),
        child: const Text(
          "Daftar",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Serif'),
        ),
      ),
    );
  }
}