import 'package:flutter/material.dart';
import 'wavy_clipper.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Warna latar belakang Cream khas pastry
      backgroundColor: const Color(0xFFFFF8E7), 
      body: Stack(
        children: [
          // 1. MOTIF KUE PADA BACKGROUND
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
                  color: Color(0xFF321B16), 
                  size: 24,
                ),
              ),
            ),
          ),
          
          SingleChildScrollView(
            child: Column(
              children: [
                // 2. HEADER GAMBAR DENGAN LENGKUNGAN TAJAM
                ClipPath(
                  clipper: WavyClipper(),
                  child: Image.asset(
                    'assets/g_login.jpg',
                    height: size.height * 0.35,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 50),

                // 3. LAYOUT RESPONSIF (Teks Kiri, Form Kanan)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 60, // Jarak horizontal antar elemen
                      runSpacing: 40, // Jarak vertikal jika layar menyempit (HP)
                      children: [
                        
                        // BAGIAN TEKS (KIRI)
                        SizedBox(
                          width: 350,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Le Surce d'Ara",
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 4,
                                  color: const Color(0xFF43281C).withOpacity(0.7),
                                  fontFamily: 'Serif',
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF321B16),
                                  fontFamily: 'Serif',
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Selamat datang,\nsilahkan mengisi Email dan Password\nuntuk memulai pesanan manis Anda.",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF43281C),
                                  fontFamily: 'Serif',
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // BAGIAN FORM & TOMBOL (KANAN)
                        SizedBox(
                          width: 380,
                          child: Column(
                            children: [
                              // Container Cokelat Gelap
                              Container(
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
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 25,
                                      offset: const Offset(0, 15),
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildField("Email", Icons.email_outlined),
                                    const SizedBox(height: 20),
                                    _buildField("Password", Icons.lock_outline, isObscure: true),
                                    const SizedBox(height: 35),
                                    _buildLoginButton(),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 30),

                              // BAGIAN NAVIGASI BUAT AKUN
                              Column(
                                children: [
                                  const Text(
                                    "Belum memiliki akun?",
                                    style: TextStyle(
                                      color: Color(0xFF43281C),
                                      fontSize: 14,
                                      fontFamily: 'Serif',
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildCreateAccountButton(context),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Input Field
  Widget _buildField(String label, IconData icon, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, 
          style: const TextStyle(color: Color(0xFFBCA59C), fontSize: 13, fontFamily: 'Serif')
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isObscure,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFFF8E1E7), size: 20),
            filled: true,
            fillColor: Colors.black.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), 
              borderSide: BorderSide.none
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ],
    );
  }

  // Tombol Utama (Masuk)
  Widget _buildLoginButton() {
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
          "Masuk", 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Serif')
        ),
      ),
    );
  }

  // Tombol Sekunder (Buat Akun)
  Widget _buildCreateAccountButton(BuildContext context) {
    return SizedBox(
      width: 180,
      child: OutlinedButton(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const SignUpPage())
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF43281C), width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: const Text(
          "Buat Akun",
          style: TextStyle(
            color: Color(0xFF43281C),
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}