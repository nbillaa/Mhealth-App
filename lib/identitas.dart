import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IdentitasPage extends StatelessWidget {
  static String routeName = 'IdentitasPage';

  const IdentitasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 360; // Base width for scaling

    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20 * fem), // Responsive padding
                  child: Image.asset(
                    'assets/images/logo_biru2.png',
                    height: 60 * fem, // Responsive height
                  ),
                ),
                SizedBox(height: 20 * fem), // Responsive spacing
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18 * fem),
                  child: Text(
                    'Hayuk, lengkapi identitasmu terlebih dahulu 😇✨',
                    style: GoogleFonts.poppins(
                      fontSize: 30 * fem, // Responsive font size
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF004AAD),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 90 * fem), // Responsive bottom padding
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'NamePage');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004AAD),
                padding: EdgeInsets.symmetric(horizontal: 100 * fem, vertical: 12 * fem), // Responsive padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30 * fem), // Responsive border radius
                ),
              ),
              child: Text(
                'Yuks mulai !!!',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18 * fem, // Responsive font size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
