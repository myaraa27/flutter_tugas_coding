import 'package:flutter/material.dart';
import 'data.dart'; // 🔥 WAJIB

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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static String? registeredEmail;
  static String? registeredPassword;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Mencegah memory leak (Best Practice & Menghilangkan Warning)
  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  // --- FUNGSI NOTIFIKASI MELAYANG (DIALOG) PREMIUM ---
  void _showNotification(String title, String message, bool isSuccess) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6), // Latar belakang dim yang elegan
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
                color: const Color(0xFFD7CCC8).withValues(alpha: 0.3), // Border tipis
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F3),
      resizeToAvoidBottomInset: true, // Responsif saat keyboard muncul
      body: Stack(
        children: [
          // Background Pattern Eksklusif
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // Disesuaikan agar renggang elegan
                ),
                itemBuilder: (context, index) => const Icon(
                  Icons.bakery_dining_outlined,
                  color: Color(0xFF2D1B17),
                  size: 24, // Ikon diperkecil
                ),
              ),
            ),
          ),
          
          Column(
            children: [
              // Header Image dengan Clipper dan Gradasi
              ClipPath(
                clipper: WavyClipper(),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/g_sign.jpg',
                      height: size.height * 0.28,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
              
              // Form Sign Up
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "JOIN THE JOURNEY",
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
                        "Create Account",
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D1B17),
                          fontFamily: 'Playfair Display',
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Daftar sekarang untuk mulai menikmati karya pastry spesial kami setiap harinya.",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF5D4037).withValues(alpha: 0.8),
                          fontFamily: 'Lora',
                          fontStyle: FontStyle.italic,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 35),
                      
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
                            _buildPremiumField("Full Name", Icons.person_outline_rounded, _userController),
                            const SizedBox(height: 20),
                            _buildPremiumField("Email Address", Icons.alternate_email_rounded, _emailController),
                            const SizedBox(height: 20),
                            _buildPremiumField("Secure Password", Icons.lock_outline_rounded, _passController, isObscure: true),
                            const SizedBox(height: 35),
                            _buildSignUpButton(context),
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
          
          // Back Button Premium
          Positioned(
            top: 50,
            left: 24,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF9F3).withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF2D1B17),
                  size: 18,
                ),
              ),
            ),
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
                color: const Color(0xFFD7CCC8).withValues(alpha: 0.6), // Menyala tipis saat fokus
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
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
        onPressed: () async {
          if (_emailController.text.isNotEmpty && _passController.text.isNotEmpty && _userController.text.isNotEmpty) {
            SignUpPage.registeredEmail = _emailController.text.trim();
            SignUpPage.registeredPassword = _passController.text;
            currentUserName = _userController.text.trim();

            debugPrint("--- LOG SIGN UP ---");
            debugPrint("Nama: ${_userController.text}");
            debugPrint("Email Terdaftar: ${SignUpPage.registeredEmail}");

            _showNotification("Bienvenue!", "Pendaftaran berhasil. Selamat bergabung di Le Sucré d’Ara.", true);
            
            // Jeda sebentar untuk membiarkan user membaca sebelum diarahkan kembali
            await Future.delayed(const Duration(seconds: 2));
            if (!context.mounted) return; 
            
            Navigator.pop(context); // Tutup dialog
            Navigator.pop(context); // Kembali ke login
          } else {
            _showNotification("Incomplete Form", "Mohon lengkapi seluruh data pendaftaran Anda.", false);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFDF9F3),
          foregroundColor: const Color(0xFF2D1B17),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text(
          "REGISTER",
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
}