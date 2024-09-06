import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tahap1Page extends StatelessWidget {
  static String routeName = 'Tahap1Page';
  const Tahap1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgtahap1.png', // Sesuaikan path gambar
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Stage Indicator
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      'Tahap 1',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF004AAD),
                      ),
                    ),
                  ),
                  const Spacer(flex: 7),
                  // Progress Indicator
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          children: [
                            Container(
                              width: constraints.maxWidth * 0.5, // Adjust this value as needed
                              decoration: BoxDecoration(
                                color: const Color(0xFF004AAD),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Question Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Pertanyaan Gejala berdasarkan Emosi atau Perasaan',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF004AAD),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  // Next Button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'PertanyaanPage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004AAD),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: Image.asset(
                        'assets/icons/arrow_icon.png', // Ganti dengan path ke gambar ikon
                        height: 35.0, // Sesuaikan ukuran gambar ikon
                        width: 35.0, // Sesuaikan ukuran gambar ikon
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
