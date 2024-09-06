import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisclaimerPage extends StatelessWidget {
  static String routeName = 'DisclaimerPage';
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 360; // Menghitung faktor ukuran layar
    double fontSizeWarning = 30 * fem;
    double fontSizeText = 18 * fem;

    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgdisclaimer.png', // Sesuaikan path gambar
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0 * fem),
              child: Column(
                children: [
                  SizedBox(height: 30 * fem),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18 * fem, vertical: 10 * fem),
                    child: Text(
                      'Peringatan!!!',
                      style: GoogleFonts.poppins(
                        fontSize: fontSizeWarning.clamp(20, 30), // Menyesuaikan ukuran font
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFCB3F41),
                      ),
                    ),
                  ),
                  // Gambar robot
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20 * fem),
                    child: Image.asset(
                      'assets/images/robotwarning.png', // Path ke gambar robot
                      height: 250 * fem, // Sesuaikan ukuran gambar robot
                      width: 300 * fem, // Sesuaikan ukuran gambar robot
                    ),
                  ),
                  
                  // Question Text
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0 * fem),
                        child: Text(
                          '“Aplikasi ini hanya digunakan untuk mendeteksi dini gangguan mental dan masih diperlukan konsultasi lebih lanjut ke pakar”',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: fontSizeText.clamp(14, 18), // Menyesuaikan ukuran font
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFC63033),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Next Button
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0 * fem),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'LoginPage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004AAD),
                        shape: const CircleBorder(),
                        padding: EdgeInsets.all(22 * fem),
                      ),
                      child: Image.asset(
                        'assets/icons/arrow_icon.png', // Ganti dengan path ke gambar ikon
                        height: 25.0 * fem, // Sesuaikan ukuran gambar ikon
                        width: 25.0 * fem, // Sesuaikan ukuran gambar ikon
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

