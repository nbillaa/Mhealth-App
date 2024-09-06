import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LupaPasswordScreen extends StatelessWidget {
  const LupaPasswordScreen({super.key});
  static String routeName = 'LupaPasswordScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3FBFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004AAD)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lupa Password',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF004AAD),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Klik untuk mengatur kembali kata sandi',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF004AAD),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Aksi ketika tombol "Kirim Kode ke email" ditekan
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(Icons.lock, color: Color(0xFF004AAD), size: 40),
                    const SizedBox(width: 20),
                    Text(
                      'Kirim Kode ke email',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF004AAD),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi ketika tombol "Send Password" ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Send Password',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

