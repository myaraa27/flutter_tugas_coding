import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'splash_screen.dart';

// --- WAVY CLIPPER CLASS ---
class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 35);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 90);
    var secondEndPoint = Offset(size.width, size.height - 25);

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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passLoginController = TextEditingController();

  // Mencegah memory leak (Best Practice & Menghilangkan Warning)
  @override
  void dispose() {
    _emailLoginController.dispose();
    _passLoginController.dispose();
    super.dispose();
  }

  // --- FUNGSI NOTIFIKASI MELAYANG (DIALOG) PREMIUM ---
  void _showNotification(String title, String message, bool isSuccess) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6), // Latar belakang dim yang lebih elegan
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: const Color(0xFF2D1B17),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFD7CCC8).withValues(alpha: 0.3), // Border tipis elegan
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ikon Notifikasi dalam Lingkaran Elegan
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSuccess 
                        ? const Color(0xFFD7CCC8).withValues(alpha: 0.1)
                        : Colors.redAccent.withValues(alpha: 0.1),
                    border: Border.all(
                      color: isSuccess ? const Color(0xFFD7CCC8) : Colors.redAccent,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    isSuccess ? Icons.auto_awesome_rounded : Icons.priority_high_rounded,
                    color: isSuccess ? const Color(0xFFD7CCC8) : Colors.redAccent,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFFDF9F3),
                    fontFamily: 'Playfair Display',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFD7CCC8).withValues(alpha: 0.8),
                    fontFamily: 'Lora',
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 28),
                // Tombol OK Premium
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFFD7CCC8).withValues(alpha: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFFD7CCC8), width: 0.5),
                      ),
                    ),
                    child: const Text(
                      "ACKNOWLEDGE",
                      style: TextStyle(
                        color: Color(0xFFD7CCC8),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        letterSpacing: 2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleLogin() async {
    String email = _emailLoginController.text.trim();
    String pass = _passLoginController.text;

    debugPrint("--- LOG PERCOBAAN LOGIN ---");
    debugPrint("Mencoba Login dengan: $email");

    if (email.isEmpty || pass.isEmpty) {
      debugPrint("Status: Gagal - Field Kosong");
      _showNotification("Incomplete Details", "Mohon lengkapi email dan kata sandi Anda untuk melanjutkan.", false);
      return;
    }

    if (email == SignUpPage.registeredEmail && pass == SignUpPage.registeredPassword) {
      debugPrint("Status: Berhasil Login!");
      
      _showNotification("Bienvenue!", "Senang melihat Anda kembali di Le Sucré d’Ara.", true);

      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    } else {
      debugPrint("Status: Gagal - Tidak Cocok");
      _showNotification("Access Denied", "Kredensial tidak valid. Pastikan Anda telah terdaftar di sistem kami.", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F3),
      resizeToAvoidBottomInset: true, // Diubah ke true agar saat keyboard muncul, layar bisa di-scroll dengan mulus
      body: Stack(
        children: [
          // Background Pattern Eksklusif
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // Dibuat lebih renggang agar terkesan mahal
                ),
                itemBuilder: (context, index) => const Icon(
                  Icons.bakery_dining_outlined,
                  color: Color(0xFF2D1B17),
                  size: 24, // Ikon diperkecil untuk estetik minimalist
                ),
              ),
            ),
          ),
          
          Column(
            children: [
              // Header Image dengan Clipper
              ClipPath(
                clipper: WavyClipper(),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/g_login.jpg',
                      height: size.height * 0.28,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      // Fallback jika gambar gagal dimuat
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: size.height * 0.28,
                        color: const Color(0xFFD7CCC8),
                      ),
                    ),
                    // Gradient overlay agar gambar menyatu mulus
                    Container(
                      height: size.height * 0.28,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.1),
                            const Color(0xFF2D1B17).withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Form Login
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32), // Padding disesuaikan
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "LE SUCRÉ D'ARA",
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 8, // Tracking dilebarkan
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8D6E63).withValues(alpha: 0.8),
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D1B17),
                          fontFamily: 'Playfair Display',
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Silakan masuk untuk melanjutkan perjalanan manis Anda bersama kami.",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF5D4037).withValues(alpha: 0.8),
                          fontFamily: 'Lora',
                          fontStyle: FontStyle.italic, // Italic memberi kesan klasik
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // Form Card Premium
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D1B17),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: const Color(0xFFD7CCC8).withValues(alpha: 0.15),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2D1B17).withValues(alpha: 0.25),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildPremiumField("Email Address", Icons.mail_outline_rounded, _emailLoginController),
                            const SizedBox(height: 24),
                            _buildPremiumField("Secure Password", Icons.lock_outline_rounded, _passLoginController, isObscure: true),
                            const SizedBox(height: 40),
                            _buildLoginButton(context),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Footer Registration
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Belum menjadi bagian dari kami?",
                              style: TextStyle(
                                color: const Color(0xFF2D1B17).withValues(alpha: 0.7),
                                fontSize: 13,
                                fontFamily: 'Lora',
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildCreateAccountButton(context),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- WIDGET PENDUKUNG ---

  Widget _buildPremiumField(String label, IconData icon, TextEditingController controller, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Color(0xFFD7CCC8),
            fontSize: 10,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          obscureText: isObscure,
          cursorColor: const Color(0xFFD7CCC8),
          style: const TextStyle(
            color: Color(0xFFFDF9F3), 
            fontFamily: 'Montserrat',
            fontSize: 14,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFFD7CCC8).withValues(alpha: 0.7), size: 20),
            filled: true,
            fillColor: const Color(0xFFD7CCC8).withValues(alpha: 0.05),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: const Color(0xFFD7CCC8).withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: const Color(0xFFD7CCC8).withValues(alpha: 0.6), // Menyala tipis saat diklik
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDF9F3).withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFDF9F3),
          foregroundColor: const Color(0xFF2D1B17),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text(
          "SIGN IN",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 3,
            fontSize: 13,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpPage()),
      ),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          "Create an Account",
          style: TextStyle(
            color: const Color(0xFF2D1B17),
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
            fontSize: 13,
            letterSpacing: 1.2,
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFF2D1B17).withValues(alpha: 0.4),
            decorationThickness: 1.5,
          ),
        ),
      ),
    );
  }
}