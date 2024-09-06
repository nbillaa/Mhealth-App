import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TentangKamiScreen extends StatelessWidget {
  const TentangKamiScreen({super.key});
  static String routeName = 'TentangKami';

  @override
  Widget build(BuildContext context) {
    // Dapatkan ukuran layar saat ini
    final screenSize = MediaQuery.of(context).size;
    final fem = screenSize.width / 375; // Asumsikan 375 sebagai lebar standar untuk perhitungan skala
    final fontFem = fem * 0.97; // Skala tambahan untuk font

    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3FBFC),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xFF004AAD), size: 24 * fem),
          onPressed: () {
            Navigator.pushNamed(context, 'SettingsScreen');
          },
        ),
        title: Text(
          'Tentang Kami',
          style: GoogleFonts.poppins(
            fontSize: 20 * fontFem,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF004AAD),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0 * fem),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20 * fem),
                Image.asset('assets/images/logo_biru.png', height: 68.0 * fem),
                SizedBox(height: 20 * fem),
                Text(
                  'M-Health Detection',
                  style: GoogleFonts.poppins(
                    fontSize: 24 * fontFem,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF004AAD),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20 * fem),
                _buildInfoCard(
                  icon: Icons.favorite,
                  color: const Color(0xFFDBDBF4),
                  text:
                      'M-Health Detection adalah aplikasi untuk mendeteksi dini gangguan kesehatan mental pada remaja.',
                  fem: fem,
                  fontFem: fontFem,
                ),
                SizedBox(height: 20 * fem),
                _buildInfoCard(
                  imagePath: 'assets/icons/seacrh.png', // Ganti dengan path gambar yang sesuai
                  color: const Color(0xFFFFEEE2),
                  text:
                      'Gangguan mental yang dapat dideteksi antara lain Depresi, Anxiety, dan Bipolar.',
                  fem: fem,
                  fontFem: fontFem,
                ),
                SizedBox(height: 20 * fem),
                _buildInfoCard(
                  imagePath: 'assets/icons/warning.png', // Ganti dengan path gambar yang sesuai
                  color: const Color(0xFFFCE3E3),
                  text:
                      'Aplikasi ini hanya digunakan untuk mendeteksi dini dan tidak boleh digunakan untuk self diagnose.',
                  fem: fem,
                  fontFem: fontFem,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    IconData? icon,
    String? imagePath,
    required Color color,
    required String text,
    required double fem,
    required double fontFem,
  }) {
    return Container(
      padding: EdgeInsets.all(15.0 * fem),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0 * fem),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0 * fem,
            offset: Offset(0, 2 * fem),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20 * fem,
            backgroundColor: color,
            child: imagePath != null
                ? Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 30 * fem,
                    height: 30 * fem,
                  )
                : Icon(
                    icon,
                    color: const Color(0xFF4949C9),
                    size: 24 * fem,
                  ),
          ),
          SizedBox(width: 16 * fem),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14 * fontFem,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF004AAD),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
